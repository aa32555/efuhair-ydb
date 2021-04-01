ZAA02GSCRINT ;PG&A,ZAA02G-SCRIPT,2.10,INITIALIZATION;7NOV94 2:05P;;;24APR2008  14:35
 ;Copyright (C) 1984, Patterson, Gray & Associates, Inc.
DRAW ;
 F I=1:1:11 S A=$P("TLC,HL,TRC,VL,BRC,BLC,X,TI,RI,BI,LI",",",I) S CT(I)=ZAA02G(A)
 S F="E="_ZAA02GP D CONVERT  K CT,D,E,A,OC,C,OR,F,B,X Q
 ;
CONVERT S X=$P($T(DATA+1),";",2,99),B=ZAA02G("G1"),D=1,OR="" F I=1:3:$L(X) S %R=$A(X,I)-31 S:%R'=OR OC=99,OR=%R S %C=$A(X,I+1)-31,Y=$A(X,I+2)-32 D C1 S OC=%C+1 I $L(B)>240 S @ZAA02GSCR@(102,ZAA02G,D)=B,B="",D=D+1
 S @ZAA02GSCR@(102,ZAA02G,D)=B_ZAA02G("G0") Q
C1 I %C=OC S B=B_CT(Y) Q
 S @F,B=B_E_CT(Y) Q
DATA ;
 ;$>!$?"$@"$A"$B"$C"$D"$E"$F"$G"$H"$I"$J"$K"$L"$M"$N#%>$%N$&>&&?"&@"&A"&B"&C"&D"&E"&F"&G"&H"&I"&J"&K"&L"&M"&N%
 ;
LIST R "What Document do you want to list (DIR-DOC)? ",DOC S DIR=$P(DOC,"-"),DOC=$P(DOC,"-",2) I $D(@ZAA02GSCR@(DIR,DOC))=0 W " Document not found" G LIST
 S A=.03 F I=1:1 S A=$O(@ZAA02GSCR@(DIR,DOC,A)) Q:A=""  W ^(A),!
 Q
 ;
REBUILD ; REBUILD DIRECTORY - ASSUMES ZAA02GSCRER VERSION ONLY
 R "BEGINNING DOCUMENT (NULL KILLS OLD DIRECTORIES) - ",DOC,!
 K:DOC="" @ZAA02GSCR@("DIR"),@ZAA02GSCR@("REV")
REBBACK S DT="",DOC=$G(DOC) S:'$D(ZAA02GSCR) ZAA02GSCR="^ZAA02GSCR",ZAA02GSCRP=";;2" D CASE S ZAA02GWPD="@ZAA02GSCR@(""TRANS"",DOC)"
 F I=1:1 S DOC=$O(@ZAA02GSCR@("TRANS",DOC)) Q:DOC=""  D FETCH^ZAA02GSCRER S Y=@ZAA02GSCR@("TRANS",DOC),DT=INP("DT"),YM=$E(Y,2,5),DY=$P(DT,"/",2),OSET="" D DIR^ZAA02GSCRER1
 Q
RBSING ; REBUILD SINGLE INDEX IN DIRECTORY - NAMELY ITEM 6
 S:'$D(ZAA02GSCR) ZAA02GSCR="^ZAA02GSCR" D CASE S ZAA02GWPD="@ZAA02GSCR@(""TRANS"",DOC)"
 K @ZAA02GSCR@("DIR",6) S DOC=""
 F I=1:1 S DOC=$O(@ZAA02GSCR@("DIR",99,DOC)) Q:DOC=""  S B=$G(^(DOC)) F J=6,7 S B=$P($P(B,"`",J),"~") S:B]"" @ZAA02GSCR@("DIR",6,$TR(B,LC,UP),DOC)=""
 Q
 ;
CASE S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz" Q
 ;
