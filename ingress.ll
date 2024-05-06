; ModuleID = 'server/ingress.c'
source_filename = "server/ingress.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [1 x i32]*, [10000 x i32]*, %struct.pkt_4tuple*, i32*, [1 x i32]* }
%struct.pkt_4tuple = type { i32, i32, i16, i16 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.iphdr = type { i8, i8, i16, i16, i16, i8, i8, i16, i32, i32 }
%struct.tcphdr = type { i16, i16, i32, i32, i16, i16, i16, i16 }

@key0 = dso_local local_unnamed_addr constant i32 858927408, align 4, !dbg !0
@key1 = dso_local local_unnamed_addr constant i32 1111570744, align 4, !dbg !53
@c0 = dso_local local_unnamed_addr constant i32 1886610805, align 4, !dbg !58
@c1 = dso_local local_unnamed_addr constant i32 1852075885, align 4, !dbg !60
@c2 = dso_local local_unnamed_addr constant i32 1852142177, align 4, !dbg !62
@c3 = dso_local local_unnamed_addr constant i32 2037671283, align 4, !dbg !64
@array_map = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !72
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !66
@llvm.used = appending global [3 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon* @array_map to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @ingress to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @ingress(%struct.xdp_md* nocapture readonly %0) #0 section "prog" !dbg !125 {
  %2 = alloca %struct.pkt_4tuple, align 4
  %3 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !137, metadata !DIExpression()), !dbg !205
  %4 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !206
  %5 = load i32, i32* %4, align 4, !dbg !206, !tbaa !207
  %6 = zext i32 %5 to i64, !dbg !212
  %7 = inttoptr i64 %6 to i8*, !dbg !213
  call void @llvm.dbg.value(metadata i8* %7, metadata !138, metadata !DIExpression()), !dbg !205
  %8 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !214
  %9 = load i32, i32* %8, align 4, !dbg !214, !tbaa !215
  %10 = zext i32 %9 to i64, !dbg !216
  call void @llvm.dbg.value(metadata i64 %10, metadata !139, metadata !DIExpression()), !dbg !205
  %11 = inttoptr i64 %6 to %struct.ethhdr*, !dbg !217
  call void @llvm.dbg.value(metadata %struct.ethhdr* %11, metadata !140, metadata !DIExpression()), !dbg !205
  %12 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %11, i64 14, !dbg !218
  %13 = inttoptr i64 %10 to %struct.ethhdr*, !dbg !220
  %14 = icmp ugt %struct.ethhdr* %12, %13, !dbg !221
  br i1 %14, label %75, label %15, !dbg !222

15:                                               ; preds = %1
  %16 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %11, i64 0, i32 2, !dbg !223
  %17 = load i16, i16* %16, align 1, !dbg !223, !tbaa !225
  %18 = icmp eq i16 %17, 8, !dbg !228
  br i1 %18, label %19, label %75, !dbg !229

19:                                               ; preds = %15
  call void @llvm.dbg.value(metadata i8* %7, metadata !155, metadata !DIExpression(DW_OP_plus_uconst, 14, DW_OP_stack_value)), !dbg !205
  %20 = getelementptr i8, i8* %7, i64 414, !dbg !230
  %21 = bitcast i8* %20 to %struct.iphdr*, !dbg !230
  %22 = inttoptr i64 %10 to %struct.iphdr*, !dbg !232
  %23 = icmp ugt %struct.iphdr* %21, %22, !dbg !233
  br i1 %23, label %75, label %24, !dbg !234

24:                                               ; preds = %19
  %25 = getelementptr i8, i8* %7, i64 23, !dbg !235
  %26 = load i8, i8* %25, align 1, !dbg !235, !tbaa !237
  %27 = icmp eq i8 %26, 17, !dbg !239
  br i1 %27, label %75, label %28, !dbg !240

28:                                               ; preds = %24
  call void @llvm.dbg.value(metadata i8* %20, metadata !174, metadata !DIExpression()), !dbg !205
  %29 = getelementptr i8, i8* %7, i64 814, !dbg !241
  %30 = bitcast i8* %29 to %struct.tcphdr*, !dbg !241
  %31 = inttoptr i64 %10 to %struct.tcphdr*, !dbg !243
  %32 = icmp ugt %struct.tcphdr* %30, %31, !dbg !244
  br i1 %32, label %75, label %33, !dbg !245

33:                                               ; preds = %28
  %34 = bitcast %struct.pkt_4tuple* %2 to i8*, !dbg !246
  call void @llvm.lifetime.start.p0i8(i64 12, i8* nonnull %34) #3, !dbg !246
  call void @llvm.dbg.declare(metadata %struct.pkt_4tuple* %2, metadata !196, metadata !DIExpression()), !dbg !247
  %35 = getelementptr i8, i8* %7, i64 26, !dbg !248
  %36 = bitcast i8* %35 to i32*, !dbg !248
  %37 = load i32, i32* %36, align 4, !dbg !248, !tbaa !249
  %38 = getelementptr i8, i8* %7, i64 30, !dbg !250
  %39 = bitcast i8* %38 to i32*, !dbg !250
  %40 = load i32, i32* %39, align 4, !dbg !250, !tbaa !251
  %41 = bitcast i8* %20 to i16*, !dbg !252
  %42 = load i16, i16* %41, align 4, !dbg !252, !tbaa !253
  %43 = getelementptr i8, i8* %7, i64 416, !dbg !255
  %44 = bitcast i8* %43 to i16*, !dbg !255
  %45 = load i16, i16* %44, align 2, !dbg !255, !tbaa !256
  call void @llvm.dbg.value(metadata %struct.pkt_4tuple* %2, metadata !257, metadata !DIExpression()), !dbg !266
  call void @llvm.dbg.value(metadata i32 %37, metadata !262, metadata !DIExpression()), !dbg !266
  call void @llvm.dbg.value(metadata i32 %40, metadata !263, metadata !DIExpression()), !dbg !266
  call void @llvm.dbg.value(metadata i16 %42, metadata !264, metadata !DIExpression()), !dbg !266
  call void @llvm.dbg.value(metadata i16 %45, metadata !265, metadata !DIExpression()), !dbg !266
  %46 = getelementptr inbounds %struct.pkt_4tuple, %struct.pkt_4tuple* %2, i64 0, i32 0, !dbg !268
  store i32 %37, i32* %46, align 4, !dbg !269, !tbaa !270
  %47 = getelementptr inbounds %struct.pkt_4tuple, %struct.pkt_4tuple* %2, i64 0, i32 1, !dbg !272
  store i32 %40, i32* %47, align 4, !dbg !273, !tbaa !274
  %48 = getelementptr inbounds %struct.pkt_4tuple, %struct.pkt_4tuple* %2, i64 0, i32 2, !dbg !275
  store i16 %42, i16* %48, align 4, !dbg !276, !tbaa !277
  %49 = getelementptr inbounds %struct.pkt_4tuple, %struct.pkt_4tuple* %2, i64 0, i32 3, !dbg !278
  store i16 %45, i16* %49, align 2, !dbg !279, !tbaa !280
  %50 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @array_map to i8*), i8* nonnull %34) #3, !dbg !281
  call void @llvm.dbg.value(metadata i8* %50, metadata !197, metadata !DIExpression()), !dbg !205
  %51 = bitcast i32* %3 to i8*, !dbg !282
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %51) #3, !dbg !282
  %52 = getelementptr i8, i8* %7, i64 422, !dbg !283
  %53 = bitcast i8* %52 to i32*, !dbg !283
  call void @llvm.dbg.value(metadata i32 undef, metadata !199, metadata !DIExpression()), !dbg !205
  %54 = icmp eq i8* %50, null, !dbg !284
  br i1 %54, label %64, label %55, !dbg !285

