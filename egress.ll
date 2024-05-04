; ModuleID = 'server/egress.c'
source_filename = "server/egress.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

%struct.anon.3 = type { [1 x i32]*, [10000 x i32]*, %struct.pkt_4tuple*, i32*, [1 x i32]* }
%struct.pkt_4tuple = type { i32, i32, i16, i16 }
%struct.__sk_buff = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, [5 x i32], i32, i32, i32, i32, i32, i32, i32, i32, [4 x i32], [4 x i32], i32, i32, i32, %union.anon, i64, i32, i32, %union.anon.2 }
%union.anon = type { %struct.bpf_flow_keys* }
%struct.bpf_flow_keys = type { i16, i16, i16, i8, i8, i8, i8, i16, i16, i16, %union.anon.0, i32, i32 }
%union.anon.0 = type { %struct.anon.1 }
%struct.anon.1 = type { [4 x i32], [4 x i32] }
%union.anon.2 = type { %struct.bpf_sock* }
%struct.bpf_sock = type { i32, i32, i32, i32, i32, i32, i32, [4 x i32], i32, i16, i16, i32, [4 x i32], i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.iphdr = type { i8, i8, i16, i16, i16, i8, i8, i16, i32, i32 }
%struct.tcphdr = type { i16, i16, i32, i32, i16, i16, i16, i16 }

@key0 = dso_local local_unnamed_addr constant i32 858927408, align 4, !dbg !0
@key1 = dso_local local_unnamed_addr constant i32 1111570744, align 4, !dbg !72
@c0 = dso_local local_unnamed_addr constant i32 1886610805, align 4, !dbg !77
@c1 = dso_local local_unnamed_addr constant i32 1852075885, align 4, !dbg !79
@c2 = dso_local local_unnamed_addr constant i32 1852142177, align 4, !dbg !81
@c3 = dso_local local_unnamed_addr constant i32 2037671283, align 4, !dbg !83
@array_map = dso_local global %struct.anon.3 zeroinitializer, section ".maps", align 8, !dbg !91
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !85
@llvm.used = appending global [3 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon.3* @array_map to i8*), i8* bitcast (i32 (%struct.__sk_buff*)* @tc_egress to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @tc_egress(%struct.__sk_buff* %0) #0 section "prog" !dbg !248 {
  %2 = alloca %struct.pkt_4tuple, align 4
  %3 = alloca i32, align 4
  %4 = alloca i16, align 2
  %5 = alloca i16, align 2
  %6 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.__sk_buff* %0, metadata !252, metadata !DIExpression()), !dbg !311
  %7 = getelementptr inbounds %struct.__sk_buff, %struct.__sk_buff* %0, i64 0, i32 16, !dbg !312
  %8 = load i32, i32* %7, align 8, !dbg !312, !tbaa !313
  %9 = zext i32 %8 to i64, !dbg !319
  %10 = inttoptr i64 %9 to i8*, !dbg !320
  call void @llvm.dbg.value(metadata i8* %10, metadata !253, metadata !DIExpression()), !dbg !311
  %11 = getelementptr inbounds %struct.__sk_buff, %struct.__sk_buff* %0, i64 0, i32 15, !dbg !321
  %12 = load i32, i32* %11, align 4, !dbg !321, !tbaa !322
  %13 = zext i32 %12 to i64, !dbg !323
  %14 = inttoptr i64 %13 to i8*, !dbg !324
  call void @llvm.dbg.value(metadata i8* %14, metadata !254, metadata !DIExpression()), !dbg !311
  %15 = inttoptr i64 %13 to %struct.ethhdr*, !dbg !325
  call void @llvm.dbg.value(metadata %struct.ethhdr* %15, metadata !255, metadata !DIExpression()), !dbg !311
  %16 = getelementptr i8, i8* %14, i64 14, !dbg !326
  %17 = icmp ugt i8* %16, %10, !dbg !328
  br i1 %17, label %240, label %18, !dbg !329

18:                                               ; preds = %1
  %19 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %15, i64 0, i32 2, !dbg !330
  %20 = load i16, i16* %19, align 1, !dbg !330, !tbaa !332
  %21 = icmp eq i16 %20, 8, !dbg !335
  br i1 %21, label %22, label %241, !dbg !336

22:                                               ; preds = %18
  call void @llvm.dbg.value(metadata i8* %16, metadata !266, metadata !DIExpression()), !dbg !311
  %23 = getelementptr i8, i8* %14, i64 414, !dbg !337
  %24 = bitcast i8* %23 to %struct.iphdr*, !dbg !337
  %25 = inttoptr i64 %9 to %struct.iphdr*, !dbg !339
  %26 = icmp ugt %struct.iphdr* %24, %25, !dbg !340
  br i1 %26, label %240, label %27, !dbg !341

27:                                               ; preds = %22
  %28 = getelementptr i8, i8* %14, i64 23, !dbg !342
  %29 = load i8, i8* %28, align 1, !dbg !342, !tbaa !344
  %30 = icmp eq i8 %29, 17, !dbg !346
  br i1 %30, label %241, label %31, !dbg !347

31:                                               ; preds = %27
  call void @llvm.dbg.value(metadata i8* %23, metadata !267, metadata !DIExpression()), !dbg !311
  %32 = getelementptr i8, i8* %14, i64 814, !dbg !348
  %33 = bitcast i8* %32 to %struct.tcphdr*, !dbg !348
  %34 = inttoptr i64 %9 to %struct.tcphdr*, !dbg !350
  %35 = icmp ugt %struct.tcphdr* %33, %34, !dbg !351
  br i1 %35, label %240, label %36, !dbg !352

36:                                               ; preds = %31
  call void @llvm.dbg.declare(metadata %struct.pkt_4tuple* %2, metadata !289, metadata !DIExpression()), !dbg !353
  %37 = getelementptr i8, i8* %14, i64 30, !dbg !354
  %38 = bitcast i8* %37 to i32*, !dbg !354
  %39 = load i32, i32* %38, align 4, !dbg !354, !tbaa !355
  %40 = getelementptr i8, i8* %14, i64 26, !dbg !356
  %41 = bitcast i8* %40 to i32*, !dbg !356
  %42 = load i32, i32* %41, align 4, !dbg !356, !tbaa !357
  %43 = getelementptr i8, i8* %14, i64 416, !dbg !358
  %44 = bitcast i8* %43 to i16*, !dbg !358
  %45 = load i16, i16* %44, align 2, !dbg !358, !tbaa !359
  %46 = bitcast i8* %23 to i16*, !dbg !361
  %47 = load i16, i16* %46, align 4, !dbg !361, !tbaa !362
  call void @llvm.dbg.value(metadata %struct.pkt_4tuple* %2, metadata !363, metadata !DIExpression()), !dbg !372
  call void @llvm.dbg.value(metadata i32 %39, metadata !368, metadata !DIExpression()), !dbg !372
  call void @llvm.dbg.value(metadata i32 %42, metadata !369, metadata !DIExpression()), !dbg !372
  call void @llvm.dbg.value(metadata i16 %45, metadata !370, metadata !DIExpression()), !dbg !372
  call void @llvm.dbg.value(metadata i16 %47, metadata !371, metadata !DIExpression()), !dbg !372
  %48 = getelementptr inbounds %struct.pkt_4tuple, %struct.pkt_4tuple* %2, i64 0, i32 0, !dbg !374
  store i32 %39, i32* %48, align 4, !dbg !375, !tbaa !376
  %49 = getelementptr inbounds %struct.pkt_4tuple, %struct.pkt_4tuple* %2, i64 0, i32 1, !dbg !378
  store i32 %42, i32* %49, align 4, !dbg !379, !tbaa !380
  %50 = getelementptr inbounds %struct.pkt_4tuple, %struct.pkt_4tuple* %2, i64 0, i32 2, !dbg !381
  store i16 %45, i16* %50, align 4, !dbg !382, !tbaa !383
  %51 = getelementptr inbounds %struct.pkt_4tuple, %struct.pkt_4tuple* %2, i64 0, i32 3, !dbg !384
  store i16 %47, i16* %51, align 2, !dbg !385, !tbaa !386
  %52 = bitcast %struct.pkt_4tuple* %2 to i8*, !dbg !387
  %53 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.3* @array_map to i8*), i8* nonnull %52) #3, !dbg !388
  call void @llvm.dbg.value(metadata i8* %53, metadata !290, metadata !DIExpression()), !dbg !311
  %54 = icmp eq i8* %53, null, !dbg !389
  br i1 %54, label %55, label %240, !dbg !390

55:                                               ; preds = %36
  %56 = bitcast i32* %3 to i8*, !dbg !391
  call void @llvm.dbg.value(metadata i32* %3, metadata !291, metadata !DIExpression(DW_OP_deref)), !dbg !311
  %57 = call i64 inttoptr (i64 113 to i64 (i8*, i32, i8*)*)(i8* nonnull %56, i32 4, i8* null) #3, !dbg !393
  %58 = icmp eq i64 %57, 0, !dbg !394
  br i1 %58, label %59, label %241, !dbg !395

59:                                               ; preds = %55
  %60 = getelementptr i8, i8* %14, i64 426, !dbg !396
  %61 = bitcast i8* %60 to i16*, !dbg !396
  %62 = load i16, i16* %61, align 4, !dbg !396
  %63 = and i16 %62, 4608, !dbg !397
  %64 = icmp eq i16 %63, 4608, !dbg !397
  br i1 %64, label %65, label %229, !dbg !397

