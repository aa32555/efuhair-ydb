%ZAA02GEDRL3 ;;%AA UTILS;1.24;SUBR: PACKAGE LOOKUP;24APR91  16:26
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
LKUP N C,I,L,S,T,W,Y,BR,CN,NK,NO,PG,TR,US,UD,FR S W=rm-lm+1,NM=$TR(X,"?",""),SF=1
        S T="S E L E C T   P A C K A G E" D ^ZAA02GEDHD K T S %R=3,%C=10 W @ZAA02GP,tLO_"Package               Description"
        S PG=1,(NK,PG(1))=NM,TR=5,BR=22,NO=0 D FETCH G:'$D(US) EXIT S NO=1 G SELECT
FETCH S NK=PG(PG),CN=0 K US,UD,LST I PG=1,NK]"",$D(@pgl@(NK)) G F2
F1 S NK=$O(@pgl@(NK)) I NK=""!($E(NK,1,$L(NM))]NM) D CLEAR Q
F2 S:CN=(BR-TR) LST=NK I CN=(BR-TR+1) S:LST]"" PG(PG+1)=LST Q
        S D=$P(^(NK),"`",2),CN=CN+1,%R=TR+CN-1,%C=10,US(CN)=NK,UD(CN)=NK_$J("",22-$L(NK))_D W @ZAA02GP,tLO_UD(CN)_tCL G F1
SELECT S L="Functions: ["_tHI_"EXIT" S:$D(PG(PG+1)) L=L_"  NEXT SCREEN" S:PG>1 L=L_"  PREV SCREEN" S L=L_"  RETURN"_tLO_"]" W pBL_tCL S %R=bl+2,%C=($L(tHI)*2+rm-lm-$L(L)\2) W @ZAA02GP,tLO_L
ASK S %R=TR+NO-1,%C=8,NK=US(NO) W @ZAA02GP,tLO_"=>"_tHI_UD(NO),@ZAA02GP,"=>"
AS R C#1 I C="" X ZAA02G("T") S ZAA02GF=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) G:"UK,DK,PU,PD,CR,EX"[ZAA02GF @ZAA02GF W *7 G AS
        G DK:C=" ",AS
UK W @ZAA02GP,tLO_"  "_UD(NO) S NO=NO-1 G:NO'<1 ASK S NO=CN G PU:PG>1,ASK
DK W @ZAA02GP,tLO_"  "_UD(NO) S NO=NO+1 G:NO'>CN ASK S NO=1 G:'$D(PG(PG+1)) ASK
PD G:'$D(PG(PG+1)) AS S PG=PG+1 D FETCH S:NO>CN NO=CN G SELECT
PU G:PG<2 AS S PG=PG-1 D FETCH G SELECT
EX W @ZAA02GP,tLO_"  "_UD(NO) S PKG="" Q
CR S PKG=US(NO) Q
EXIT K P,Y Q
CLEAR S %C=1 F %R=CN+TR:1:BR W @ZAA02GP,tCL
        Q
        ;