ZAA02GSCML1 ;PG&A,ZAA02G-MTS,1.20,LETTER PROCESSING;30DEC94 4:14P;;;18JAN98  22:08
C ;Copyright (C) 1997, Patterson, Gray & Associates, Inc.
 ;
L12 ; 2*6 LABELS
 K ^ZAA02GTSCM($J) S JJ=1,SJ=1,SP=$J("",80)
 S LT=$P(^ZAA02GWP(.9,DP,XDC),"\",2)
 F I="ZAA02GSCM","ZAA02GSCR","ZAA02GSCRP" S @I=^ZAA02GWP(.9,DP,XDC,I)
 D TMPL^ZAA02GSCRER
L12B S PJ=0,A=""
 F  S A=$O(^ZAA02GWP(.9,DP,A)) Q:A=""  I $P($G(^(A)),"\",2)=LT D L12A I A'=XDC K ^ZAA02GWP(.9,DP,A) S PJ=1
 I PJ H 5 G L12B
 S B(1)=6,B(2)=10,B(3)=1,B(4)=1,A=XDC D INIT^ZAA02GWPPC1
 F J=1:1 Q:'$D(^ZAA02GTSCM($J,J))  W ^(J),! I J#36=0 W #
 W # K ^ZAA02GWP(.9,DP,XDC)
 Q
L12A S DOC=^(A,"DOC"),SJ=SJ+1#2
 F I="FP","MR","FPMR","LTR" S @I=^(I)
 S C=0,ZAA02GWPD="^ZAA02GWP(.9,DP,A,""DOC"")",DT="" D FETCH^ZAA02GSCRER
 I $D(@ZAA02GSCM@("LETMR",MR,FPMR,LTR,FP)) K @ZAA02GSCM@("LETTYP",LTR,FP,MR),@ZAA02GSCM@("LETMR",MR,FPMR,LTR,FP) I $D(@ZAA02GSCM@("LETMR",MR,FPMR))<10 K ^(FPMR)
 S ALLVAR="PN,PA1,PA2,PCSZ" D ^ZAA02GSCRVB
 S CJ=JJ F E="PN","PA1","PA2","PCSZ" I $G(INP(E))]"" S ^ZAA02GTSCM($J,CJ)=$S(SJ:$E(^ZAA02GTSCM($J,CJ)_SP,1,45),1:$J("",5))_INP(E),CJ=CJ+1
 F CJ=CJ:1:JJ+6 I '$D(^ZAA02GTSCM($J,CJ)) S ^(CJ)=""
 S:SJ JJ=CJ+1 Q