65:                                               ; preds = %59
  call void @llvm.dbg.value(metadata i64 0, metadata !398, metadata !DIExpression()), !dbg !411
  %66 = load i8, i8* %40, align 1, !dbg !413, !tbaa !416
  call void @llvm.dbg.value(metadata i8 %66, metadata !407, metadata !DIExpression()), !dbg !417
  %67 = load i8, i8* %37, align 1, !dbg !418, !tbaa !416
  store i8 %67, i8* %40, align 1, !dbg !419, !tbaa !416
  store i8 %66, i8* %37, align 1, !dbg !420, !tbaa !416
  call void @llvm.dbg.value(metadata i64 1, metadata !398, metadata !DIExpression()), !dbg !411
  %68 = getelementptr i8, i8* %14, i64 27, !dbg !413
  %69 = load i8, i8* %68, align 1, !dbg !413, !tbaa !416
  call void @llvm.dbg.value(metadata i8 %69, metadata !407, metadata !DIExpression()), !dbg !417
  %70 = getelementptr i8, i8* %14, i64 31, !dbg !418
  %71 = load i8, i8* %70, align 1, !dbg !418, !tbaa !416
  store i8 %71, i8* %68, align 1, !dbg !419, !tbaa !416
  store i8 %69, i8* %70, align 1, !dbg !420, !tbaa !416
  call void @llvm.dbg.value(metadata i64 2, metadata !398, metadata !DIExpression()), !dbg !411
  %72 = getelementptr i8, i8* %14, i64 28, !dbg !413
  %73 = load i8, i8* %72, align 1, !dbg !413, !tbaa !416
  call void @llvm.dbg.value(metadata i8 %73, metadata !407, metadata !DIExpression()), !dbg !417
  %74 = getelementptr i8, i8* %14, i64 32, !dbg !418
  %75 = load i8, i8* %74, align 1, !dbg !418, !tbaa !416
  store i8 %75, i8* %72, align 1, !dbg !419, !tbaa !416
  store i8 %73, i8* %74, align 1, !dbg !420, !tbaa !416
  call void @llvm.dbg.value(metadata i64 3, metadata !398, metadata !DIExpression()), !dbg !411
  %76 = getelementptr i8, i8* %14, i64 29, !dbg !413
  %77 = load i8, i8* %76, align 1, !dbg !413, !tbaa !416
  call void @llvm.dbg.value(metadata i8 %77, metadata !407, metadata !DIExpression()), !dbg !417
  %78 = getelementptr i8, i8* %14, i64 33, !dbg !418
  %79 = load i8, i8* %78, align 1, !dbg !418, !tbaa !416
  store i8 %79, i8* %76, align 1, !dbg !419, !tbaa !416
  store i8 %77, i8* %78, align 1, !dbg !420, !tbaa !416
  call void @llvm.dbg.value(metadata i64 4, metadata !398, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 0, metadata !398, metadata !DIExpression()), !dbg !421
  %80 = load i8, i8* %23, align 1, !dbg !423, !tbaa !416
  call void @llvm.dbg.value(metadata i8 %80, metadata !407, metadata !DIExpression()), !dbg !424
  %81 = load i8, i8* %43, align 1, !dbg !425, !tbaa !416
  store i8 %81, i8* %23, align 1, !dbg !426, !tbaa !416
  store i8 %80, i8* %43, align 1, !dbg !427, !tbaa !416
  call void @llvm.dbg.value(metadata i64 1, metadata !398, metadata !DIExpression()), !dbg !421
  %82 = getelementptr i8, i8* %14, i64 415, !dbg !423
  %83 = load i8, i8* %82, align 1, !dbg !423, !tbaa !416
  call void @llvm.dbg.value(metadata i8 %83, metadata !407, metadata !DIExpression()), !dbg !424
  %84 = getelementptr i8, i8* %14, i64 417, !dbg !425
  %85 = load i8, i8* %84, align 1, !dbg !425, !tbaa !416
  store i8 %85, i8* %82, align 1, !dbg !426, !tbaa !416
  store i8 %83, i8* %84, align 1, !dbg !427, !tbaa !416
  call void @llvm.dbg.value(metadata i64 2, metadata !398, metadata !DIExpression()), !dbg !421
  call void @llvm.dbg.value(metadata i64 0, metadata !398, metadata !DIExpression()), !dbg !428
  %86 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %15, i64 0, i32 1, i64 0, !dbg !430
  %87 = load i8, i8* %86, align 1, !dbg !430, !tbaa !416
  call void @llvm.dbg.value(metadata i8 %87, metadata !407, metadata !DIExpression()), !dbg !431
  %88 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %15, i64 0, i32 0, i64 0, !dbg !432
  %89 = load i8, i8* %88, align 1, !dbg !432, !tbaa !416
  store i8 %89, i8* %86, align 1, !dbg !433, !tbaa !416
  store i8 %87, i8* %88, align 1, !dbg !434, !tbaa !416
  call void @llvm.dbg.value(metadata i64 1, metadata !398, metadata !DIExpression()), !dbg !428
  %90 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %15, i64 0, i32 1, i64 1, !dbg !430
  %91 = load i8, i8* %90, align 1, !dbg !430, !tbaa !416
  call void @llvm.dbg.value(metadata i8 %91, metadata !407, metadata !DIExpression()), !dbg !431
  %92 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %15, i64 0, i32 0, i64 1, !dbg !432
  %93 = load i8, i8* %92, align 1, !dbg !432, !tbaa !416
  store i8 %93, i8* %90, align 1, !dbg !433, !tbaa !416
  store i8 %91, i8* %92, align 1, !dbg !434, !tbaa !416
  call void @llvm.dbg.value(metadata i64 2, metadata !398, metadata !DIExpression()), !dbg !428
  %94 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %15, i64 0, i32 1, i64 2, !dbg !430
  %95 = load i8, i8* %94, align 1, !dbg !430, !tbaa !416
  call void @llvm.dbg.value(metadata i8 %95, metadata !407, metadata !DIExpression()), !dbg !431
  %96 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %15, i64 0, i32 0, i64 2, !dbg !432
  %97 = load i8, i8* %96, align 1, !dbg !432, !tbaa !416
  store i8 %97, i8* %94, align 1, !dbg !433, !tbaa !416
  store i8 %95, i8* %96, align 1, !dbg !434, !tbaa !416
  call void @llvm.dbg.value(metadata i64 3, metadata !398, metadata !DIExpression()), !dbg !428
  %98 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %15, i64 0, i32 1, i64 3, !dbg !430
  %99 = load i8, i8* %98, align 1, !dbg !430, !tbaa !416
  call void @llvm.dbg.value(metadata i8 %99, metadata !407, metadata !DIExpression()), !dbg !431
  %100 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %15, i64 0, i32 0, i64 3, !dbg !432
  %101 = load i8, i8* %100, align 1, !dbg !432, !tbaa !416
  store i8 %101, i8* %98, align 1, !dbg !433, !tbaa !416
  store i8 %99, i8* %100, align 1, !dbg !434, !tbaa !416
  call void @llvm.dbg.value(metadata i64 4, metadata !398, metadata !DIExpression()), !dbg !428
  %102 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %15, i64 0, i32 1, i64 4, !dbg !430
  %103 = load i8, i8* %102, align 1, !dbg !430, !tbaa !416
  call void @llvm.dbg.value(metadata i8 %103, metadata !407, metadata !DIExpression()), !dbg !431
  %104 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %15, i64 0, i32 0, i64 4, !dbg !432
  %105 = load i8, i8* %104, align 1, !dbg !432, !tbaa !416
  store i8 %105, i8* %102, align 1, !dbg !433, !tbaa !416
  store i8 %103, i8* %104, align 1, !dbg !434, !tbaa !416
  call void @llvm.dbg.value(metadata i64 5, metadata !398, metadata !DIExpression()), !dbg !428
  %106 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %15, i64 0, i32 1, i64 5, !dbg !430
  %107 = load i8, i8* %106, align 1, !dbg !430, !tbaa !416
  call void @llvm.dbg.value(metadata i8 %107, metadata !407, metadata !DIExpression()), !dbg !431
  %108 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %15, i64 0, i32 0, i64 5, !dbg !432
  %109 = load i8, i8* %108, align 1, !dbg !432, !tbaa !416
  store i8 %109, i8* %106, align 1, !dbg !433, !tbaa !416
  store i8 %107, i8* %108, align 1, !dbg !434, !tbaa !416
  call void @llvm.dbg.value(metadata i64 6, metadata !398, metadata !DIExpression()), !dbg !428
  %110 = load i16, i16* %61, align 4, !dbg !435
  %111 = and i16 %110, -753, !dbg !436
  %112 = or i16 %111, 80, !dbg !436
  store i16 %112, i16* %61, align 4, !dbg !436
  %113 = getelementptr i8, i8* %14, i64 422, !dbg !437
  %114 = bitcast i8* %113 to i32*, !dbg !437
  %115 = load i32, i32* %114, align 4, !dbg !437, !tbaa !438
  call void @llvm.dbg.value(metadata i32 %115, metadata !295, metadata !DIExpression()), !dbg !439
  %116 = getelementptr i8, i8* %14, i64 418, !dbg !440
  %117 = bitcast i8* %116 to i32*, !dbg !440
  %118 = load i32, i32* %117, align 4, !dbg !440, !tbaa !441
  call void @llvm.dbg.value(metadata i32 %118, metadata !442, metadata !DIExpression()) #3, !dbg !449
  %119 = call i32 @llvm.bswap.i32(i32 %118) #3, !dbg !451
  %120 = add i32 %119, 1, !dbg !440
  call void @llvm.dbg.value(metadata i32 %120, metadata !442, metadata !DIExpression()) #3, !dbg !452
  %121 = call i32 @llvm.bswap.i32(i32 %120) #3, !dbg !454
  store i32 %121, i32* %114, align 4, !dbg !455, !tbaa !438
  store i32 %115, i32* %117, align 4, !dbg !456, !tbaa !441
  %122 = getelementptr i8, i8* %14, i64 428, !dbg !457
  %123 = bitcast i8* %122 to i16*, !dbg !457
  store i16 -2559, i16* %123, align 2, !dbg !458, !tbaa !459
  %124 = load i32, i32* %3, align 4, !dbg !460, !tbaa !461
  call void @llvm.dbg.value(metadata i32 %124, metadata !291, metadata !DIExpression()), !dbg !311
  call void @llvm.dbg.value(metadata i32 %121, metadata !442, metadata !DIExpression()) #3, !dbg !462
  %125 = sub i32 %124, %120, !dbg !464
  call void @llvm.dbg.value(metadata i32 %125, metadata !291, metadata !DIExpression()), !dbg !311
  store i32 %125, i32* %3, align 4, !dbg !465, !tbaa !461
  call void @llvm.dbg.value(metadata i32* %3, metadata !291, metadata !DIExpression(DW_OP_deref)), !dbg !311
  %126 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.anon.3* @array_map to i8*), i8* nonnull %52, i8* nonnull %56, i64 0) #3, !dbg !466
  %127 = getelementptr i8, i8* %14, i64 34, !dbg !467
  %128 = bitcast i8* %127 to i16*, !dbg !468
  %129 = load i32, i32* %41, align 4, !dbg !469, !tbaa !357
  %130 = load i32, i32* %38, align 4, !dbg !469, !tbaa !355
  call void @llvm.dbg.value(metadata i16* %128, metadata !470, metadata !DIExpression()), !dbg !486
  call void @llvm.dbg.value(metadata i8* %14, metadata !476, metadata !DIExpression()), !dbg !486
  call void @llvm.dbg.value(metadata i8* %10, metadata !477, metadata !DIExpression()), !dbg !486
  call void @llvm.dbg.value(metadata i64 0, metadata !478, metadata !DIExpression()), !dbg !486
  call void @llvm.dbg.value(metadata i16 20, metadata !479, metadata !DIExpression()), !dbg !486
  %131 = lshr i32 %129, 16, !dbg !488
  call void @llvm.dbg.value(metadata i32 %131, metadata !478, metadata !DIExpression()), !dbg !486
  %132 = and i32 %129, 65535, !dbg !489
  call void @llvm.dbg.value(metadata i32 undef, metadata !478, metadata !DIExpression()), !dbg !486
  %133 = lshr i32 %130, 16, !dbg !490
  %134 = and i32 %130, 65535, !dbg !491
  call void @llvm.dbg.value(metadata i32 undef, metadata !478, metadata !DIExpression(DW_OP_plus_uconst, 1536, DW_OP_stack_value)), !dbg !486
  %135 = add nuw nsw i32 %132, 6656, !dbg !492
  %136 = add nuw nsw i32 %135, %131, !dbg !493
  %137 = add nuw nsw i32 %136, %133, !dbg !494
  %138 = add nuw nsw i32 %137, %134, !dbg !495
  %139 = zext i32 %138 to i64, !dbg !495
  call void @llvm.dbg.value(metadata i64 %139, metadata !478, metadata !DIExpression()), !dbg !486
  call void @llvm.dbg.value(metadata i32 200, metadata !481, metadata !DIExpression()), !dbg !486
  call void @llvm.dbg.value(metadata i32 0, metadata !480, metadata !DIExpression()), !dbg !486
  call void @llvm.dbg.value(metadata i16 undef, metadata !479, metadata !DIExpression()), !dbg !486
  %140 = inttoptr i64 %9 to i16*, !dbg !496
  %141 = inttoptr i64 %13 to i16*, !dbg !496
  %142 = icmp ugt i16* %141, %128, !dbg !496
  %143 = getelementptr i8, i8* %14, i64 36, !dbg !501
  %144 = bitcast i8* %143 to i16*, !dbg !501
  %145 = icmp ugt i16* %144, %140, !dbg !502
  %146 = or i1 %142, %145, !dbg !503
  br i1 %146, label %167, label %147, !dbg !503