SCAN S DOC="" F J=1:1 S DOC=$O(@ZAA02GSCR@("TRANS",DOC)) Q:DOC=""  I $D(^(DOC,.011,"STATS")),^("STATS")["-" W DOC,?7,^("STATS"),!
 Q
STATS ; CORRECTION TO STATS - FOR ZAA02GSCRER TEMPLATE - NOT FOR VA
 S TMPL="PROC1,PROC2,TEMPLATE,TEMPLATE2,TR,SITEC,PROVIDER,PATIENT,MR,DOB,DD,DT,TM,REV,DIST,CONSULT,CC1,CC2,WORK"
 D CASE
 S DOC="" F J=1:1 S DOC=$O(@ZAA02GSCR@("TRANS",DOC)) Q:DOC=""  I $D(^(DOC,.011,"STATS")) W DOC,?7,^("STATS"),! D ST1
 Q
ST1 S Y=@ZAA02GSCR@("TRANS",DOC,.011) F J=1,5,6,7,12 S INP($P(TMPL,",",J))=$P(Y,"`",J)
 S OCOUNT=$G(^(.011,"STATS")),A="" ; TOOK OUT WORK TYPE ( S A= )
 S TY=$TR(INP("PROC1"),LC,UP),TY1=$TR(INP("SITEC"),LC,UP) S:TY="" TY="NA" S:TY1="" TY1="NA" S DT=INP("DT"),YM=$E(Y,2,5),DY=$P(DT,"/",2)
 F I=1:1:5 S M=$TR(INP($P("TR,PROC1,PROVIDER,SITEC,TR",",",I)),LC,UP) S:M="" M="NA" S:I=5 TY="TOTAL" F J=1:1:7 S $P(^(J),"+",DY)=$S($D(@ZAA02GSCR@("STATS",YM,TY1,$P("TR,TYPE,PROV,SITEC,TR",",",I),M,TY,J)):$P(^(J),"+",DY),1:0)+$P(OCOUNT,",",J)
 Q
 ;         ;
CSTATS ; CONVERT 1 LEVEL STATS TO 2 LEVEL (SITE CODE)
 ; WILL SKIP OVER DATES THAT ARE ALREADY 2 LEVEL
 D CASE S (A,B,C,D)="",A=$G(START)
 F J=1:1 S A=$O(@ZAA02GSCR@("STATS",A)) Q:A=""  W A," " F J=1:1 S B=$O(@ZAA02GSCR@("STATS",A,B)) Q:B=""  F J=1:1 S C=$O(@ZAA02GSCR@("STATS",A,B,C)) Q:C=""  F J=1:1 S D=$O(@ZAA02GSCR@("STATS",A,B,C,D)) Q:D=""  D CSTAT1
 Q
CSTAT1 Q:$D(^(D,1))#2=0  F K=1:1:7 S @ZAA02GSCR@("STATS",A,"NA",B,C,D,K)=@ZAA02GSCR@("STATS",A,B,C,D,K)
 K @ZAA02GSCR@("STATS",A,B,C,D) Q
CHCODE ; CHANGE CODE IN 106
 R "OLD CODE IS - ",OCODE,! Q:OCODE=""  R "NEW CODE IS - ",NCODE,! W "DOCUMENT CODE if different than New Code - (",NCODE,") - " R DCODE,! S:DCODE="" DCODE=NCODE S OCD1="~$"_OCODE,DCD1="" S:NCODE'="" DCD1="~$"_DCODE
 S A=0 F J=1:1 S A=$O(@ZAA02GSCR@(106,A)) Q:A=""  I $D(^(A,0,OCODE)) S B="" F J=1:1 S B=$O(@ZAA02GSCR@(106,A,0,OCODE,B)) Q:B=""  I $G(@ZAA02GSCR@(106,A,B))[OCD1 D CHCODE1
 Q
CHCODE1 S ^(B)=$P(^(B),OCD1)_DCD1_$P(^(B),OCD1,2,9) W A," ",^(B),! S:NCODE'="" @ZAA02GSCR@(106,A,0,NCODE,B)="" K @ZAA02GSCR@(106,A,0,OCODE) Q
 Q
ZAA02GACT ; REBUILDS DAMAGED ^ZAA02GACT FILE
 S A=0,B="" F J=1:1 S A=$O(@ZAA02GSCR@("DIR",3,A)) Q:A=""  F J=1:1 S B=$O(@ZAA02GSCR@("DIR",3,A,B)) Q:B=""  I '$D(^ZAA02GACT(+A,"TRANS",10000000-B)) S ^(10000000-B)="" W "."
 Q
 ;
ASCII ; dump reports to TEXT files by Provider
 K F S A="" F  S A=$O(^ZAA02GSCR("DIR",4,A)) Q:A=""  S B=""  F J=1:1:50 S B=$O(^ZAA02GSCR("DIR",4,A,B)) Q:B=""  I J=50 S F(A)=J
 S B="" F  S B=$O(F(B)) Q:B=""  D
 . D:1
 .. S FILE="PROV_"_$TR(B," ")_".TXT"
 .. I ^ZAA02G("OS")="M3" S VDV="FILE" O VDV:(FILE:"NW") U VDV
 .. I ^ZAA02G("OS")="M11" S VDV=FILE O VDV:("NW") U VDV
 .. I ^ZAA02G("OS")="DTM" S VDV=10 O VDV:(mode="W":file=FILE) S ZC="S ER=$ZC" U VDV
 . S E=""  F J=1:1:500 S E=$O(^ZAA02GSCR("DIR",4,B,E)) Q:E=""  I $O(^ZAA02GSCR("TRANS",10000000-E,.01))>.01   I $P(^(.011),"`",7)=B D
 .. I $D(^(.0115,5)) D  Q
 ... S A="" F L=5:1 Q:'$D(^(L))  S A=A_^(L)
 ... F L=2:1:$L(A,"\pard") S A=$P(A,"\pard")_$P(A,"\pard",2,999)
 ... F L=2:1:$L(A,"\par") S C=$P(A,"\par",L) D:$L(C)
 .... F M=2:1:$L(C,"\") S C=$P(C,"\")_$S($P(C,"\",2)[" ":" "_$P($P(C,"\",2,999)," ",2,9999),$P(C,"\",2,3)'["\":"",1:"\"_$P(C,"\",3,999))
 .... I C?.P Q
 .... I $L(C)<40 Q
 .... W C,!
 .... ; S I=$O(^ASCII(B,""),-1)+1,^ASCII(B,I)=C
 .. Q  S C=.03 F  S C=$O(^(C)) Q:C=""  W $P(^(C),$C(1),4),! R CCC
 . I $D(VDV) C VDV U 0 W FILE," "
 Q
 ;
HOLD ; REBUILDS HOLD DIRECTORY
 K @ZAA02GSCR@("DIR",12,"H")
 S A=0,B="" F J=1:1 S A=$O(@ZAA02GSCR@("DIR",99,A)) Q:A=""  I $P(^(A),"`",13)["H" S @ZAA02GSCR@("DIR",12,"H",A)=$TR($P(^(A),"`",11),"~") W "."
 Q
 ;
HOLDX ; REINSTATE MISSING "H" FLAGS FROM HOLD DIRECTORY
 S A=0 F  S A=$O(@ZAA02GSCR@("DIR",12,"H",A)) Q:A=""  I $P(@ZAA02GSCR@("DIR",99,A),"`",13)'["H" S K=$E($TR($P(^(A),"`",13),"H~ ")_"H~  ",1,4),$P(^(A),"`",13)=K,$P(@ZAA02GSCR@("TRANS",10000000-A),"`",13)=K
 Q
DIST ; CONVERTS lower case Distribution List to upper
 D CASE F II="",1:1:9 S ZAA02GSCR="^ZAA02GSCR"_II W !,ZAA02GSCR I $D(@ZAA02GSCR@("PARAM","DIST")) D DIST1,DIST3
 Q
DIST1 S A="" F J=1:1 S A=$O(@ZAA02GSCR@("PARAM","DIST",A)) Q:A=""  I A?.E1L.E D DIST2
 Q
DIST2 S B=$TR(A,LC,UP),@ZAA02GSCR@("PARAM","DIST",B)=@ZAA02GSCR@("PARAM","DIST",A) S C="" F J=1:1 S C=$O(@ZAA02GSCR@("PARAM","DIST",A,C)) Q:C=""  S @ZAA02GSCR@("PARAM","DIST",B,C)=@ZAA02GSCR@("PARAM","DIST",A,C)
 K @ZAA02GSCR@("PARAM","DIST",A) Q
DIST3 S A=99 F J=1:1 S A=$O(@ZAA02GSCR@(106,A)) Q:A=""  I $D(^(A,.03)) S B=$P(^(.03),"\",17) I B?.E1L.E S $P(^(.03),"\",17)=$TR(B,LC,UP)
 Q
 ;
MACRO ; CONSOLODATES MACRO FILES - REMOVES COMMON MACROS THAT ALREADY
 ; EXIST IN THE SYS FILE
 R "CONSOLIDATE MACRO FILES - PRESS RETURN TO CONTINUE ",A,!
 ;
 S (A,B)="",SYS="" F  S A=$O(^ZAA02GWP("~G",A)) Q:A=""  S C=$P(^(A),"\",2) I C="sys" S SYS=SYS_A_","
 I $L(SYS,",")>2 W " THERE ARE MORE THAN ONE SYS FILE" Q
 S A=$G(^ZAA02GWP(105,"sys")),SYS=$P(A,",",3)
 W "SYS file is document - ",SYS,!
 S I=""  F  S I=$O(^ZAA02GWP("~G",I)) Q:I=""  I I'=SYS S K=$P(^(I),"\",2),T=0 D MACRO1
 Q
MACRO1 W !,"DOCUMENT - ",I,?15,K,?30 I '$D(^ZAA02GWP(105,K)) W "no macros" Q
 S N="" F S=0:1 S N=$O(^ZAA02GWP(105,K,N)) Q:N=""  D:$D(^ZAA02GWP(105,"sys",N)) MACRO2
 W $J(S,5)," macros",?45,$J(T,5)," duplicates" Q
MACRO2 S (D,E)="" F  S D=$O(^ZAA02GWP(105,K,N,D)) Q:D=""  S F=^(D),E=$O(^ZAA02GWP(105,"sys",N,E)) Q:D'=E  Q:D=""  Q:$G(^(E))'=F
 Q:D'=""  S T=T+1,B=^ZAA02GWP(105,K,N) I $D(^ZAA02GWP("~G",I,B)) D MACRO3
 K ^ZAA02GWP(105,K,N) Q
MACRO3 S C=+^(B) S:^(B)'?1".".E B=C,C=+^(C) K ^(B) F  S B=$O(^(B)) Q:B=""  S D=$O(^(B)) K:$P(^(B),$C(1),4)="" ^(B) I $D(^(B)) K:D="" ^(B) I D'="" Q:$E($P(^(B),$C(1),4))="."&(^(B)'["[")  K ^(B)
 S B=$O(^(C)) S:B'="" $P(^(B),$C(1))=C I C>.03,B="",$P(^(C),$C(1),4)="" K ^(C)
 Q
MACROS ;  SCAN MACRO FILES FOR "EMPTY" MACRO NAMES
 S (I,J)=""  F  S I=$O(^ZAA02GWP(105,I)) Q:I=""  W !,I S M=$P($G(^(I)),",",3) F K=0:0 S J=$O(^ZAA02GWP(105,I,J)) Q:J=""  I $D(^(J))=1!($G(^(J,1))="") S K=K+10 W:K=80 ! S:K=80 K=10 W ?K,J D MACROS1
 Q
MACROS1 S L=$G(^ZAA02GWP(105,I,J)) I $P($G(^ZAA02GWP("~G",M,L)),$C(1),4)[("."_J) S G=L
 E  S G=+$G(^ZAA02GWP("~G",M,L))
 I $P(^(G),$C(1),4)[("."_J) S $P(^(G),$C(1),4)=""
 K ^ZAA02GWP(105,I,J) Q