55:                                               ; preds = %33
  call void @llvm.dbg.value(metadata i32* %3, metadata !198, metadata !DIExpression(DW_OP_deref)), !dbg !205
  %56 = call i64 inttoptr (i64 113 to i64 (i8*, i32, i8*)*)(i8* nonnull %51, i32 4, i8* nonnull %50) #3, !dbg !286
  %57 = icmp eq i64 %56, 0, !dbg !289
  br i1 %57, label %58, label %73, !dbg !290

58:                                               ; preds = %55
  %59 = load i32, i32* %53, align 4, !dbg !291, !tbaa !292
  call void @llvm.dbg.value(metadata i32 %59, metadata !293, metadata !DIExpression()) #3, !dbg !300
  %60 = call i32 @llvm.bswap.i32(i32 %59) #3, !dbg !302
  %61 = load i32, i32* %3, align 4, !dbg !291, !tbaa !303
  call void @llvm.dbg.value(metadata i32 %61, metadata !198, metadata !DIExpression()), !dbg !205
  %62 = sub i32 %60, %61, !dbg !291
  call void @llvm.dbg.value(metadata i32 %62, metadata !293, metadata !DIExpression()) #3, !dbg !304
  %63 = call i32 @llvm.bswap.i32(i32 %62) #3, !dbg !306
  store i32 %63, i32* %53, align 4, !dbg !307, !tbaa !292
  br label %73, !dbg !308