147:                                              ; preds = %65, %158
  %148 = phi i16* [ %163, %158 ], [ %144, %65 ]
  %149 = phi i32 [ %161, %158 ], [ 0, %65 ]
  %150 = phi i32 [ %162, %158 ], [ 20, %65 ]
  %151 = phi i64 [ %159, %158 ], [ %139, %65 ]
  %152 = phi i16* [ %148, %158 ], [ %128, %65 ]
  call void @llvm.dbg.value(metadata i32 %149, metadata !480, metadata !DIExpression()), !dbg !486
  call void @llvm.dbg.value(metadata i64 %151, metadata !478, metadata !DIExpression()), !dbg !486
  call void @llvm.dbg.value(metadata i16* %152, metadata !470, metadata !DIExpression()), !dbg !486
  %153 = icmp eq i32 %149, 8, !dbg !504
  br i1 %153, label %158, label %154, !dbg !506

154:                                              ; preds = %147
  %155 = load i16, i16* %152, align 2, !dbg !507, !tbaa !509
  %156 = zext i16 %155 to i64, !dbg !507
  %157 = add i64 %151, %156, !dbg !510
  call void @llvm.dbg.value(metadata i64 %157, metadata !478, metadata !DIExpression()), !dbg !486
  br label %158, !dbg !511

