ZAA02GSCRDV ;PG&A,ZAA02G-SCRIPT,2.10,DEVICE SELECTION;20JAN95 1:25P;;;13MAY96  22:46
 ;Copyright (C) 1996, Patterson, Gray & Associates, Inc.
 ;
GETPRNT D GETREF S %R=24,%C=1 W @ZAA02GP,ZAA02G("CL") S %C=30,X="" W @ZAA02GP,"Select Printer - " S %C=47 X ^ZAA02GREAD I X]"",'$D(@DVRF@(X)) W "  NOT VALID PRINTER" H 2 G GETPRNT
 S DV=X S:DV=0 DV="" Q
 ;
SELECT D GETY K X S Y="33,10\HLDV\2\Select Printer\\",X=""
 S Y(0)="\EX" D ^ZAA02GPOP S:X[";EX" X="" S DV=X Q
 ;
GETY D GETREF K Y S Y="" F J=4:1 S Y=$O(@DVRF@(Y)) Q:Y=""  S Y(J)=Y
 Q
 ;
GETREF S DVRF="^ZAA02GWP(96)" Q