64:                                               ; preds = %33
  %65 = load i32, i32* %53, align 4, !dbg !309, !tbaa !292
  call void @llvm.dbg.value(metadata i32 %65, metadata !293, metadata !DIExpression()) #3, !dbg !310
  %66 = call i32 @llvm.bswap.i32(i32 %65) #3, !dbg !312
  call void @llvm.dbg.value(metadata i32 %66, metadata !198, metadata !DIExpression()), !dbg !205
  store i32 %66, i32* %3, align 4, !dbg !313, !tbaa !303
  call void @llvm.dbg.value(metadata i32* %3, metadata !198, metadata !DIExpression(DW_OP_deref)), !dbg !205
  %67 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* bitcast (%struct.anon* @array_map to i8*), i8* nonnull %34, i8* nonnull %51, i64 0) #3, !dbg !314
  store i32 0, i32* %53, align 4, !dbg !315, !tbaa !292
  call void @llvm.dbg.value(metadata i8* %20, metadata !200, metadata !DIExpression()), !dbg !316
  call void @llvm.dbg.value(metadata i16 undef, metadata !203, metadata !DIExpression()), !dbg !316
  %68 = getelementptr i8, i8* %7, i64 426, !dbg !317
  %69 = bitcast i8* %68 to i16*, !dbg !317
  %70 = load i16, i16* %69, align 4, !dbg !318
  %71 = and i16 %70, -4609, !dbg !319
  %72 = or i16 %71, 512, !dbg !319
  store i16 %72, i16* %69, align 4, !dbg !319
  call void @llvm.dbg.value(metadata i16 undef, metadata !204, metadata !DIExpression()), !dbg !316
  br label %73

73:                                               ; preds = %58, %64, %55
  %74 = phi i32 [ -1, %55 ], [ 2, %64 ], [ 2, %58 ], !dbg !205
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %51) #3, !dbg !320
  call void @llvm.lifetime.end.p0i8(i64 12, i8* nonnull %34) #3, !dbg !320
  br label %75

