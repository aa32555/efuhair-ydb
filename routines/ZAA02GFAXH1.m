ZAA02GFAXH1 ;PG&A,ZAA02G-FAX,1.36,MH ENCODING;19JUL96 3:47P;;;09JUL98  16:44
 ;Copyright (C) 1991-1994, Patterson, Gray and Associates Inc.
 ;
 ; I $D(^ZAA02GFAXJ) G ^ZAA02GFAXHJ
CVT D GETFNT I $P(B,"\",15)'="","YyPpSs"[$P(B,"\",15) D CVR,GETFNT S TXT=$S("YySs"[$P(B,"\",15):"~P",1:"") D LINE
 I $D(OVR) D OVR1 S A=$O(@OVR@(0)) I A S Z=.03 G ^ZAA02GFAXH5:$D(^(A))=11,^ZAA02GFAXH3
 F Z=.03:0 S Z=$O(@ZAA02GFAXD@(Z)) Q:Z=""  I $D(^(Z))#2 S TXT=^(Z) D LINE
 S TFXL=TFXL+FXL,$P(@ZAA02GFAXS@(PG),",")=FXL,PGN=PG,@ZAA02GFAXS=+$H_","_TFXL_","_PG G:$D(CVRP) CVR Q
 ;
LINE I FXL>PGL!(TXT["~P") S PG=PG+1,TFXL=TFXL+FXL,PGL=SPGL,$P(@ZAA02GFAXS@(PG-1),",")=FXL,FXL=0 Q:TXT["~P"
 G BLN:TXT="",GR:TXT["~FAX" G:$D(MF) ^ZAA02GFAXH2 I TXT'[XS S TXT=$TR(TXT,CA,CB),TXL=$L(TXT),TXW=1728-(TXL*FC+MG+CVR) G:TXW<0 LINEL F TXR=1:1:FR D LN1 H 0
 I TXT[XS D VIDEO S TXL=$L(TXT),TXW=1728-(TXL-$L(TXT,$C(0))+1*FC+MG+CVR) G:TXW<0 LINEL F TXR=1:1:FR D LN H 0
 I HP F FXL=FXL+1:1:HP-TXR+FXL S @ZAA02GFAXS@(PG,FXL)=""
 Q
LINEL S TXT=$E(TXT,1,$L(TXT)-2) G LINE
 ;
LN S LX="",L=EOL,W=MG,D=0 D CF
 F I=1:1:TXL S X=TR($A(NTX,I)),W=W+X D:X=0 CF I X["," S L=L_$S(W<32:wht(W),1:^ZAA02GFAXC(.1,W))_$P(X,",",2),W=$P(X,",",3) D:$L(L)>32 LSX
 S W=W+TXW,FNT=FNT(0),L=L_$S(W<32:wht(W),W<1729:^ZAA02GFAXC(.1,W),1:wht(0))_TRL D:$L(L)>32 LSX
 S L=L_$E("00000000",1,-$L(L)#8) D LS,LE:LX[$C(16) S FXL=FXL+1,@ZAA02GFAXS@(PG,FXL)=LX Q
CF S FNT=FNT(D),D=D+1,NTX=$TR(TXT,AL,^ZAA02GFAXF(FNT,.1,TXR)) Q
 ;
LN1 S LX="",L=EOL,W=MG,NTX=$TR(TXT,AL,^ZAA02GFAXF(FNT,.1,TXR))
 F I=1:1:TXL S X=TR($A(NTX,I)),W=W+X I X["," S L=L_$S(W<32:wht(W),1:^ZAA02GFAXC(.1,W))_$P(X,",",2),W=$P(X,",",3) D:$L(L)>32 LSX
 S W=W+TXW,L=L_$S(W<32:wht(W),W<1729:^ZAA02GFAXC(.1,W),1:wht(0))_TRL
 S L=L_$E("00000000",1,-$L(L)#8) D LSX:$L(L)>32,LS,LE:LX[$C(16) S FXL=FXL+1,@ZAA02GFAXS@(PG,FXL)=LX Q
 ;
BLN S J=$D(@ZAA02GFAXS@(PG,FXL)) F FXL=FXL+1:1:FXL+FR S ^(FXL)=""
 Q
LS F i=1:8:$L(L)\8*8 S LX=LX_$C(B($E(L,i,i+3))+C($E(L,i+4,i+7)))
 S L=$E(L,$L(L)>7*(i+8),255) Q
LSX S LX=LX_$C(B($E(L,1,4))+C($E(L,5,8)))_$C(B($E(L,9,12))+C($E(L,13,16)))_$C(B($E(L,17,20))+C($E(L,21,24)))_$C(B($E(L,25,28))+C($E(L,29,32))),L=$E(L,33,255) Q
 ;
VIDEO S F=ZAA02G("gon"),C="",FNT(0)=FNT,(W,X)=0 F L=1:1:$L(TXT,F) S J=$P(TXT,F) D:J[XS V1 S C=C_$TR(J,CA,CB),J=$P($P(TXT,F,2,99),ZAA02G("gof")) D:J[XS V1 S TXT=$P(TXT,ZAA02G("gof"),2,99),C=C_$TR(J,CD,CE)
 S TXT=C Q
V1 I J[ZAA02G("fon") F T=2:1:$L(J,ZAA02G("fon")) S J=$P(J,ZAA02G("fon"))_" "_$P(J,ZAA02G("fof"),2,99)
 F T=1:1:$L(J,XS)-1 S I=$P(J,XS,2),E=$F(XL,$E(XS_I,1,XSL))\XSL S J=$P(J,XS)_$S(E:$C(0),1:"")_$E($P(J,XS,2,99),'E+XSL,255) I E S X=$S(E=1:X>1*2+1,E=2:X>1*2,E=3:X#2+2,1:X#2),W=W+1,FNT(W)=FNT+X
 Q
LE F E=1:2:$L(LX,$C(16))-1*2 S $P(LX,$C(16),E)=$P(LX,$C(16),E)_$C(16)
 Q
 ;
GR I TXT[" FONT=" S E=$P(TXT,"=",2) D GRF,GETFNT Q
 G GRS:TXT[" SETUP=",OVR:TXT[" OVERLAY=",MRG:TXT[" MARGIN=",RES:TXT[" RESOLUTION=" Q:TXT'[" GRAPHIC="  S E=$TR($P(TXT,"=",2)," ","") I E?1"^"1A.E,$D(@E) S A="" F FXL=FXL:1 S A=$O(@E@(A)) Q:A=""  S @ZAA02GFAXS@(PG,FXL+1)=@E@(A)
 S:$G(@E)["HIRES" $P(@ZAA02GFAXS@(PG),",",2)="HIRES" Q
GRS X $P(TXT,"=",2,99) Q
GRF S FNT=$S(+E:+E,1:$P("40,40,30,40,20,10,50,60,70,80,90,100,110",",",$F("DABCEFGHIJK",$E(E))+1)) S:'$D(^ZAA02GFAXF(FNT)) FNT=40 Q
OVR S OVR=$P(TXT,"=",2,9) D OVR1 I OV["C" S OV=OV-FXL+1 D ^ZAA02GFAXH5 S Z=99999 Q
 S OV=OV-FXL+1,OVRF=99999 D ^ZAA02GFAXH5 S:Z="" Z=OVRF K OVR,OVRF Q
OVR1 S OMG=+$P(OVR,":",2),OV=$P(OVR,":",3,4),OVR=$P(OVR,":") Q
MRG S MG=$P(TXT,"=",2) Q
RES K HIRES S:$P(TXT,"=",2)["HI" HIRES=1 Q
 ;
CVR N EOL,MG,TRL,CVR,FNT S MG=20,CVR=536,EOL=^ZAA02GFAXC(0,2,0)_"01101110001001110",TRL="1001011100001011",FNT=$S($D(CVRP):20,1:30) D GETFNT G:$D(CVRP) CVRP
 S Y=$O(^ZAA02GFAXC(98,"")),Y=$S(Y="":1,1:^(Y)),Y=$S($D(^ZAA02GFAXC(99,0,Y,2)):^(2),1:"FROM\TO\SUBJ\Page\of")
 S CG=$P(^ZAA02GFAXC("CONFIG"),"\",3) I $E(CG)="^",$D(@CG) S PGL=PGL-$S($D(@CG)#2:@CG,1:0)
 S TXT=" " D LINE S TXT=$P(Y,"\")_":"_$J("",5-$L($P(Y,"\")))_$P(B,"\",11),E=$S($P(B,"\",12)'[":":"FAX: "_$J($P(B,"\",12),15),1:$P(B,"\",12)),TXT=TXT_$J(E,71-$L(TXT)) D LINE
 I $P(^ZAA02GFAXC("CONFIG"),"\")'="" S TXT="      "_$P(^("CONFIG"),"\") D LINE
 S TXT=" " D LINE S TXT=$P(Y,"\",2)_":"_$J("",5-$L($P(Y,"\",2)))_$P(B,"\",13),E="FAX: "_$J($P(B,"\",4),15),TXT=TXT_$J(E,71-$L(TXT)) D LINE
 I $P(B,"\",32)'="" S TXT="      "_$P(B,"\",32) D LINE
 I $P(B,"\",31)'="" S TXT=" " D LINE S TXT=$P(Y,"\",3)_": "_$P(B,"\",31) D LINE
 S TXT=" " D LINE S CVRP=FXL S TXT=" " D LINE
 S TXT=$C(0,128,118,100,224,6,106,58,52) F FXL=FXL+1:1:FXL+2 S @ZAA02GFAXS@(PG,FXL)=TXT
 S PGL=PGL-46 Q
CVRP S TXT=$J("",31)_$P(Y,"\",4)_" 1 "_$P(Y,"\",5)_" "_PG,PG=1,FXL=CVRP-4,HP=0 D LINE Q
 ;
GETFNT S FR=^ZAA02GFAXF(FNT),FC=$P(FR,"`",2),FR=+FR,HP=$S(FR>15:0,FNT>40:16,1:12) K TR,MF I $O(^ZAA02GFAXF(FNT,.2,0)) S MF=FNT\10*10 S:$D(^ZAA02GFAXF(MF,.4)) TR=^(.4) Q
 S A=$O(^ZAA02GFAXF(FNT\10*10,.3,0)),A="",TR(0)=0 F I=1:1:255 S A=$O(^(A)) Q:A=""  S TR(A)=^(A)
 S:$D(TR(1)) TR(-1)=TR(1) Q