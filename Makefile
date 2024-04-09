LLC ?= llc
CLANG ?= clang
CC ?= gcc

LIBBPF_DIR = libbpf/src
LIBBPF = $(LIBBPF_DIR)/libbpf.a

CFLAGS ?= -I$(LIBBPF_DIR)/build/usr/include/ -g
CFLAGS += -I../headers/
LDFLAGS ?= -L$(LIBBPF_DIR)

LIBS = -l:libbpf.a -lelf

BPF_CFLAGS ?= -I$(LIBBPF_DIR)/build/usr/include/ -I../headers/
BPF_CFLAGS += -Wall -Wextra

.PHONY: all clean

all: switch.o ingress.o egress.o

clean:
	rm -rf $(LIBBPF_DIR)/build
	rm ./*.ll ./*.o
	$(MAKE) -C $(LIBBPF_DIR) clean

$(LIBBPF):
	@if [ ! -d $(LIBBPF_DIR) ]; then \
		echo "libbpf not found, try \`git submodule update --init'"; \
		exit 1; \
	else \
		cd $(LIBBPF_DIR) && $(MAKE) all; \
		mkdir -p build; DESTDIR=build $(MAKE) install_headers; \
	fi


switch.o: tools.c tools.h bloom.c bloom.h ./switch/switch.c
	$(CLANG) -S -target bpf $(BPF_CFLAGS) -O3 -emit-llvm -c -g -o ${@:.o=.ll} $<
	$(LLC) -march=bpf -filetype=obj -o $@ ${@:.o=.ll}

ingress.o: tools.c tools.h ./server/server.h ./server/ingress.c
	$(CLANG) -S -target bpf $(BPF_CFLAGS) -O3 -emit-llvm -c -g -o ${@:.o=.ll} $<
	$(LLC) -march=bpf -filetype=obj -o $@ ${@:.o=.ll}

egress.o: tools.c tools.h ./server/server.h ./server/egress.c
	$(CLANG) -S -target bpf $(BPF_CFLAGS) -O3 -emit-llvm -c -g -o ${@:.o=.ll} $<
	$(LLC) -march=bpf -filetype=obj -o $@ ${@:.o=.ll}