75:                                               ; preds = %19, %24, %28, %73, %15, %1
  %76 = phi i32 [ 1, %1 ], [ 2, %15 ], [ 1, %19 ], [ 2, %24 ], [ %74, %73 ], [ 1, %28 ], !dbg !205
  ret i32 %76, !dbg !320
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.bswap.i32(i32) #1

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nounwind willreturn }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!121, !122, !123}
!llvm.ident = !{!124}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "key0", scope: !2, file: !55, line: 39, type: !56, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !43, globals: !52, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "server/ingress.c", directory: "/home/intro_cn/Downloads/xdp-router")
!4 = !{!5, !14}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 3153, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "/usr/include/linux/bpf.h", directory: "")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0, isUnsigned: true)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1, isUnsigned: true)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2, isUnsigned: true)
!12 = !DIEnumerator(name: "XDP_TX", value: 3, isUnsigned: true)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4, isUnsigned: true)
!14 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !15, line: 40, baseType: !7, size: 32, elements: !16)
!15 = !DIFile(filename: "/usr/include/netinet/in.h", directory: "")
!16 = !{!17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28, !29, !30, !31, !32, !33, !34, !35, !36, !37, !38, !39, !40, !41, !42}
!17 = !DIEnumerator(name: "IPPROTO_IP", value: 0, isUnsigned: true)
!18 = !DIEnumerator(name: "IPPROTO_ICMP", value: 1, isUnsigned: true)
!19 = !DIEnumerator(name: "IPPROTO_IGMP", value: 2, isUnsigned: true)
!20 = !DIEnumerator(name: "IPPROTO_IPIP", value: 4, isUnsigned: true)
!21 = !DIEnumerator(name: "IPPROTO_TCP", value: 6, isUnsigned: true)
!22 = !DIEnumerator(name: "IPPROTO_EGP", value: 8, isUnsigned: true)
!23 = !DIEnumerator(name: "IPPROTO_PUP", value: 12, isUnsigned: true)
!24 = !DIEnumerator(name: "IPPROTO_UDP", value: 17, isUnsigned: true)
!25 = !DIEnumerator(name: "IPPROTO_IDP", value: 22, isUnsigned: true)
!26 = !DIEnumerator(name: "IPPROTO_TP", value: 29, isUnsigned: true)
!27 = !DIEnumerator(name: "IPPROTO_DCCP", value: 33, isUnsigned: true)
!28 = !DIEnumerator(name: "IPPROTO_IPV6", value: 41, isUnsigned: true)
!29 = !DIEnumerator(name: "IPPROTO_RSVP", value: 46, isUnsigned: true)
!30 = !DIEnumerator(name: "IPPROTO_GRE", value: 47, isUnsigned: true)
!31 = !DIEnumerator(name: "IPPROTO_ESP", value: 50, isUnsigned: true)
!32 = !DIEnumerator(name: "IPPROTO_AH", value: 51, isUnsigned: true)
!33 = !DIEnumerator(name: "IPPROTO_MTP", value: 92, isUnsigned: true)
!34 = !DIEnumerator(name: "IPPROTO_BEETPH", value: 94, isUnsigned: true)
!35 = !DIEnumerator(name: "IPPROTO_ENCAP", value: 98, isUnsigned: true)
!36 = !DIEnumerator(name: "IPPROTO_PIM", value: 103, isUnsigned: true)
!37 = !DIEnumerator(name: "IPPROTO_COMP", value: 108, isUnsigned: true)
!38 = !DIEnumerator(name: "IPPROTO_SCTP", value: 132, isUnsigned: true)
!39 = !DIEnumerator(name: "IPPROTO_UDPLITE", value: 136, isUnsigned: true)
!40 = !DIEnumerator(name: "IPPROTO_MPLS", value: 137, isUnsigned: true)
!41 = !DIEnumerator(name: "IPPROTO_RAW", value: 255, isUnsigned: true)
!42 = !DIEnumerator(name: "IPPROTO_MAX", value: 256, isUnsigned: true)
!43 = !{!44, !45, !46, !49}
!44 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!45 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!46 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !47, size: 64)
!47 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !48, line: 25, baseType: !49)
!48 = !DIFile(filename: "/usr/include/bits/stdint-uintn.h", directory: "")
!49 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !50, line: 40, baseType: !51)
!50 = !DIFile(filename: "/usr/include/bits/types.h", directory: "")
!51 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!52 = !{!0, !53, !58, !60, !62, !64, !66, !72, !99, !107, !114}
!53 = !DIGlobalVariableExpression(var: !54, expr: !DIExpression())
!54 = distinct !DIGlobalVariable(name: "key1", scope: !2, file: !55, line: 40, type: !56, isLocal: false, isDefinition: true)
!55 = !DIFile(filename: "server/../tools.h", directory: "/home/intro_cn/Downloads/xdp-router")
!56 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !57)
!57 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!58 = !DIGlobalVariableExpression(var: !59, expr: !DIExpression())
!59 = distinct !DIGlobalVariable(name: "c0", scope: !2, file: !55, line: 41, type: !56, isLocal: false, isDefinition: true)
!60 = !DIGlobalVariableExpression(var: !61, expr: !DIExpression())
!61 = distinct !DIGlobalVariable(name: "c1", scope: !2, file: !55, line: 42, type: !56, isLocal: false, isDefinition: true)
!62 = !DIGlobalVariableExpression(var: !63, expr: !DIExpression())
!63 = distinct !DIGlobalVariable(name: "c2", scope: !2, file: !55, line: 43, type: !56, isLocal: false, isDefinition: true)
!64 = !DIGlobalVariableExpression(var: !65, expr: !DIExpression())
!65 = distinct !DIGlobalVariable(name: "c3", scope: !2, file: !55, line: 44, type: !56, isLocal: false, isDefinition: true)
!66 = !DIGlobalVariableExpression(var: !67, expr: !DIExpression())
!67 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 47, type: !68, isLocal: false, isDefinition: true)
!68 = !DICompositeType(tag: DW_TAG_array_type, baseType: !69, size: 32, elements: !70)
!69 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!70 = !{!71}
!71 = !DISubrange(count: 4)
!72 = !DIGlobalVariableExpression(var: !73, expr: !DIExpression())
!73 = distinct !DIGlobalVariable(name: "array_map", scope: !2, file: !74, line: 26, type: !75, isLocal: false, isDefinition: true)
!74 = !DIFile(filename: "server/server.h", directory: "/home/intro_cn/Downloads/xdp-router")
!75 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !74, line: 20, size: 320, elements: !76)
!76 = !{!77, !82, !87, !96, !98}
!77 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !75, file: !74, line: 21, baseType: !78, size: 64)
!78 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !79, size: 64)
!79 = !DICompositeType(tag: DW_TAG_array_type, baseType: !57, size: 32, elements: !80)
!80 = !{!81}
!81 = !DISubrange(count: 1)
!82 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !75, file: !74, line: 22, baseType: !83, size: 64, offset: 64)
!83 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !84, size: 64)
!84 = !DICompositeType(tag: DW_TAG_array_type, baseType: !57, size: 320000, elements: !85)
!85 = !{!86}
!86 = !DISubrange(count: 10000)
!87 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !75, file: !74, line: 23, baseType: !88, size: 64, offset: 128)
!88 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !89, size: 64)
!89 = !DIDerivedType(tag: DW_TAG_typedef, name: "map_key", file: !74, line: 17, baseType: !90)
!90 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "pkt_4tuple", file: !74, line: 11, size: 96, elements: !91)
!91 = !{!92, !93, !94, !95}
!92 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !90, file: !74, line: 13, baseType: !7, size: 32)
!93 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !90, file: !74, line: 14, baseType: !7, size: 32, offset: 32)
!94 = !DIDerivedType(tag: DW_TAG_member, name: "src", scope: !90, file: !74, line: 15, baseType: !51, size: 16, offset: 64)
!95 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !90, file: !74, line: 16, baseType: !51, size: 16, offset: 80)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !75, file: !74, line: 24, baseType: !97, size: 64, offset: 192)
!97 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!98 = !DIDerivedType(tag: DW_TAG_member, name: "pinning", scope: !75, file: !74, line: 25, baseType: !78, size: 64, offset: 256)
!99 = !DIGlobalVariableExpression(var: !100, expr: !DIExpression())
!100 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !101, line: 50, type: !102, isLocal: true, isDefinition: true)
!101 = !DIFile(filename: "/usr/include/bpf/bpf_helper_defs.h", directory: "")
!102 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !103, size: 64)
!103 = !DISubroutineType(types: !104)
!104 = !{!44, !44, !105}
!105 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !106, size: 64)
!106 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!107 = !DIGlobalVariableExpression(var: !108, expr: !DIExpression())
!108 = distinct !DIGlobalVariable(name: "bpf_probe_read_kernel", scope: !2, file: !101, line: 2751, type: !109, isLocal: true, isDefinition: true)
!109 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !110, size: 64)
!110 = !DISubroutineType(types: !111)
!111 = !{!45, !44, !112, !105}
!112 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !113, line: 27, baseType: !7)
!113 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "")
!114 = !DIGlobalVariableExpression(var: !115, expr: !DIExpression())
!115 = distinct !DIGlobalVariable(name: "bpf_map_update_elem", scope: !2, file: !101, line: 72, type: !116, isLocal: true, isDefinition: true)
!116 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !117, size: 64)
!117 = !DISubroutineType(types: !118)
!118 = !{!45, !44, !105, !105, !119}
!119 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !113, line: 31, baseType: !120)
!120 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!121 = !{i32 7, !"Dwarf Version", i32 4}
!122 = !{i32 2, !"Debug Info Version", i32 3}
!123 = !{i32 1, !"wchar_size", i32 4}
!124 = !{!"clang version 10.0.0-4ubuntu1 "}
!125 = distinct !DISubprogram(name: "ingress", scope: !3, file: !3, line: 6, type: !126, scopeLine: 7, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !136)
!126 = !DISubroutineType(types: !127)
!127 = !{!57, !128}
!128 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !129, size: 64)
!129 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 3164, size: 160, elements: !130)
!130 = !{!131, !132, !133, !134, !135}
!131 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !129, file: !6, line: 3165, baseType: !112, size: 32)
!132 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !129, file: !6, line: 3166, baseType: !112, size: 32, offset: 32)
!133 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !129, file: !6, line: 3167, baseType: !112, size: 32, offset: 64)
!134 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !129, file: !6, line: 3169, baseType: !112, size: 32, offset: 96)
!135 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !129, file: !6, line: 3170, baseType: !112, size: 32, offset: 128)
!136 = !{!137, !138, !139, !140, !155, !174, !196, !197, !198, !199, !200, !203, !204}
!137 = !DILocalVariable(name: "ctx", arg: 1, scope: !125, file: !3, line: 6, type: !128)
!138 = !DILocalVariable(name: "data", scope: !125, file: !3, line: 8, type: !44)
!139 = !DILocalVariable(name: "data_end", scope: !125, file: !3, line: 9, type: !44)
!140 = !DILocalVariable(name: "eth", scope: !125, file: !3, line: 10, type: !141)
!141 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !142, size: 64)
!142 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !143, line: 163, size: 112, elements: !144)
!143 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "")
!144 = !{!145, !150, !151}
!145 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !142, file: !143, line: 164, baseType: !146, size: 48)
!146 = !DICompositeType(tag: DW_TAG_array_type, baseType: !147, size: 48, elements: !148)
!147 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!148 = !{!149}
!149 = !DISubrange(count: 6)
!150 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !142, file: !143, line: 165, baseType: !146, size: 48, offset: 48)
!151 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !142, file: !143, line: 166, baseType: !152, size: 16, offset: 96)
!152 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !153, line: 25, baseType: !154)
!153 = !DIFile(filename: "/usr/include/linux/types.h", directory: "")
!154 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !113, line: 24, baseType: !51)
!155 = !DILocalVariable(name: "ip", scope: !125, file: !3, line: 13, type: !156)
!156 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !157, size: 64)
!157 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !158, line: 86, size: 160, elements: !159)
!158 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "")
!159 = !{!160, !162, !163, !164, !165, !166, !167, !168, !169, !171, !173}
!160 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !157, file: !158, line: 88, baseType: !161, size: 4, flags: DIFlagBitField, extraData: i64 0)
!161 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !113, line: 21, baseType: !147)
!162 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !157, file: !158, line: 89, baseType: !161, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!163 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !157, file: !158, line: 96, baseType: !161, size: 8, offset: 8)
!164 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !157, file: !158, line: 97, baseType: !152, size: 16, offset: 16)
!165 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !157, file: !158, line: 98, baseType: !152, size: 16, offset: 32)
!166 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !157, file: !158, line: 99, baseType: !152, size: 16, offset: 48)
!167 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !157, file: !158, line: 100, baseType: !161, size: 8, offset: 64)
!168 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !157, file: !158, line: 101, baseType: !161, size: 8, offset: 72)
!169 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !157, file: !158, line: 102, baseType: !170, size: 16, offset: 80)
!170 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !153, line: 31, baseType: !154)
!171 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !157, file: !158, line: 103, baseType: !172, size: 32, offset: 96)
!172 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !153, line: 27, baseType: !112)
!173 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !157, file: !158, line: 104, baseType: !172, size: 32, offset: 128)
!174 = !DILocalVariable(name: "tcp", scope: !125, file: !3, line: 16, type: !175)
!175 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !176, size: 64)
!176 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tcphdr", file: !177, line: 25, size: 160, elements: !178)
!177 = !DIFile(filename: "/usr/include/linux/tcp.h", directory: "")
!178 = !{!179, !180, !181, !182, !183, !184, !185, !186, !187, !188, !189, !190, !191, !192, !193, !194, !195}
!179 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !176, file: !177, line: 26, baseType: !152, size: 16)
!180 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !176, file: !177, line: 27, baseType: !152, size: 16, offset: 16)
!181 = !DIDerivedType(tag: DW_TAG_member, name: "seq", scope: !176, file: !177, line: 28, baseType: !172, size: 32, offset: 32)
!182 = !DIDerivedType(tag: DW_TAG_member, name: "ack_seq", scope: !176, file: !177, line: 29, baseType: !172, size: 32, offset: 64)
!183 = !DIDerivedType(tag: DW_TAG_member, name: "res1", scope: !176, file: !177, line: 31, baseType: !154, size: 4, offset: 96, flags: DIFlagBitField, extraData: i64 96)
!184 = !DIDerivedType(tag: DW_TAG_member, name: "doff", scope: !176, file: !177, line: 32, baseType: !154, size: 4, offset: 100, flags: DIFlagBitField, extraData: i64 96)
!185 = !DIDerivedType(tag: DW_TAG_member, name: "fin", scope: !176, file: !177, line: 33, baseType: !154, size: 1, offset: 104, flags: DIFlagBitField, extraData: i64 96)
!186 = !DIDerivedType(tag: DW_TAG_member, name: "syn", scope: !176, file: !177, line: 34, baseType: !154, size: 1, offset: 105, flags: DIFlagBitField, extraData: i64 96)
!187 = !DIDerivedType(tag: DW_TAG_member, name: "rst", scope: !176, file: !177, line: 35, baseType: !154, size: 1, offset: 106, flags: DIFlagBitField, extraData: i64 96)
!188 = !DIDerivedType(tag: DW_TAG_member, name: "psh", scope: !176, file: !177, line: 36, baseType: !154, size: 1, offset: 107, flags: DIFlagBitField, extraData: i64 96)
!189 = !DIDerivedType(tag: DW_TAG_member, name: "ack", scope: !176, file: !177, line: 37, baseType: !154, size: 1, offset: 108, flags: DIFlagBitField, extraData: i64 96)
!190 = !DIDerivedType(tag: DW_TAG_member, name: "urg", scope: !176, file: !177, line: 38, baseType: !154, size: 1, offset: 109, flags: DIFlagBitField, extraData: i64 96)
!191 = !DIDerivedType(tag: DW_TAG_member, name: "ece", scope: !176, file: !177, line: 39, baseType: !154, size: 1, offset: 110, flags: DIFlagBitField, extraData: i64 96)
!192 = !DIDerivedType(tag: DW_TAG_member, name: "cwr", scope: !176, file: !177, line: 40, baseType: !154, size: 1, offset: 111, flags: DIFlagBitField, extraData: i64 96)
!193 = !DIDerivedType(tag: DW_TAG_member, name: "window", scope: !176, file: !177, line: 55, baseType: !152, size: 16, offset: 112)
!194 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !176, file: !177, line: 56, baseType: !170, size: 16, offset: 128)
!195 = !DIDerivedType(tag: DW_TAG_member, name: "urg_ptr", scope: !176, file: !177, line: 57, baseType: !152, size: 16, offset: 144)
!196 = !DILocalVariable(name: "key", scope: !125, file: !3, line: 18, type: !89)
!197 = !DILocalVariable(name: "ptr", scope: !125, file: !3, line: 20, type: !97)
!198 = !DILocalVariable(name: "delta", scope: !125, file: !3, line: 21, type: !7)
!199 = !DILocalVariable(name: "pre_ack", scope: !125, file: !3, line: 21, type: !7)
!200 = !DILocalVariable(name: "casted_ptr", scope: !201, file: !3, line: 36, type: !46)
!201 = distinct !DILexicalBlock(scope: !202, file: !3, line: 30, column: 5)
!202 = distinct !DILexicalBlock(scope: !125, file: !3, line: 22, column: 8)
!203 = !DILocalVariable(name: "old_flags_n", scope: !201, file: !3, line: 37, type: !47)
!204 = !DILocalVariable(name: "new_flags_n", scope: !201, file: !3, line: 41, type: !51)
!205 = !DILocation(line: 0, scope: !125)
!206 = !DILocation(line: 8, column: 34, scope: !125)
!207 = !{!208, !209, i64 0}
!208 = !{!"xdp_md", !209, i64 0, !209, i64 4, !209, i64 8, !209, i64 12, !209, i64 16}
!209 = !{!"int", !210, i64 0}
!210 = !{!"omnipotent char", !211, i64 0}
!211 = !{!"Simple C/C++ TBAA"}
!212 = !DILocation(line: 8, column: 23, scope: !125)
!213 = !DILocation(line: 8, column: 16, scope: !125)
!214 = !DILocation(line: 9, column: 38, scope: !125)
!215 = !{!208, !209, i64 4}
!216 = !DILocation(line: 9, column: 27, scope: !125)
!217 = !DILocation(line: 10, column: 24, scope: !125)
!218 = !DILocation(line: 11, column: 11, scope: !219)
!219 = distinct !DILexicalBlock(scope: !125, file: !3, line: 11, column: 8)
!220 = !DILocation(line: 11, column: 25, scope: !219)
!221 = !DILocation(line: 11, column: 24, scope: !219)
!222 = !DILocation(line: 11, column: 8, scope: !125)
!223 = !DILocation(line: 12, column: 13, scope: !224)
!224 = distinct !DILexicalBlock(scope: !125, file: !3, line: 12, column: 8)
!225 = !{!226, !227, i64 12}
!226 = !{!"ethhdr", !210, i64 0, !210, i64 6, !227, i64 12}
!227 = !{!"short", !210, i64 0}
!228 = !DILocation(line: 12, column: 20, scope: !224)
!229 = !DILocation(line: 12, column: 8, scope: !125)
!230 = !DILocation(line: 14, column: 10, scope: !231)
!231 = distinct !DILexicalBlock(scope: !125, file: !3, line: 14, column: 8)
!232 = !DILocation(line: 14, column: 23, scope: !231)
!233 = !DILocation(line: 14, column: 22, scope: !231)
!234 = !DILocation(line: 14, column: 8, scope: !125)
!235 = !DILocation(line: 15, column: 12, scope: !236)
!236 = distinct !DILexicalBlock(scope: !125, file: !3, line: 15, column: 8)
!237 = !{!238, !210, i64 9}
!238 = !{!"iphdr", !210, i64 0, !210, i64 0, !210, i64 1, !227, i64 2, !227, i64 4, !227, i64 6, !210, i64 8, !210, i64 9, !227, i64 10, !209, i64 12, !209, i64 16}
!239 = !DILocation(line: 15, column: 20, scope: !236)
!240 = !DILocation(line: 15, column: 8, scope: !125)
!241 = !DILocation(line: 17, column: 11, scope: !242)
!242 = distinct !DILexicalBlock(scope: !125, file: !3, line: 17, column: 8)
!243 = !DILocation(line: 17, column: 25, scope: !242)
!244 = !DILocation(line: 17, column: 24, scope: !242)
!245 = !DILocation(line: 17, column: 8, scope: !125)
!246 = !DILocation(line: 18, column: 5, scope: !125)
!247 = !DILocation(line: 18, column: 13, scope: !125)
!248 = !DILocation(line: 19, column: 23, scope: !125)
!249 = !{!238, !209, i64 12}
!250 = !DILocation(line: 19, column: 33, scope: !125)
!251 = !{!238, !209, i64 16}
!252 = !DILocation(line: 19, column: 44, scope: !125)
!253 = !{!254, !227, i64 0}
!254 = !{!"tcphdr", !227, i64 0, !227, i64 2, !209, i64 4, !209, i64 8, !227, i64 12, !227, i64 12, !227, i64 13, !227, i64 13, !227, i64 13, !227, i64 13, !227, i64 13, !227, i64 13, !227, i64 13, !227, i64 13, !227, i64 14, !227, i64 16, !227, i64 18}
!255 = !DILocation(line: 19, column: 56, scope: !125)
!256 = !{!254, !227, i64 2}
!257 = !DILocalVariable(name: "key", arg: 1, scope: !258, file: !74, line: 28, type: !88)
!258 = distinct !DISubprogram(name: "key_init", scope: !74, file: !74, line: 28, type: !259, scopeLine: 29, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !261)
!259 = !DISubroutineType(types: !260)
!260 = !{null, !88, !7, !7, !51, !51}
!261 = !{!257, !262, !263, !264, !265}
!262 = !DILocalVariable(name: "sa", arg: 2, scope: !258, file: !74, line: 28, type: !7)
!263 = !DILocalVariable(name: "da", arg: 3, scope: !258, file: !74, line: 28, type: !7)
!264 = !DILocalVariable(name: "s", arg: 4, scope: !258, file: !74, line: 28, type: !51)
!265 = !DILocalVariable(name: "d", arg: 5, scope: !258, file: !74, line: 28, type: !51)
!266 = !DILocation(line: 0, scope: !258, inlinedAt: !267)
!267 = distinct !DILocation(line: 19, column: 5, scope: !125)
!268 = !DILocation(line: 30, column: 7, scope: !258, inlinedAt: !267)
!269 = !DILocation(line: 30, column: 12, scope: !258, inlinedAt: !267)
!270 = !{!271, !209, i64 0}
!271 = !{!"pkt_4tuple", !209, i64 0, !209, i64 4, !227, i64 8, !227, i64 10}
!272 = !DILocation(line: 31, column: 7, scope: !258, inlinedAt: !267)
!273 = !DILocation(line: 31, column: 12, scope: !258, inlinedAt: !267)
!274 = !{!271, !209, i64 4}
!275 = !DILocation(line: 32, column: 7, scope: !258, inlinedAt: !267)
!276 = !DILocation(line: 32, column: 10, scope: !258, inlinedAt: !267)
!277 = !{!271, !227, i64 8}
!278 = !DILocation(line: 33, column: 7, scope: !258, inlinedAt: !267)
!279 = !DILocation(line: 33, column: 11, scope: !258, inlinedAt: !267)
!280 = !{!271, !227, i64 10}
!281 = !DILocation(line: 20, column: 14, scope: !125)
!282 = !DILocation(line: 21, column: 5, scope: !125)
!283 = !DILocation(line: 21, column: 28, scope: !125)
!284 = !DILocation(line: 22, column: 8, scope: !202)
!285 = !DILocation(line: 22, column: 8, scope: !125)
!286 = !DILocation(line: 24, column: 12, scope: !287)
!287 = distinct !DILexicalBlock(scope: !288, file: !3, line: 24, column: 12)
!288 = distinct !DILexicalBlock(scope: !202, file: !3, line: 23, column: 5)
!289 = !DILocation(line: 24, column: 57, scope: !287)
!290 = !DILocation(line: 24, column: 12, scope: !288)
!291 = !DILocation(line: 25, column: 22, scope: !288)
!292 = !{!254, !209, i64 8}
!293 = !DILocalVariable(name: "__bsx", arg: 1, scope: !294, file: !295, line: 49, type: !298)
!294 = distinct !DISubprogram(name: "__bswap_32", scope: !295, file: !295, line: 49, type: !296, scopeLine: 50, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !299)
!295 = !DIFile(filename: "/usr/include/bits/byteswap.h", directory: "")
!296 = !DISubroutineType(types: !297)
!297 = !{!298, !298}
!298 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !50, line: 42, baseType: !7)
!299 = !{!293}
!300 = !DILocation(line: 0, scope: !294, inlinedAt: !301)
!301 = distinct !DILocation(line: 25, column: 22, scope: !288)
!302 = !DILocation(line: 54, column: 10, scope: !294, inlinedAt: !301)
!303 = !{!209, !209, i64 0}
!304 = !DILocation(line: 0, scope: !294, inlinedAt: !305)
!305 = distinct !DILocation(line: 25, column: 22, scope: !288)
!306 = !DILocation(line: 54, column: 10, scope: !294, inlinedAt: !305)
!307 = !DILocation(line: 25, column: 21, scope: !288)
!308 = !DILocation(line: 28, column: 5, scope: !288)
!309 = !DILocation(line: 31, column: 15, scope: !201)
!310 = !DILocation(line: 0, scope: !294, inlinedAt: !311)
!311 = distinct !DILocation(line: 31, column: 15, scope: !201)
!312 = !DILocation(line: 54, column: 10, scope: !294, inlinedAt: !311)
!313 = !DILocation(line: 31, column: 14, scope: !201)
!314 = !DILocation(line: 32, column: 9, scope: !201)
!315 = !DILocation(line: 33, column: 21, scope: !201)
!316 = !DILocation(line: 0, scope: !201)
!317 = !DILocation(line: 38, column: 14, scope: !201)
!318 = !DILocation(line: 38, column: 17, scope: !201)
!319 = !DILocation(line: 39, column: 17, scope: !201)
!320 = !DILocation(line: 45, column: 1, scope: !125)
