ZAA02GFRMPOP ;PG&A,ZAA02G-FORM,2.62,GET FORM & FIELD POPUP Dialogue;18NOV94  01:03
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
SCR N (%R,X,ZAA02G,ZAA02GP) S Y="50,"_$S(%R<12:%R,1:11)_"\SYRLH\2\ Series ",Y(0)="\EX\^ZAA02GDISP\X\999" D ^ZAA02GFORMP S:X[";EX" X="" Q
 ;
SN N (%R,SCR,X,ZAA02G,ZAA02GP,name) S Y="36,"_$S(%R<12:%R,1:11)_"\SYRLH\1\ Form ",Y(0)="\EX\^ZAA02GDISP(SCR)\X;5~$P(^(X),$C(96),4);35)" D ^ZAA02GFORMP S:X[";EX" X="" Q
 ;
FD N (%R,SCR,SN,X,ZAA02G,ZAA02GP) S Y="60,"_$S(%R<12:%R,1:11)_"\YRLSH\2\ Field ",Y(0)="\EX\^ZAA02GDISP(SCR,SN)\X\@" D ^ZAA02GFORMP S:X[";EX" X="" Q
 Q