158:                                              ; preds = %154, %147
  %159 = phi i64 [ %157, %154 ], [ %151, %147 ], !dbg !486
  call void @llvm.dbg.value(metadata i64 %159, metadata !478, metadata !DIExpression()), !dbg !486
  call void @llvm.dbg.value(metadata i16* %148, metadata !470, metadata !DIExpression()), !dbg !486
  %160 = add nuw nsw i32 %150, 65534, !dbg !512
  call void @llvm.dbg.value(metadata i32 %160, metadata !479, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !486
  %161 = add nuw nsw i32 %149, 1, !dbg !513
  call void @llvm.dbg.value(metadata i32 %161, metadata !480, metadata !DIExpression()), !dbg !486
  %162 = and i32 %160, 65535, !dbg !514
  call void @llvm.dbg.value(metadata i16 undef, metadata !479, metadata !DIExpression()), !dbg !486
  %163 = getelementptr inbounds i16, i16* %148, i64 1, !dbg !501
  %164 = icmp ugt i16* %163, %140, !dbg !502
  %165 = icmp eq i32 %162, 0, !dbg !515
  %166 = or i1 %165, %164, !dbg !503
  br i1 %166, label %167, label %147, !dbg !503

167:                                              ; preds = %158, %65
  %168 = phi i16* [ %128, %65 ], [ %148, %158 ]
  %169 = phi i64 [ %139, %65 ], [ %159, %158 ]
  %170 = phi i1 [ %145, %65 ], [ %164, %158 ], !dbg !502
  %171 = phi i1 [ false, %65 ], [ %165, %158 ], !dbg !515
  call void @llvm.dbg.value(metadata i16* %168, metadata !470, metadata !DIExpression()), !dbg !486
  call void @llvm.dbg.value(metadata i64 %169, metadata !478, metadata !DIExpression()), !dbg !486
  call void @llvm.dbg.value(metadata i16* %168, metadata !470, metadata !DIExpression()), !dbg !486
  call void @llvm.dbg.value(metadata i64 %169, metadata !478, metadata !DIExpression()), !dbg !486
  call void @llvm.dbg.value(metadata i64 %169, metadata !478, metadata !DIExpression()), !dbg !486
  call void @llvm.dbg.value(metadata i64 %169, metadata !478, metadata !DIExpression()), !dbg !486
  call void @llvm.dbg.value(metadata i16* %168, metadata !470, metadata !DIExpression()), !dbg !486
  call void @llvm.dbg.value(metadata i16* %168, metadata !470, metadata !DIExpression()), !dbg !486
  %172 = icmp ult i16* %168, %141, !dbg !517
  %173 = or i1 %172, %170, !dbg !518
  %174 = or i1 %171, %173, !dbg !519
  br i1 %174, label %180, label %175, !dbg !519

175:                                              ; preds = %167
  %176 = load i16, i16* %168, align 2, !dbg !520, !tbaa !509
  call void @llvm.dbg.value(metadata i16 %176, metadata !482, metadata !DIExpression(DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !521
  %177 = shl i16 %176, 8, !dbg !522
  call void @llvm.dbg.value(metadata i16 %177, metadata !485, metadata !DIExpression()), !dbg !521
  %178 = zext i16 %177 to i64, !dbg !523
  %179 = add i64 %169, %178, !dbg !524
  call void @llvm.dbg.value(metadata i64 %179, metadata !478, metadata !DIExpression()), !dbg !486
  br label %180, !dbg !525

180:                                              ; preds = %175, %167
  %181 = phi i64 [ %169, %167 ], [ %179, %175 ]
  br label %182, !dbg !526

182:                                              ; preds = %180, %182
  %183 = phi i64 [ %189, %182 ], [ %181, %180 ]
  %184 = phi i32 [ %190, %182 ], [ 0, %180 ]
  call void @llvm.dbg.value(metadata i64 %183, metadata !478, metadata !DIExpression()), !dbg !486
  call void @llvm.dbg.value(metadata i32 %184, metadata !480, metadata !DIExpression()), !dbg !486
  %185 = lshr i64 %183, 16, !dbg !528
  %186 = icmp eq i64 %185, 0, !dbg !528
  %187 = and i64 %183, 65535, !dbg !532
  %188 = add nuw nsw i64 %187, %185, !dbg !532
  %189 = select i1 %186, i64 %183, i64 %188, !dbg !532
  call void @llvm.dbg.value(metadata i64 %189, metadata !478, metadata !DIExpression()), !dbg !486
  %190 = add nuw nsw i32 %184, 1, !dbg !533
  call void @llvm.dbg.value(metadata i32 %190, metadata !480, metadata !DIExpression()), !dbg !486
  %191 = icmp eq i32 %190, 200, !dbg !534
  br i1 %191, label %192, label %182, !dbg !526, !llvm.loop !535

192:                                              ; preds = %182
  call void @llvm.dbg.value(metadata i64 %189, metadata !478, metadata !DIExpression()), !dbg !486
  call void @llvm.dbg.value(metadata i64 %189, metadata !478, metadata !DIExpression(DW_OP_constu, 65535, DW_OP_xor, DW_OP_stack_value)), !dbg !486
  %193 = trunc i64 %189 to i16, !dbg !537
  %194 = xor i16 %193, -1, !dbg !537
  %195 = getelementptr i8, i8* %14, i64 430, !dbg !538
  %196 = bitcast i8* %195 to i16*, !dbg !538
  store i16 %194, i16* %196, align 4, !dbg !539, !tbaa !540
  %197 = getelementptr i8, i8* %14, i64 16, !dbg !541
  %198 = bitcast i8* %197 to i16*, !dbg !541
  %199 = load i16, i16* %198, align 2, !dbg !541, !tbaa !542
  call void @llvm.dbg.value(metadata i16 %199, metadata !298, metadata !DIExpression()), !dbg !439
  %200 = bitcast i16* %4 to i8*, !dbg !543
  call void @llvm.lifetime.start.p0i8(i64 2, i8* nonnull %200) #3, !dbg !543
  call void @llvm.dbg.value(metadata i16 10240, metadata !299, metadata !DIExpression()), !dbg !439
  store i16 10240, i16* %4, align 2, !dbg !544, !tbaa !509
  %201 = zext i16 %199 to i64, !dbg !545
  %202 = call i64 inttoptr (i64 10 to i64 (%struct.__sk_buff*, i32, i64, i64, i64)*)(%struct.__sk_buff* %0, i32 24, i64 %201, i64 10240, i64 2) #3, !dbg !547
  %203 = icmp slt i64 %202, 0, !dbg !548
  br i1 %203, label %226, label %204, !dbg !549

204:                                              ; preds = %192
  call void @llvm.dbg.value(metadata i16* %4, metadata !299, metadata !DIExpression(DW_OP_deref)), !dbg !439
  %205 = call i64 inttoptr (i64 9 to i64 (%struct.__sk_buff*, i32, i8*, i32, i64)*)(%struct.__sk_buff* %0, i32 16, i8* nonnull %200, i32 2, i64 0) #3, !dbg !550
  %206 = call i64 inttoptr (i64 13 to i64 (%struct.__sk_buff*, i32, i64)*)(%struct.__sk_buff* %0, i32 2, i64 1) #3, !dbg !551
  %207 = load i32, i32* %7, align 8, !dbg !552, !tbaa !313
  %208 = zext i32 %207 to i64, !dbg !553
  %209 = inttoptr i64 %208 to i8*, !dbg !554
  call void @llvm.dbg.value(metadata i8* %209, metadata !300, metadata !DIExpression()), !dbg !439
  %210 = load i32, i32* %11, align 4, !dbg !555, !tbaa !322
  %211 = zext i32 %210 to i64, !dbg !556
  %212 = inttoptr i64 %211 to i8*, !dbg !557
  call void @llvm.dbg.value(metadata i8* %212, metadata !301, metadata !DIExpression()), !dbg !439
  %213 = getelementptr i8, i8* %212, i64 54, !dbg !558
  %214 = icmp ugt i8* %213, %209, !dbg !560
  br i1 %214, label %226, label %215, !dbg !561

215:                                              ; preds = %204
  call void @llvm.dbg.value(metadata i8* %212, metadata !302, metadata !DIExpression()), !dbg !439
  call void @llvm.dbg.value(metadata i8* %212, metadata !303, metadata !DIExpression(DW_OP_plus_uconst, 14, DW_OP_stack_value)), !dbg !439
  call void @llvm.dbg.value(metadata i8* %212, metadata !304, metadata !DIExpression(DW_OP_plus_uconst, 34, DW_OP_stack_value)), !dbg !439
  call void @llvm.dbg.value(metadata i8 16, metadata !292, metadata !DIExpression()), !dbg !562
  %216 = getelementptr i8, i8* %212, i64 46, !dbg !563
  %217 = bitcast i8* %216 to i16*, !dbg !564
  call void @llvm.dbg.value(metadata i16* %217, metadata !305, metadata !DIExpression()), !dbg !439
  %218 = bitcast i16* %5 to i8*, !dbg !565
  call void @llvm.lifetime.start.p0i8(i64 2, i8* nonnull %218) #3, !dbg !565
  call void @llvm.dbg.value(metadata i16 16464, metadata !307, metadata !DIExpression()), !dbg !439
  store i16 16464, i16* %5, align 2, !dbg !566, !tbaa !509
  %219 = load i16, i16* %217, align 2, !dbg !567, !tbaa !509
  %220 = zext i16 %219 to i64, !dbg !567
  %221 = call i64 inttoptr (i64 11 to i64 (%struct.__sk_buff*, i32, i64, i64, i64)*)(%struct.__sk_buff* nonnull %0, i32 50, i64 %220, i64 16464, i64 18) #3, !dbg !569
  %222 = icmp slt i64 %221, 0, !dbg !570
  br i1 %222, label %227, label %223, !dbg !571

223:                                              ; preds = %215
  call void @llvm.dbg.value(metadata i16* %5, metadata !307, metadata !DIExpression(DW_OP_deref)), !dbg !439
  %224 = call i64 inttoptr (i64 9 to i64 (%struct.__sk_buff*, i32, i8*, i32, i64)*)(%struct.__sk_buff* nonnull %0, i32 46, i8* nonnull %218, i32 2, i64 0) #3, !dbg !572
  %225 = icmp slt i64 %224, 0, !dbg !574
  br i1 %225, label %227, label %228

226:                                              ; preds = %192, %204
  call void @llvm.lifetime.end.p0i8(i64 2, i8* nonnull %200) #3, !dbg !575
  br label %240

227:                                              ; preds = %215, %223
  call void @llvm.lifetime.end.p0i8(i64 2, i8* nonnull %218) #3, !dbg !575
  call void @llvm.lifetime.end.p0i8(i64 2, i8* nonnull %200) #3, !dbg !575
  br label %240

228:                                              ; preds = %223
  call void @llvm.lifetime.end.p0i8(i64 2, i8* nonnull %218) #3, !dbg !575
  call void @llvm.lifetime.end.p0i8(i64 2, i8* nonnull %200) #3, !dbg !575
  br label %241

229:                                              ; preds = %59
  call void @llvm.dbg.value(metadata i8 16, metadata !292, metadata !DIExpression()), !dbg !562
  %230 = bitcast i32* %6 to i8*, !dbg !576
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %230) #3, !dbg !576
  %231 = getelementptr i8, i8* %14, i64 418, !dbg !577
  %232 = bitcast i8* %231 to i32*, !dbg !577
  %233 = load i32, i32* %232, align 4, !dbg !577, !tbaa !441
  call void @llvm.dbg.value(metadata i32 %233, metadata !442, metadata !DIExpression()) #3, !dbg !578
  %234 = call i32 @llvm.bswap.i32(i32 %233) #3, !dbg !580
  %235 = load i32, i32* %3, align 4, !dbg !577, !tbaa !461
  call void @llvm.dbg.value(metadata i32 %235, metadata !291, metadata !DIExpression()), !dbg !311
  %236 = add i32 %234, %235, !dbg !577
  call void @llvm.dbg.value(metadata i32 %236, metadata !442, metadata !DIExpression()) #3, !dbg !581
  %237 = call i32 @llvm.bswap.i32(i32 %236) #3, !dbg !583
  call void @llvm.dbg.value(metadata i32 %237, metadata !308, metadata !DIExpression()), !dbg !584
  store i32 %237, i32* %6, align 4, !dbg !585, !tbaa !461
  call void @llvm.dbg.value(metadata i32* %6, metadata !308, metadata !DIExpression(DW_OP_deref)), !dbg !584
  %238 = call i64 inttoptr (i64 9 to i64 (%struct.__sk_buff*, i32, i8*, i32, i64)*)(%struct.__sk_buff* nonnull %0, i32 38, i8* nonnull %230, i32 4, i64 1) #3, !dbg !586
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %230) #3, !dbg !588
  %239 = icmp sgt i64 %238, -1
  br i1 %239, label %241, label %240

240:                                              ; preds = %229, %227, %226, %36, %31, %22, %1
  call void @llvm.dbg.label(metadata !310), !dbg !589
  br label %241, !dbg !590

241:                                              ; preds = %228, %229, %55, %27, %18, %240
  %242 = phi i32 [ 2, %240 ], [ 0, %18 ], [ 0, %27 ], [ -1, %55 ], [ 0, %229 ], [ 0, %228 ], !dbg !311
  ret i32 %242, !dbg !591
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.bswap.i32(i32) #1

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nounwind willreturn }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!244, !245, !246}
!llvm.ident = !{!247}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "key0", scope: !2, file: !74, line: 38, type: !75, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !35, globals: !71, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "server/egress.c", directory: "/home/intro_cn/Downloads/xdp-router")
!4 = !{!5}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !6, line: 40, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "/usr/include/netinet/in.h", directory: "")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13, !14, !15, !16, !17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28, !29, !30, !31, !32, !33, !34}
!9 = !DIEnumerator(name: "IPPROTO_IP", value: 0, isUnsigned: true)
!10 = !DIEnumerator(name: "IPPROTO_ICMP", value: 1, isUnsigned: true)
!11 = !DIEnumerator(name: "IPPROTO_IGMP", value: 2, isUnsigned: true)
!12 = !DIEnumerator(name: "IPPROTO_IPIP", value: 4, isUnsigned: true)
!13 = !DIEnumerator(name: "IPPROTO_TCP", value: 6, isUnsigned: true)
!14 = !DIEnumerator(name: "IPPROTO_EGP", value: 8, isUnsigned: true)
!15 = !DIEnumerator(name: "IPPROTO_PUP", value: 12, isUnsigned: true)
!16 = !DIEnumerator(name: "IPPROTO_UDP", value: 17, isUnsigned: true)
!17 = !DIEnumerator(name: "IPPROTO_IDP", value: 22, isUnsigned: true)
!18 = !DIEnumerator(name: "IPPROTO_TP", value: 29, isUnsigned: true)
!19 = !DIEnumerator(name: "IPPROTO_DCCP", value: 33, isUnsigned: true)
!20 = !DIEnumerator(name: "IPPROTO_IPV6", value: 41, isUnsigned: true)
!21 = !DIEnumerator(name: "IPPROTO_RSVP", value: 46, isUnsigned: true)
!22 = !DIEnumerator(name: "IPPROTO_GRE", value: 47, isUnsigned: true)
!23 = !DIEnumerator(name: "IPPROTO_ESP", value: 50, isUnsigned: true)
!24 = !DIEnumerator(name: "IPPROTO_AH", value: 51, isUnsigned: true)
!25 = !DIEnumerator(name: "IPPROTO_MTP", value: 92, isUnsigned: true)
!26 = !DIEnumerator(name: "IPPROTO_BEETPH", value: 94, isUnsigned: true)
!27 = !DIEnumerator(name: "IPPROTO_ENCAP", value: 98, isUnsigned: true)
!28 = !DIEnumerator(name: "IPPROTO_PIM", value: 103, isUnsigned: true)
!29 = !DIEnumerator(name: "IPPROTO_COMP", value: 108, isUnsigned: true)
!30 = !DIEnumerator(name: "IPPROTO_SCTP", value: 132, isUnsigned: true)
!31 = !DIEnumerator(name: "IPPROTO_UDPLITE", value: 136, isUnsigned: true)
!32 = !DIEnumerator(name: "IPPROTO_MPLS", value: 137, isUnsigned: true)
!33 = !DIEnumerator(name: "IPPROTO_RAW", value: 255, isUnsigned: true)
!34 = !DIEnumerator(name: "IPPROTO_MAX", value: 256, isUnsigned: true)
!35 = !{!36, !37, !38, !39, !64, !66, !69, !67}
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!37 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!38 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!39 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !40, size: 64)
!40 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !41, line: 86, size: 160, elements: !42)
!41 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "")
!42 = !{!43, !47, !48, !49, !54, !55, !56, !57, !58, !60, !63}
!43 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !40, file: !41, line: 88, baseType: !44, size: 4, flags: DIFlagBitField, extraData: i64 0)
!44 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !45, line: 21, baseType: !46)
!45 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "")
!46 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!47 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !40, file: !41, line: 89, baseType: !44, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!48 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !40, file: !41, line: 96, baseType: !44, size: 8, offset: 8)
!49 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !40, file: !41, line: 97, baseType: !50, size: 16, offset: 16)
!50 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !51, line: 25, baseType: !52)
!51 = !DIFile(filename: "/usr/include/linux/types.h", directory: "")
!52 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !45, line: 24, baseType: !53)
!53 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!54 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !40, file: !41, line: 98, baseType: !50, size: 16, offset: 32)
!55 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !40, file: !41, line: 99, baseType: !50, size: 16, offset: 48)
!56 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !40, file: !41, line: 100, baseType: !44, size: 8, offset: 64)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !40, file: !41, line: 101, baseType: !44, size: 8, offset: 72)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !40, file: !41, line: 102, baseType: !59, size: 16, offset: 80)
!59 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !51, line: 31, baseType: !52)
!60 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !40, file: !41, line: 103, baseType: !61, size: 32, offset: 96)
!61 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !51, line: 27, baseType: !62)
!62 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !45, line: 27, baseType: !7)
!63 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !40, file: !41, line: 104, baseType: !61, size: 32, offset: 128)
!64 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !65, line: 40, baseType: !53)
!65 = !DIFile(filename: "/usr/include/bits/types.h", directory: "")
!66 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !67, size: 64)
!67 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !68, line: 25, baseType: !64)
!68 = !DIFile(filename: "/usr/include/bits/stdint-uintn.h", directory: "")
!69 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !68, line: 24, baseType: !70)
!70 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !65, line: 38, baseType: !46)
!71 = !{!0, !72, !77, !79, !81, !83, !85, !91, !118, !126, !131, !138, !232, !237, !242}
!72 = !DIGlobalVariableExpression(var: !73, expr: !DIExpression())
!73 = distinct !DIGlobalVariable(name: "key1", scope: !2, file: !74, line: 39, type: !75, isLocal: false, isDefinition: true)
!74 = !DIFile(filename: "server/../tools.h", directory: "/home/intro_cn/Downloads/xdp-router")
!75 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !76)
!76 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!77 = !DIGlobalVariableExpression(var: !78, expr: !DIExpression())
!78 = distinct !DIGlobalVariable(name: "c0", scope: !2, file: !74, line: 40, type: !75, isLocal: false, isDefinition: true)
!79 = !DIGlobalVariableExpression(var: !80, expr: !DIExpression())
!80 = distinct !DIGlobalVariable(name: "c1", scope: !2, file: !74, line: 41, type: !75, isLocal: false, isDefinition: true)
!81 = !DIGlobalVariableExpression(var: !82, expr: !DIExpression())
!82 = distinct !DIGlobalVariable(name: "c2", scope: !2, file: !74, line: 42, type: !75, isLocal: false, isDefinition: true)
!83 = !DIGlobalVariableExpression(var: !84, expr: !DIExpression())
!84 = distinct !DIGlobalVariable(name: "c3", scope: !2, file: !74, line: 43, type: !75, isLocal: false, isDefinition: true)
!85 = !DIGlobalVariableExpression(var: !86, expr: !DIExpression())
!86 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 77, type: !87, isLocal: false, isDefinition: true)
!87 = !DICompositeType(tag: DW_TAG_array_type, baseType: !88, size: 32, elements: !89)
!88 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!89 = !{!90}
!90 = !DISubrange(count: 4)
!91 = !DIGlobalVariableExpression(var: !92, expr: !DIExpression())
!92 = distinct !DIGlobalVariable(name: "array_map", scope: !2, file: !93, line: 26, type: !94, isLocal: false, isDefinition: true)
!93 = !DIFile(filename: "server/server.h", directory: "/home/intro_cn/Downloads/xdp-router")
!94 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !93, line: 20, size: 320, elements: !95)
!95 = !{!96, !101, !106, !115, !117}
!96 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !94, file: !93, line: 21, baseType: !97, size: 64)
!97 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !98, size: 64)
!98 = !DICompositeType(tag: DW_TAG_array_type, baseType: !76, size: 32, elements: !99)
!99 = !{!100}
!100 = !DISubrange(count: 1)
!101 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !94, file: !93, line: 22, baseType: !102, size: 64, offset: 64)
!102 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !103, size: 64)
!103 = !DICompositeType(tag: DW_TAG_array_type, baseType: !76, size: 320000, elements: !104)
!104 = !{!105}
!105 = !DISubrange(count: 10000)
!106 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !94, file: !93, line: 23, baseType: !107, size: 64, offset: 128)
!107 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !108, size: 64)
!108 = !DIDerivedType(tag: DW_TAG_typedef, name: "map_key", file: !93, line: 17, baseType: !109)
!109 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "pkt_4tuple", file: !93, line: 11, size: 96, elements: !110)
!110 = !{!111, !112, !113, !114}
!111 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !109, file: !93, line: 13, baseType: !7, size: 32)
!112 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !109, file: !93, line: 14, baseType: !7, size: 32, offset: 32)
!113 = !DIDerivedType(tag: DW_TAG_member, name: "src", scope: !109, file: !93, line: 15, baseType: !53, size: 16, offset: 64)
!114 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !109, file: !93, line: 16, baseType: !53, size: 16, offset: 80)
!115 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !94, file: !93, line: 24, baseType: !116, size: 64, offset: 192)
!116 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!117 = !DIDerivedType(tag: DW_TAG_member, name: "pinning", scope: !94, file: !93, line: 25, baseType: !97, size: 64, offset: 256)
!118 = !DIGlobalVariableExpression(var: !119, expr: !DIExpression())
!119 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !120, line: 50, type: !121, isLocal: true, isDefinition: true)
!120 = !DIFile(filename: "/usr/include/bpf/bpf_helper_defs.h", directory: "")
!121 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !122, size: 64)
!122 = !DISubroutineType(types: !123)
!123 = !{!36, !36, !124}
!124 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !125, size: 64)
!125 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!126 = !DIGlobalVariableExpression(var: !127, expr: !DIExpression())
!127 = distinct !DIGlobalVariable(name: "bpf_probe_read_kernel", scope: !2, file: !120, line: 2751, type: !128, isLocal: true, isDefinition: true)
!128 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !129, size: 64)
!129 = !DISubroutineType(types: !130)
!130 = !{!37, !36, !62, !124}
!131 = !DIGlobalVariableExpression(var: !132, expr: !DIExpression())
!132 = distinct !DIGlobalVariable(name: "bpf_map_update_elem", scope: !2, file: !120, line: 72, type: !133, isLocal: true, isDefinition: true)
!133 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !134, size: 64)
!134 = !DISubroutineType(types: !135)
!135 = !{!37, !36, !124, !124, !136}
!136 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !45, line: 31, baseType: !137)
!137 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!138 = !DIGlobalVariableExpression(var: !139, expr: !DIExpression())
!139 = distinct !DIGlobalVariable(name: "bpf_l3_csum_replace", scope: !2, file: !120, line: 250, type: !140, isLocal: true, isDefinition: true)
!140 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !141, size: 64)
!141 = !DISubroutineType(types: !142)
!142 = !{!37, !143, !62, !136, !136, !136}
!143 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !144, size: 64)
!144 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__sk_buff", file: !145, line: 2974, size: 1408, elements: !146)
!145 = !DIFile(filename: "/usr/include/linux/bpf.h", directory: "")
!146 = !{!147, !148, !149, !150, !151, !152, !153, !154, !155, !156, !157, !158, !159, !163, !164, !165, !166, !167, !168, !169, !170, !171, !173, !174, !175, !176, !177, !209, !210, !211, !212}
!147 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !144, file: !145, line: 2975, baseType: !62, size: 32)
!148 = !DIDerivedType(tag: DW_TAG_member, name: "pkt_type", scope: !144, file: !145, line: 2976, baseType: !62, size: 32, offset: 32)
!149 = !DIDerivedType(tag: DW_TAG_member, name: "mark", scope: !144, file: !145, line: 2977, baseType: !62, size: 32, offset: 64)
!150 = !DIDerivedType(tag: DW_TAG_member, name: "queue_mapping", scope: !144, file: !145, line: 2978, baseType: !62, size: 32, offset: 96)
!151 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !144, file: !145, line: 2979, baseType: !62, size: 32, offset: 128)
!152 = !DIDerivedType(tag: DW_TAG_member, name: "vlan_present", scope: !144, file: !145, line: 2980, baseType: !62, size: 32, offset: 160)
!153 = !DIDerivedType(tag: DW_TAG_member, name: "vlan_tci", scope: !144, file: !145, line: 2981, baseType: !62, size: 32, offset: 192)
!154 = !DIDerivedType(tag: DW_TAG_member, name: "vlan_proto", scope: !144, file: !145, line: 2982, baseType: !62, size: 32, offset: 224)
!155 = !DIDerivedType(tag: DW_TAG_member, name: "priority", scope: !144, file: !145, line: 2983, baseType: !62, size: 32, offset: 256)
!156 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !144, file: !145, line: 2984, baseType: !62, size: 32, offset: 288)
!157 = !DIDerivedType(tag: DW_TAG_member, name: "ifindex", scope: !144, file: !145, line: 2985, baseType: !62, size: 32, offset: 320)
!158 = !DIDerivedType(tag: DW_TAG_member, name: "tc_index", scope: !144, file: !145, line: 2986, baseType: !62, size: 32, offset: 352)
!159 = !DIDerivedType(tag: DW_TAG_member, name: "cb", scope: !144, file: !145, line: 2987, baseType: !160, size: 160, offset: 384)
!160 = !DICompositeType(tag: DW_TAG_array_type, baseType: !62, size: 160, elements: !161)
!161 = !{!162}
!162 = !DISubrange(count: 5)
!163 = !DIDerivedType(tag: DW_TAG_member, name: "hash", scope: !144, file: !145, line: 2988, baseType: !62, size: 32, offset: 544)
!164 = !DIDerivedType(tag: DW_TAG_member, name: "tc_classid", scope: !144, file: !145, line: 2989, baseType: !62, size: 32, offset: 576)
!165 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !144, file: !145, line: 2990, baseType: !62, size: 32, offset: 608)
!166 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !144, file: !145, line: 2991, baseType: !62, size: 32, offset: 640)
!167 = !DIDerivedType(tag: DW_TAG_member, name: "napi_id", scope: !144, file: !145, line: 2992, baseType: !62, size: 32, offset: 672)
!168 = !DIDerivedType(tag: DW_TAG_member, name: "family", scope: !144, file: !145, line: 2995, baseType: !62, size: 32, offset: 704)
!169 = !DIDerivedType(tag: DW_TAG_member, name: "remote_ip4", scope: !144, file: !145, line: 2996, baseType: !62, size: 32, offset: 736)
!170 = !DIDerivedType(tag: DW_TAG_member, name: "local_ip4", scope: !144, file: !145, line: 2997, baseType: !62, size: 32, offset: 768)
!171 = !DIDerivedType(tag: DW_TAG_member, name: "remote_ip6", scope: !144, file: !145, line: 2998, baseType: !172, size: 128, offset: 800)
!172 = !DICompositeType(tag: DW_TAG_array_type, baseType: !62, size: 128, elements: !89)
!173 = !DIDerivedType(tag: DW_TAG_member, name: "local_ip6", scope: !144, file: !145, line: 2999, baseType: !172, size: 128, offset: 928)
!174 = !DIDerivedType(tag: DW_TAG_member, name: "remote_port", scope: !144, file: !145, line: 3000, baseType: !62, size: 32, offset: 1056)
!175 = !DIDerivedType(tag: DW_TAG_member, name: "local_port", scope: !144, file: !145, line: 3001, baseType: !62, size: 32, offset: 1088)
!176 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !144, file: !145, line: 3004, baseType: !62, size: 32, offset: 1120)
!177 = !DIDerivedType(tag: DW_TAG_member, scope: !144, file: !145, line: 3005, baseType: !178, size: 64, align: 64, offset: 1152)
!178 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !144, file: !145, line: 3005, size: 64, align: 64, elements: !179)
!179 = !{!180}
!180 = !DIDerivedType(tag: DW_TAG_member, name: "flow_keys", scope: !178, file: !145, line: 3005, baseType: !181, size: 64)
!181 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !182, size: 64)
!182 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_flow_keys", file: !145, line: 3555, size: 448, elements: !183)
!183 = !{!184, !185, !186, !187, !188, !189, !190, !191, !192, !193, !194, !207, !208}
!184 = !DIDerivedType(tag: DW_TAG_member, name: "nhoff", scope: !182, file: !145, line: 3556, baseType: !52, size: 16)
!185 = !DIDerivedType(tag: DW_TAG_member, name: "thoff", scope: !182, file: !145, line: 3557, baseType: !52, size: 16, offset: 16)
!186 = !DIDerivedType(tag: DW_TAG_member, name: "addr_proto", scope: !182, file: !145, line: 3558, baseType: !52, size: 16, offset: 32)
!187 = !DIDerivedType(tag: DW_TAG_member, name: "is_frag", scope: !182, file: !145, line: 3559, baseType: !44, size: 8, offset: 48)
!188 = !DIDerivedType(tag: DW_TAG_member, name: "is_first_frag", scope: !182, file: !145, line: 3560, baseType: !44, size: 8, offset: 56)
!189 = !DIDerivedType(tag: DW_TAG_member, name: "is_encap", scope: !182, file: !145, line: 3561, baseType: !44, size: 8, offset: 64)
!190 = !DIDerivedType(tag: DW_TAG_member, name: "ip_proto", scope: !182, file: !145, line: 3562, baseType: !44, size: 8, offset: 72)
!191 = !DIDerivedType(tag: DW_TAG_member, name: "n_proto", scope: !182, file: !145, line: 3563, baseType: !50, size: 16, offset: 80)
!192 = !DIDerivedType(tag: DW_TAG_member, name: "sport", scope: !182, file: !145, line: 3564, baseType: !50, size: 16, offset: 96)
!193 = !DIDerivedType(tag: DW_TAG_member, name: "dport", scope: !182, file: !145, line: 3565, baseType: !50, size: 16, offset: 112)
!194 = !DIDerivedType(tag: DW_TAG_member, scope: !182, file: !145, line: 3566, baseType: !195, size: 256, offset: 128)
!195 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !182, file: !145, line: 3566, size: 256, elements: !196)
!196 = !{!197, !202}
!197 = !DIDerivedType(tag: DW_TAG_member, scope: !195, file: !145, line: 3567, baseType: !198, size: 64)
!198 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !195, file: !145, line: 3567, size: 64, elements: !199)
!199 = !{!200, !201}
!200 = !DIDerivedType(tag: DW_TAG_member, name: "ipv4_src", scope: !198, file: !145, line: 3568, baseType: !61, size: 32)
!201 = !DIDerivedType(tag: DW_TAG_member, name: "ipv4_dst", scope: !198, file: !145, line: 3569, baseType: !61, size: 32, offset: 32)
!202 = !DIDerivedType(tag: DW_TAG_member, scope: !195, file: !145, line: 3571, baseType: !203, size: 256)
!203 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !195, file: !145, line: 3571, size: 256, elements: !204)
!204 = !{!205, !206}
!205 = !DIDerivedType(tag: DW_TAG_member, name: "ipv6_src", scope: !203, file: !145, line: 3572, baseType: !172, size: 128)
!206 = !DIDerivedType(tag: DW_TAG_member, name: "ipv6_dst", scope: !203, file: !145, line: 3573, baseType: !172, size: 128, offset: 128)
!207 = !DIDerivedType(tag: DW_TAG_member, name: "flags", scope: !182, file: !145, line: 3576, baseType: !62, size: 32, offset: 384)
!208 = !DIDerivedType(tag: DW_TAG_member, name: "flow_label", scope: !182, file: !145, line: 3577, baseType: !61, size: 32, offset: 416)
!209 = !DIDerivedType(tag: DW_TAG_member, name: "tstamp", scope: !144, file: !145, line: 3006, baseType: !136, size: 64, offset: 1216)
!210 = !DIDerivedType(tag: DW_TAG_member, name: "wire_len", scope: !144, file: !145, line: 3007, baseType: !62, size: 32, offset: 1280)
!211 = !DIDerivedType(tag: DW_TAG_member, name: "gso_segs", scope: !144, file: !145, line: 3008, baseType: !62, size: 32, offset: 1312)
!212 = !DIDerivedType(tag: DW_TAG_member, scope: !144, file: !145, line: 3009, baseType: !213, size: 64, align: 64, offset: 1344)
!213 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !144, file: !145, line: 3009, size: 64, align: 64, elements: !214)
!214 = !{!215}
!215 = !DIDerivedType(tag: DW_TAG_member, name: "sk", scope: !213, file: !145, line: 3009, baseType: !216, size: 64)
!216 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !217, size: 64)
!217 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_sock", file: !145, line: 3062, size: 608, elements: !218)
!218 = !{!219, !220, !221, !222, !223, !224, !225, !226, !227, !228, !229, !230, !231}
!219 = !DIDerivedType(tag: DW_TAG_member, name: "bound_dev_if", scope: !217, file: !145, line: 3063, baseType: !62, size: 32)
!220 = !DIDerivedType(tag: DW_TAG_member, name: "family", scope: !217, file: !145, line: 3064, baseType: !62, size: 32, offset: 32)
!221 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !217, file: !145, line: 3065, baseType: !62, size: 32, offset: 64)
!222 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !217, file: !145, line: 3066, baseType: !62, size: 32, offset: 96)
!223 = !DIDerivedType(tag: DW_TAG_member, name: "mark", scope: !217, file: !145, line: 3067, baseType: !62, size: 32, offset: 128)
!224 = !DIDerivedType(tag: DW_TAG_member, name: "priority", scope: !217, file: !145, line: 3068, baseType: !62, size: 32, offset: 160)
!225 = !DIDerivedType(tag: DW_TAG_member, name: "src_ip4", scope: !217, file: !145, line: 3070, baseType: !62, size: 32, offset: 192)
!226 = !DIDerivedType(tag: DW_TAG_member, name: "src_ip6", scope: !217, file: !145, line: 3071, baseType: !172, size: 128, offset: 224)
!227 = !DIDerivedType(tag: DW_TAG_member, name: "src_port", scope: !217, file: !145, line: 3072, baseType: !62, size: 32, offset: 352)
!228 = !DIDerivedType(tag: DW_TAG_member, name: "dst_port", scope: !217, file: !145, line: 3073, baseType: !50, size: 16, offset: 384)
!229 = !DIDerivedType(tag: DW_TAG_member, name: "dst_ip4", scope: !217, file: !145, line: 3075, baseType: !62, size: 32, offset: 416)
!230 = !DIDerivedType(tag: DW_TAG_member, name: "dst_ip6", scope: !217, file: !145, line: 3076, baseType: !172, size: 128, offset: 448)
!231 = !DIDerivedType(tag: DW_TAG_member, name: "state", scope: !217, file: !145, line: 3077, baseType: !62, size: 32, offset: 576)
!232 = !DIGlobalVariableExpression(var: !233, expr: !DIExpression())
!233 = distinct !DIGlobalVariable(name: "bpf_skb_store_bytes", scope: !2, file: !120, line: 221, type: !234, isLocal: true, isDefinition: true)
!234 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !235, size: 64)
!235 = !DISubroutineType(types: !236)
!236 = !{!37, !143, !62, !124, !62, !136}
!237 = !DIGlobalVariableExpression(var: !238, expr: !DIExpression())
!238 = distinct !DIGlobalVariable(name: "bpf_clone_redirect", scope: !2, file: !120, line: 349, type: !239, isLocal: true, isDefinition: true)
!239 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !240, size: 64)
!240 = !DISubroutineType(types: !241)
!241 = !{!37, !143, !62, !136}
!242 = !DIGlobalVariableExpression(var: !243, expr: !DIExpression())
!243 = distinct !DIGlobalVariable(name: "bpf_l4_csum_replace", scope: !2, file: !120, line: 286, type: !140, isLocal: true, isDefinition: true)
!244 = !{i32 7, !"Dwarf Version", i32 4}
!245 = !{i32 2, !"Debug Info Version", i32 3}
!246 = !{i32 1, !"wchar_size", i32 4}
!247 = !{!"clang version 10.0.0-4ubuntu1 "}
!248 = distinct !DISubprogram(name: "tc_egress", scope: !3, file: !3, line: 9, type: !249, scopeLine: 10, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !251)
!249 = !DISubroutineType(types: !250)
!250 = !{!76, !143}
!251 = !{!252, !253, !254, !255, !266, !267, !289, !290, !291, !292, !295, !298, !299, !300, !301, !302, !303, !304, !305, !307, !308, !310}
!252 = !DILocalVariable(name: "skb", arg: 1, scope: !248, file: !3, line: 9, type: !143)
!253 = !DILocalVariable(name: "data_end", scope: !248, file: !3, line: 11, type: !36)
!254 = !DILocalVariable(name: "data", scope: !248, file: !3, line: 12, type: !36)
!255 = !DILocalVariable(name: "eth", scope: !248, file: !3, line: 13, type: !256)
!256 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !257, size: 64)
!257 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !258, line: 163, size: 112, elements: !259)
!258 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "")
!259 = !{!260, !264, !265}
!260 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !257, file: !258, line: 164, baseType: !261, size: 48)
!261 = !DICompositeType(tag: DW_TAG_array_type, baseType: !46, size: 48, elements: !262)
!262 = !{!263}
!263 = !DISubrange(count: 6)
!264 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !257, file: !258, line: 165, baseType: !261, size: 48, offset: 48)
!265 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !257, file: !258, line: 166, baseType: !50, size: 16, offset: 96)
!266 = !DILocalVariable(name: "ip", scope: !248, file: !3, line: 16, type: !39)
!267 = !DILocalVariable(name: "tcp", scope: !248, file: !3, line: 19, type: !268)
!268 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !269, size: 64)
!269 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tcphdr", file: !270, line: 25, size: 160, elements: !271)
!270 = !DIFile(filename: "/usr/include/linux/tcp.h", directory: "")
!271 = !{!272, !273, !274, !275, !276, !277, !278, !279, !280, !281, !282, !283, !284, !285, !286, !287, !288}
!272 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !269, file: !270, line: 26, baseType: !50, size: 16)
!273 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !269, file: !270, line: 27, baseType: !50, size: 16, offset: 16)
!274 = !DIDerivedType(tag: DW_TAG_member, name: "seq", scope: !269, file: !270, line: 28, baseType: !61, size: 32, offset: 32)
!275 = !DIDerivedType(tag: DW_TAG_member, name: "ack_seq", scope: !269, file: !270, line: 29, baseType: !61, size: 32, offset: 64)
!276 = !DIDerivedType(tag: DW_TAG_member, name: "res1", scope: !269, file: !270, line: 31, baseType: !52, size: 4, offset: 96, flags: DIFlagBitField, extraData: i64 96)
!277 = !DIDerivedType(tag: DW_TAG_member, name: "doff", scope: !269, file: !270, line: 32, baseType: !52, size: 4, offset: 100, flags: DIFlagBitField, extraData: i64 96)
!278 = !DIDerivedType(tag: DW_TAG_member, name: "fin", scope: !269, file: !270, line: 33, baseType: !52, size: 1, offset: 104, flags: DIFlagBitField, extraData: i64 96)
!279 = !DIDerivedType(tag: DW_TAG_member, name: "syn", scope: !269, file: !270, line: 34, baseType: !52, size: 1, offset: 105, flags: DIFlagBitField, extraData: i64 96)
!280 = !DIDerivedType(tag: DW_TAG_member, name: "rst", scope: !269, file: !270, line: 35, baseType: !52, size: 1, offset: 106, flags: DIFlagBitField, extraData: i64 96)
!281 = !DIDerivedType(tag: DW_TAG_member, name: "psh", scope: !269, file: !270, line: 36, baseType: !52, size: 1, offset: 107, flags: DIFlagBitField, extraData: i64 96)
!282 = !DIDerivedType(tag: DW_TAG_member, name: "ack", scope: !269, file: !270, line: 37, baseType: !52, size: 1, offset: 108, flags: DIFlagBitField, extraData: i64 96)
!283 = !DIDerivedType(tag: DW_TAG_member, name: "urg", scope: !269, file: !270, line: 38, baseType: !52, size: 1, offset: 109, flags: DIFlagBitField, extraData: i64 96)
!284 = !DIDerivedType(tag: DW_TAG_member, name: "ece", scope: !269, file: !270, line: 39, baseType: !52, size: 1, offset: 110, flags: DIFlagBitField, extraData: i64 96)
!285 = !DIDerivedType(tag: DW_TAG_member, name: "cwr", scope: !269, file: !270, line: 40, baseType: !52, size: 1, offset: 111, flags: DIFlagBitField, extraData: i64 96)
!286 = !DIDerivedType(tag: DW_TAG_member, name: "window", scope: !269, file: !270, line: 55, baseType: !50, size: 16, offset: 112)
!287 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !269, file: !270, line: 56, baseType: !59, size: 16, offset: 128)
!288 = !DIDerivedType(tag: DW_TAG_member, name: "urg_ptr", scope: !269, file: !270, line: 57, baseType: !50, size: 16, offset: 144)
!289 = !DILocalVariable(name: "key", scope: !248, file: !3, line: 21, type: !108)
!290 = !DILocalVariable(name: "ptr", scope: !248, file: !3, line: 23, type: !116)
!291 = !DILocalVariable(name: "delta", scope: !248, file: !3, line: 24, type: !7)
!292 = !DILocalVariable(name: "cksum_flags", scope: !293, file: !3, line: 33, type: !46)
!293 = distinct !DILexicalBlock(scope: !294, file: !3, line: 31, column: 5)
!294 = distinct !DILexicalBlock(scope: !248, file: !3, line: 25, column: 8)
!295 = !DILocalVariable(name: "pre_ack", scope: !296, file: !3, line: 41, type: !7)
!296 = distinct !DILexicalBlock(scope: !297, file: !3, line: 35, column: 9)
!297 = distinct !DILexicalBlock(scope: !293, file: !3, line: 34, column: 12)
!298 = !DILocalVariable(name: "old_ip_len_n", scope: !296, file: !3, line: 48, type: !67)
!299 = !DILocalVariable(name: "new_ip_len_n", scope: !296, file: !3, line: 49, type: !67)
!300 = !DILocalVariable(name: "data_end", scope: !296, file: !3, line: 53, type: !36)
!301 = !DILocalVariable(name: "data", scope: !296, file: !3, line: 54, type: !36)
!302 = !DILocalVariable(name: "eth", scope: !296, file: !3, line: 56, type: !256)
!303 = !DILocalVariable(name: "ip", scope: !296, file: !3, line: 57, type: !39)
!304 = !DILocalVariable(name: "tcp", scope: !296, file: !3, line: 58, type: !268)
!305 = !DILocalVariable(name: "old_flags_ptr", scope: !296, file: !3, line: 60, type: !306)
!306 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !53, size: 64)
!307 = !DILocalVariable(name: "new_flags_n", scope: !296, file: !3, line: 61, type: !53)
!308 = !DILocalVariable(name: "new_seq", scope: !309, file: !3, line: 68, type: !7)
!309 = distinct !DILexicalBlock(scope: !297, file: !3, line: 66, column: 9)
!310 = !DILabel(scope: !248, name: "DROP", file: !3, line: 73)
!311 = !DILocation(line: 0, scope: !248)
!312 = !DILocation(line: 11, column: 41, scope: !248)
!313 = !{!314, !315, i64 80}
!314 = !{!"__sk_buff", !315, i64 0, !315, i64 4, !315, i64 8, !315, i64 12, !315, i64 16, !315, i64 20, !315, i64 24, !315, i64 28, !315, i64 32, !315, i64 36, !315, i64 40, !315, i64 44, !316, i64 48, !315, i64 68, !315, i64 72, !315, i64 76, !315, i64 80, !315, i64 84, !315, i64 88, !315, i64 92, !315, i64 96, !316, i64 100, !316, i64 116, !315, i64 132, !315, i64 136, !315, i64 140, !316, i64 144, !318, i64 152, !315, i64 160, !315, i64 164, !316, i64 168}
!315 = !{!"int", !316, i64 0}
!316 = !{!"omnipotent char", !317, i64 0}
!317 = !{!"Simple C/C++ TBAA"}
!318 = !{!"long long", !316, i64 0}
!319 = !DILocation(line: 11, column: 30, scope: !248)
!320 = !DILocation(line: 11, column: 22, scope: !248)
!321 = !DILocation(line: 12, column: 37, scope: !248)
!322 = !{!314, !315, i64 76}
!323 = !DILocation(line: 12, column: 26, scope: !248)
!324 = !DILocation(line: 12, column: 18, scope: !248)
!325 = !DILocation(line: 13, column: 26, scope: !248)
!326 = !DILocation(line: 14, column: 12, scope: !327)
!327 = distinct !DILexicalBlock(scope: !248, file: !3, line: 14, column: 8)
!328 = !DILocation(line: 14, column: 25, scope: !327)
!329 = !DILocation(line: 14, column: 8, scope: !248)
!330 = !DILocation(line: 15, column: 13, scope: !331)
!331 = distinct !DILexicalBlock(scope: !248, file: !3, line: 15, column: 8)
!332 = !{!333, !334, i64 12}
!333 = !{!"ethhdr", !316, i64 0, !316, i64 6, !334, i64 12}
!334 = !{!"short", !316, i64 0}
!335 = !DILocation(line: 15, column: 20, scope: !331)
!336 = !DILocation(line: 15, column: 8, scope: !248)
!337 = !DILocation(line: 17, column: 10, scope: !338)
!338 = distinct !DILexicalBlock(scope: !248, file: !3, line: 17, column: 8)
!339 = !DILocation(line: 17, column: 23, scope: !338)
!340 = !DILocation(line: 17, column: 22, scope: !338)
!341 = !DILocation(line: 17, column: 8, scope: !248)
!342 = !DILocation(line: 18, column: 12, scope: !343)
!343 = distinct !DILexicalBlock(scope: !248, file: !3, line: 18, column: 8)
!344 = !{!345, !316, i64 9}
!345 = !{!"iphdr", !316, i64 0, !316, i64 0, !316, i64 1, !334, i64 2, !334, i64 4, !334, i64 6, !316, i64 8, !316, i64 9, !334, i64 10, !315, i64 12, !315, i64 16}
!346 = !DILocation(line: 18, column: 20, scope: !343)
!347 = !DILocation(line: 18, column: 8, scope: !248)
!348 = !DILocation(line: 20, column: 11, scope: !349)
!349 = distinct !DILexicalBlock(scope: !248, file: !3, line: 20, column: 8)
!350 = !DILocation(line: 20, column: 25, scope: !349)
!351 = !DILocation(line: 20, column: 24, scope: !349)
!352 = !DILocation(line: 20, column: 8, scope: !248)
!353 = !DILocation(line: 21, column: 13, scope: !248)
!354 = !DILocation(line: 22, column: 23, scope: !248)
!355 = !{!345, !315, i64 16}
!356 = !DILocation(line: 22, column: 33, scope: !248)
!357 = !{!345, !315, i64 12}
!358 = !DILocation(line: 22, column: 44, scope: !248)
!359 = !{!360, !334, i64 2}
!360 = !{!"tcphdr", !334, i64 0, !334, i64 2, !315, i64 4, !315, i64 8, !334, i64 12, !334, i64 12, !334, i64 13, !334, i64 13, !334, i64 13, !334, i64 13, !334, i64 13, !334, i64 13, !334, i64 13, !334, i64 13, !334, i64 14, !334, i64 16, !334, i64 18}
!361 = !DILocation(line: 22, column: 54, scope: !248)
!362 = !{!360, !334, i64 0}
!363 = !DILocalVariable(name: "key", arg: 1, scope: !364, file: !93, line: 28, type: !107)
!364 = distinct !DISubprogram(name: "key_init", scope: !93, file: !93, line: 28, type: !365, scopeLine: 29, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !367)
!365 = !DISubroutineType(types: !366)
!366 = !{null, !107, !7, !7, !53, !53}
!367 = !{!363, !368, !369, !370, !371}
!368 = !DILocalVariable(name: "sa", arg: 2, scope: !364, file: !93, line: 28, type: !7)
!369 = !DILocalVariable(name: "da", arg: 3, scope: !364, file: !93, line: 28, type: !7)
!370 = !DILocalVariable(name: "s", arg: 4, scope: !364, file: !93, line: 28, type: !53)
!371 = !DILocalVariable(name: "d", arg: 5, scope: !364, file: !93, line: 28, type: !53)
!372 = !DILocation(line: 0, scope: !364, inlinedAt: !373)
!373 = distinct !DILocation(line: 22, column: 5, scope: !248)
!374 = !DILocation(line: 30, column: 7, scope: !364, inlinedAt: !373)
!375 = !DILocation(line: 30, column: 12, scope: !364, inlinedAt: !373)
!376 = !{!377, !315, i64 0}
!377 = !{!"pkt_4tuple", !315, i64 0, !315, i64 4, !334, i64 8, !334, i64 10}
!378 = !DILocation(line: 31, column: 7, scope: !364, inlinedAt: !373)
!379 = !DILocation(line: 31, column: 12, scope: !364, inlinedAt: !373)
!380 = !{!377, !315, i64 4}
!381 = !DILocation(line: 32, column: 7, scope: !364, inlinedAt: !373)
!382 = !DILocation(line: 32, column: 10, scope: !364, inlinedAt: !373)
!383 = !{!377, !334, i64 8}
!384 = !DILocation(line: 33, column: 7, scope: !364, inlinedAt: !373)
!385 = !DILocation(line: 33, column: 11, scope: !364, inlinedAt: !373)
!386 = !{!377, !334, i64 10}
!387 = !DILocation(line: 23, column: 45, scope: !248)
!388 = !DILocation(line: 23, column: 14, scope: !248)
!389 = !DILocation(line: 25, column: 8, scope: !294)
!390 = !DILocation(line: 25, column: 8, scope: !248)
!391 = !DILocation(line: 32, column: 34, scope: !392)
!392 = distinct !DILexicalBlock(scope: !293, file: !3, line: 32, column: 12)
!393 = !DILocation(line: 32, column: 12, scope: !392)
!394 = !DILocation(line: 32, column: 57, scope: !392)
!395 = !DILocation(line: 32, column: 12, scope: !293)
!396 = !DILocation(line: 34, column: 17, scope: !297)
!397 = !DILocation(line: 34, column: 20, scope: !297)
!398 = !DILocalVariable(name: "i", scope: !399, file: !74, line: 97, type: !137)
!399 = distinct !DILexicalBlock(scope: !400, file: !74, line: 97, column: 5)
!400 = distinct !DISubprogram(name: "swap", scope: !74, file: !74, line: 93, type: !401, scopeLine: 94, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !403)
!401 = !DISubroutineType(types: !402)
!402 = !{null, !36, !36, !137}
!403 = !{!404, !405, !406, !407, !408, !410, !398}
!404 = !DILocalVariable(name: "a", arg: 1, scope: !400, file: !74, line: 93, type: !36)
!405 = !DILocalVariable(name: "b", arg: 2, scope: !400, file: !74, line: 93, type: !36)
!406 = !DILocalVariable(name: "size", arg: 3, scope: !400, file: !74, line: 93, type: !137)
!407 = !DILocalVariable(name: "tmp", scope: !400, file: !74, line: 95, type: !46)
!408 = !DILocalVariable(name: "p", scope: !400, file: !74, line: 96, type: !409)
!409 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !46, size: 64)
!410 = !DILocalVariable(name: "q", scope: !400, file: !74, line: 96, type: !409)
!411 = !DILocation(line: 0, scope: !399, inlinedAt: !412)
!412 = distinct !DILocation(line: 36, column: 13, scope: !296)
!413 = !DILocation(line: 99, column: 13, scope: !414, inlinedAt: !412)
!414 = distinct !DILexicalBlock(scope: !415, file: !74, line: 98, column: 5)
!415 = distinct !DILexicalBlock(scope: !399, file: !74, line: 97, column: 5)
!416 = !{!316, !316, i64 0}
!417 = !DILocation(line: 0, scope: !400, inlinedAt: !412)
!418 = !DILocation(line: 100, column: 14, scope: !414, inlinedAt: !412)
!419 = !DILocation(line: 100, column: 13, scope: !414, inlinedAt: !412)
!420 = !DILocation(line: 101, column: 13, scope: !414, inlinedAt: !412)
!421 = !DILocation(line: 0, scope: !399, inlinedAt: !422)
!422 = distinct !DILocation(line: 37, column: 13, scope: !296)
!423 = !DILocation(line: 99, column: 13, scope: !414, inlinedAt: !422)
!424 = !DILocation(line: 0, scope: !400, inlinedAt: !422)
!425 = !DILocation(line: 100, column: 14, scope: !414, inlinedAt: !422)
!426 = !DILocation(line: 100, column: 13, scope: !414, inlinedAt: !422)
!427 = !DILocation(line: 101, column: 13, scope: !414, inlinedAt: !422)
!428 = !DILocation(line: 0, scope: !399, inlinedAt: !429)
!429 = distinct !DILocation(line: 38, column: 13, scope: !296)
!430 = !DILocation(line: 99, column: 13, scope: !414, inlinedAt: !429)
!431 = !DILocation(line: 0, scope: !400, inlinedAt: !429)
!432 = !DILocation(line: 100, column: 14, scope: !414, inlinedAt: !429)
!433 = !DILocation(line: 100, column: 13, scope: !414, inlinedAt: !429)
!434 = !DILocation(line: 101, column: 13, scope: !414, inlinedAt: !429)
!435 = !DILocation(line: 39, column: 21, scope: !296)
!436 = !DILocation(line: 40, column: 22, scope: !296)
!437 = !DILocation(line: 41, column: 30, scope: !296)
!438 = !{!360, !315, i64 8}
!439 = !DILocation(line: 0, scope: !296)
!440 = !DILocation(line: 42, column: 26, scope: !296)
!441 = !{!360, !315, i64 4}
!442 = !DILocalVariable(name: "__bsx", arg: 1, scope: !443, file: !444, line: 49, type: !447)
!443 = distinct !DISubprogram(name: "__bswap_32", scope: !444, file: !444, line: 49, type: !445, scopeLine: 50, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !448)
!444 = !DIFile(filename: "/usr/include/bits/byteswap.h", directory: "")
!445 = !DISubroutineType(types: !446)
!446 = !{!447, !447}
!447 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !65, line: 42, baseType: !7)
!448 = !{!442}
!449 = !DILocation(line: 0, scope: !443, inlinedAt: !450)
!450 = distinct !DILocation(line: 42, column: 26, scope: !296)
!451 = !DILocation(line: 54, column: 10, scope: !443, inlinedAt: !450)
!452 = !DILocation(line: 0, scope: !443, inlinedAt: !453)
!453 = distinct !DILocation(line: 42, column: 26, scope: !296)
!454 = !DILocation(line: 54, column: 10, scope: !443, inlinedAt: !453)
!455 = !DILocation(line: 42, column: 25, scope: !296)
!456 = !DILocation(line: 43, column: 21, scope: !296)
!457 = !DILocation(line: 44, column: 18, scope: !296)
!458 = !DILocation(line: 44, column: 24, scope: !296)
!459 = !{!360, !334, i64 14}
!460 = !DILocation(line: 45, column: 19, scope: !296)
!461 = !{!315, !315, i64 0}
!462 = !DILocation(line: 0, scope: !443, inlinedAt: !463)
!463 = distinct !DILocation(line: 45, column: 25, scope: !296)
!464 = !DILocation(line: 45, column: 24, scope: !296)
!465 = !DILocation(line: 45, column: 18, scope: !296)
!466 = !DILocation(line: 46, column: 13, scope: !296)
!467 = !DILocation(line: 47, column: 73, scope: !296)
!468 = !DILocation(line: 47, column: 56, scope: !296)
!469 = !DILocation(line: 47, column: 24, scope: !296)
!470 = !DILocalVariable(name: "tcpSeg", arg: 2, scope: !471, file: !93, line: 81, type: !306)
!471 = distinct !DISubprogram(name: "eg_compute_full_tcp_checksum", scope: !93, file: !93, line: 81, type: !472, scopeLine: 81, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !474)
!472 = !DISubroutineType(types: !473)
!473 = !{!53, !39, !306, !36, !36}
!474 = !{!475, !470, !476, !477, !478, !479, !480, !481, !482, !485}
!475 = !DILocalVariable(name: "ip", arg: 1, scope: !471, file: !93, line: 81, type: !39)
!476 = !DILocalVariable(name: "data_start", arg: 3, scope: !471, file: !93, line: 81, type: !36)
!477 = !DILocalVariable(name: "data_end", arg: 4, scope: !471, file: !93, line: 81, type: !36)
!478 = !DILocalVariable(name: "sum", scope: !471, file: !93, line: 82, type: !38)
!479 = !DILocalVariable(name: "tcpLen", scope: !471, file: !93, line: 84, type: !53)
!480 = !DILocalVariable(name: "i", scope: !471, file: !93, line: 98, type: !7)
!481 = !DILocalVariable(name: "j", scope: !471, file: !93, line: 101, type: !7)
!482 = !DILocalVariable(name: "upper_byte", scope: !483, file: !93, line: 123, type: !69)
!483 = distinct !DILexicalBlock(scope: !484, file: !93, line: 122, column: 103)
!484 = distinct !DILexicalBlock(scope: !471, file: !93, line: 122, column: 12)
!485 = !DILocalVariable(name: "padded_bytes", scope: !483, file: !93, line: 124, type: !67)
!486 = !DILocation(line: 0, scope: !471, inlinedAt: !487)
!487 = distinct !DILocation(line: 47, column: 24, scope: !296)
!488 = !DILocation(line: 88, column: 22, scope: !471, inlinedAt: !487)
!489 = !DILocation(line: 89, column: 23, scope: !471, inlinedAt: !487)
!490 = !DILocation(line: 91, column: 22, scope: !471, inlinedAt: !487)
!491 = !DILocation(line: 92, column: 23, scope: !471, inlinedAt: !487)
!492 = !DILocation(line: 89, column: 9, scope: !471, inlinedAt: !487)
!493 = !DILocation(line: 91, column: 9, scope: !471, inlinedAt: !487)
!494 = !DILocation(line: 92, column: 9, scope: !471, inlinedAt: !487)
!495 = !DILocation(line: 96, column: 9, scope: !471, inlinedAt: !487)
!496 = !DILocation(line: 0, scope: !497, inlinedAt: !487)
!497 = distinct !DILexicalBlock(scope: !498, file: !93, line: 105, column: 20)
!498 = distinct !DILexicalBlock(scope: !499, file: !93, line: 103, column: 33)
!499 = distinct !DILexicalBlock(scope: !500, file: !93, line: 103, column: 9)
!500 = distinct !DILexicalBlock(scope: !471, file: !93, line: 103, column: 9)
!501 = !DILocation(line: 105, column: 27, scope: !497, inlinedAt: !487)
!502 = !DILocation(line: 105, column: 31, scope: !497, inlinedAt: !487)
!503 = !DILocation(line: 105, column: 54, scope: !497, inlinedAt: !487)
!504 = !DILocation(line: 112, column: 22, scope: !505, inlinedAt: !487)
!505 = distinct !DILexicalBlock(scope: !498, file: !93, line: 112, column: 20)
!506 = !DILocation(line: 112, column: 20, scope: !498, inlinedAt: !487)
!507 = !DILocation(line: 113, column: 24, scope: !508, inlinedAt: !487)
!508 = distinct !DILexicalBlock(scope: !505, file: !93, line: 112, column: 27)
!509 = !{!334, !334, i64 0}
!510 = !DILocation(line: 113, column: 21, scope: !508, inlinedAt: !487)
!511 = !DILocation(line: 114, column: 17, scope: !508, inlinedAt: !487)
!512 = !DILocation(line: 117, column: 16, scope: !498, inlinedAt: !487)
!513 = !DILocation(line: 103, column: 29, scope: !499, inlinedAt: !487)
!514 = !DILocation(line: 103, column: 9, scope: !499, inlinedAt: !487)
!515 = !DILocation(line: 108, column: 27, scope: !516, inlinedAt: !487)
!516 = distinct !DILexicalBlock(scope: !498, file: !93, line: 108, column: 20)
!517 = !DILocation(line: 122, column: 75, scope: !484, inlinedAt: !487)
!518 = !DILocation(line: 122, column: 64, scope: !484, inlinedAt: !487)
!519 = !DILocation(line: 122, column: 24, scope: !484, inlinedAt: !487)
!520 = !DILocation(line: 123, column: 40, scope: !483, inlinedAt: !487)
!521 = !DILocation(line: 0, scope: !483, inlinedAt: !487)
!522 = !DILocation(line: 124, column: 55, scope: !483, inlinedAt: !487)
!523 = !DILocation(line: 125, column: 16, scope: !483, inlinedAt: !487)
!524 = !DILocation(line: 125, column: 13, scope: !483, inlinedAt: !487)
!525 = !DILocation(line: 127, column: 9, scope: !483, inlinedAt: !487)
!526 = !DILocation(line: 131, column: 9, scope: !527, inlinedAt: !487)
!527 = distinct !DILexicalBlock(scope: !471, file: !93, line: 131, column: 9)
!528 = !DILocation(line: 132, column: 23, scope: !529, inlinedAt: !487)
!529 = distinct !DILexicalBlock(scope: !530, file: !93, line: 132, column: 20)
!530 = distinct !DILexicalBlock(scope: !531, file: !93, line: 131, column: 31)
!531 = distinct !DILexicalBlock(scope: !527, file: !93, line: 131, column: 9)
!532 = !DILocation(line: 132, column: 20, scope: !530, inlinedAt: !487)
!533 = !DILocation(line: 131, column: 28, scope: !531, inlinedAt: !487)
!534 = !DILocation(line: 131, column: 22, scope: !531, inlinedAt: !487)
!535 = distinct !{!535, !526, !536}
!536 = !DILocation(line: 135, column: 9, scope: !527, inlinedAt: !487)
!537 = !DILocation(line: 138, column: 12, scope: !471, inlinedAt: !487)
!538 = !DILocation(line: 47, column: 18, scope: !296)
!539 = !DILocation(line: 47, column: 23, scope: !296)
!540 = !{!360, !334, i64 16}
!541 = !DILocation(line: 48, column: 41, scope: !296)
!542 = !{!345, !334, i64 2}
!543 = !DILocation(line: 49, column: 4, scope: !296)
!544 = !DILocation(line: 49, column: 13, scope: !296)
!545 = !DILocation(line: 50, column: 65, scope: !546)
!546 = distinct !DILexicalBlock(scope: !296, file: !3, line: 50, column: 16)
!547 = !DILocation(line: 50, column: 16, scope: !546)
!548 = !DILocation(line: 50, column: 112, scope: !546)
!549 = !DILocation(line: 50, column: 16, scope: !296)
!550 = !DILocation(line: 51, column: 13, scope: !296)
!551 = !DILocation(line: 52, column: 13, scope: !296)
!552 = !DILocation(line: 53, column: 49, scope: !296)
!553 = !DILocation(line: 53, column: 38, scope: !296)
!554 = !DILocation(line: 53, column: 30, scope: !296)
!555 = !DILocation(line: 54, column: 39, scope: !296)
!556 = !DILocation(line: 54, column: 28, scope: !296)
!557 = !DILocation(line: 54, column: 20, scope: !296)
!558 = !DILocation(line: 55, column: 26, scope: !559)
!559 = distinct !DILexicalBlock(scope: !296, file: !3, line: 55, column: 10)
!560 = !DILocation(line: 55, column: 31, scope: !559)
!561 = !DILocation(line: 55, column: 10, scope: !296)
!562 = !DILocation(line: 0, scope: !293)
!563 = !DILocation(line: 60, column: 61, scope: !296)
!564 = !DILocation(line: 60, column: 32, scope: !296)
!565 = !DILocation(line: 61, column: 13, scope: !296)
!566 = !DILocation(line: 61, column: 17, scope: !296)
!567 = !DILocation(line: 62, column: 68, scope: !568)
!568 = distinct !DILexicalBlock(scope: !296, file: !3, line: 62, column: 16)
!569 = !DILocation(line: 62, column: 16, scope: !568)
!570 = !DILocation(line: 62, column: 127, scope: !568)
!571 = !DILocation(line: 62, column: 16, scope: !296)
!572 = !DILocation(line: 63, column: 16, scope: !573)
!573 = distinct !DILexicalBlock(scope: !296, file: !3, line: 63, column: 16)
!574 = !DILocation(line: 63, column: 84, scope: !573)
!575 = !DILocation(line: 64, column: 9, scope: !297)
!576 = !DILocation(line: 68, column: 13, scope: !309)
!577 = !DILocation(line: 68, column: 25, scope: !309)
!578 = !DILocation(line: 0, scope: !443, inlinedAt: !579)
!579 = distinct !DILocation(line: 68, column: 25, scope: !309)
!580 = !DILocation(line: 54, column: 10, scope: !443, inlinedAt: !579)
!581 = !DILocation(line: 0, scope: !443, inlinedAt: !582)
!582 = distinct !DILocation(line: 68, column: 25, scope: !309)
!583 = !DILocation(line: 54, column: 10, scope: !443, inlinedAt: !582)
!584 = !DILocation(line: 0, scope: !309)
!585 = !DILocation(line: 68, column: 17, scope: !309)
!586 = !DILocation(line: 69, column: 16, scope: !587)
!587 = distinct !DILexicalBlock(scope: !309, file: !3, line: 69, column: 16)
!588 = !DILocation(line: 70, column: 9, scope: !297)
!589 = !DILocation(line: 73, column: 5, scope: !248)
!590 = !DILocation(line: 74, column: 5, scope: !248)
!591 = !DILocation(line: 75, column: 1, scope: !248)
