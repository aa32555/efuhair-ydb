ZAA02GSCMMS ;PG&A,ZAA02G-MTS,1.20,DATABASE EDIT;20JAN95 1:25P;;;05SEP97  13:13
 ;Copyright (C) 1995, Patterson, Gray & Associates, Inc.
 ;
T5 ;G:TRTYPE<3 NA
 S Y="User\Provider\Mammography Codes Dictionary\Technologists\Site\Referral\Quit\;UPMTSRQ;S Y S T E M   F I L E S"
 S TC=32,TR=7 D SEL^ZAA02GSCM Q:J'<NE  D @$P("USERS\PROV\^ZAA02GSCMD\TECH\SITE\REF","\",J) G T5
 ;
NA G NA^ZAA02GSCM
 ;
 Q
PROV D GETDB S A="P R O V I D E R   P A R A M E T E R S",SNL=4 G FORM
PCODE S opi=2,opi(1)="FS;ZAA02GVIEWP;OTCODE",opi(2)="FS;ESPASS;OECODE" X op Q
PCODE1 I $D(OTCODE)+$D(TCODE)=2  K:OTCODE]""&(TCODE'=OTCODE) @ZAA02GSCR@("PARAM","TCODE",OTCODE) S:TCODE]""&$D(ID) @ZAA02GSCR@("PARAM","TCODE",TCODE)=ID K OTCODE,TCODE
 I 1 Q:$D(OECODE)+$D(ECODE)'=2  K:OECODE]""&(ECODE'=OECODE) @ZAA02GSCR@("PARAM","ECODE",OECODE) S:ECODE]""&$D(ID) @ZAA02GSCR@("PARAM","ECODE",ECODE)=ID K OECODE,ECODE Q
REF S A="R E F E R R A L   P A R A M E T E R S",SNL=5 G FORM
SITE S A="S I T E   P A R A M E T E R S",SNL=7 G FORM
 S DR=-1,(D,C,R)="",E=E_"$E(^(""MR"")," F J=1:1:$L(I)+1 S F=$E(I,J) D BAT1
 S E=E_")" Q
BASIC S A="B A S I C    P A R A M E T E R S",SNL=12 G FORM
FAX S A="A U T O F A X   P A R A M E T E R S",SNL=3 D FORM I $D(@ZAA02GSCM@("PARAM","FAX")) S A=$P(^("FAX"),"\",9),$P(^ZAA02GFAXC("CONFIG"),"\",13)=$S(A="E":"LOGERR",A="A":"LOGALL",1:"NOLOG")_"^ZAA02GSCMFX"
 Q
USERS S A="ZAA02G-MTS USER'S PARAMETERS",SNL=8 K CODE G FORM
TCODE S opi="FS;PASSWORD;OCODE" X op Q
TCODE1 Q:$D(OCODE)+$D(CODE)'=2  K:OCODE]""&(CODE'=OCODE) @ZAA02GSCR@("PARAM","CODE",OCODE) S:CODE]""&$D(ID) @ZAA02GSCR@("PARAM","CODE",CODE)=ID K OCODE,CODE Q
VCODE Q:X=""  I $G(@ZAA02GSCR@("PARAM","CODE",X))=""!($G(^(X))=ID) Q
 Q
GETDB I '$D(ZAA02GSCR) S ZAA02GSCR=$S($D(^ZAA02GSCR):"^ZAA02GSCR",1:"^ZAA02GSCM")
 Q
CONFIG G CONFIG^ZAA02GSCMPW
HELP G HELP^ZAA02GSCMRD
HDFR G HDFR^ZAA02GSCMRD
COMM S A="COMMUNICATION PARAMETERS",SNL=24 G FORM
CONFIGP S A="CONFIGURATION PARAMETERS",SNL=18 G FORM
CONFDEF S X="Job#,7\Patient,13\Acc #,6\Prov,4\Refr,6\Proc1,6\Proc2,6\ Date,8,/\Time,5,:\SC,2\TR#,3\St,1\" Q
DEFAULTS K DOC D ^ZAA02GSCMPS S:$D(NEW) @ZAA02GSCM@("PARAM","REPORTS")=NEW K NEW Q
 ;
FORM K ID S %R=1,%C=20,C=43-$L(A),C=$J("",C\2)_A_$J("",C\2) W @ZAA02GP,ZAA02G("HI"),C,!!,ZAA02G("CS")
 S lc="abcdefghijklmnopqrstuvwxyz",uc="ABCDEFGHIJKLMNOPQRSTUVWXYZ",sdf=""
 S SCR="ZAA02GSCM",REFRESH="3:22",ZAA02Gform="1;;Delete" D ^ZAA02GFORM Q
DELETE D DELM Q:CC'="Y"  I SN=9,$D(OCODE) S C=OCODE K:C]"" @ZAA02GSCM@("PARAM","CODE",C)
 I SN=1 S C=TCODE K:C]"" @ZAA02GSCM@("PARAM","TCODE",C) S C=ECODE K:C]"" @ZAA02GSCM@("PARAM","ECODE",C) K:$G(ID)]"" @ZAA02GSCM@("PROV",ID)
 I $G(ID)]"" S C=$P("REF,UNIT,USER,WORK,SITE,EXAM,DIST",",",$F("  7  8  9 10 11 23 13 "," "_SN_" ")\3) I C]"" K @ZAA02GSCM@("PARAM",C,ID)
 W "...done" H 2 Q
 Q
PDEL D DELM
 Q
DELM W *13,ZAA02G("CL"),ZAA02G("LO"),"      Do you want to",ZAA02G("HI")," delete",ZAA02G("LO")," this item (",ZAA02G("HI"),"Y or N",ZAA02G("LO"),") - ",ZAA02G("HI") R CC#1 S:CC?1L CC=$C($A(CC)-32) Q
 ;
DEVICE S DV=$P(@ZAA02GSCM@("PARAM","BASIC"),"|",6+DV) I DV'="" S OFF=5 O DV::0 S:'$T DV=" DEVICE IS BUSY" Q
 Q
 ;
INC S Y="30,10\RHL\1\Types of Work - Select One\\None Defined\",Y(0)="\EX\" I $D(@ZAA02GSCM@("PARAM","WORK")) S Y(0)=Y(0)_"@ZAA02GSCM@(""PARAM"",""WORK"")\$P(@ZAA02GSCM@(""PARAM"",""WORK"",TO),$C(92))_""    ""_$P(^(TO),$C(92),2)"
 D ^ZAA02GPOP S:X[";EX" X="" I X]"",$D(@ZAA02GSCM@("PARAM","WORK",X)) S WORKT=$P(@ZAA02GSCM@("PARAM","WORK",X),"\")_"\"_$P(^(X),"\",3)
 Q
 ;