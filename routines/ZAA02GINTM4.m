ZAA02GINTM4 ;PG&A,ZAA02G-CONFIG,2.25,CRT DEFINITION  (MSMPC COLOR-WS);2MAY94 3:22P;;;28APR97  01:15 [ 09/20/97  10:12 AM ]
 ;Copyright (C) 1987, Patterson, Gray and Assoc., Inc.
BEG S OS=$S($D(^ZAA02G("OS")):^("OS"),1:"") Q:OS=""  S A=$T(DATA),T=$P(A,";",2) W !?5,$P(A,";",3),?50,"Initialize? (Y or N) " R A#5 S A=$E(A) Q:A=""!("Yy"'[A)  W !,?8,"Initializing ",T S M=0,^ZAA02G(0,T,M)="",H=""
 F I=1:1 S A=$T(DATA+I) Q:A=""  S C=$P(A,";",2,99) F J=1:2:$L(C,"\")-1 S D=$P(C,"\",J),E=$P(C,"\",J+1),X="X="_E,@X,^ZAA02G(0,T,D)=X W "." S Y=",ZAA02G("""_D_""")="_E S:$L(H)+$L(Y)>240 ^(M)="S "_$E(H,2,255),M=M+1,H="" S H=H_Y
 S:H'="" ^(M)="S "_$E(H,2,255),^("fon")=$C(27,80,59,124,47),^("fof")=$C(27,47,254)
 S ^("fost")="S X=$C(P4>58*1+P4+33,P1>58*1+P1+33,P2>58*1+P2+33)",^("foft")="S P4=$A(JJ)>92*-1+$A(JJ)-33,P1=$A(JJ,2)>92*-1+$A(JJ,2)-33,P2=$A(JJ,3)>92*-1+$A(JJ,3)-33,P3=0"
FNC S ^ZAA02G(.1,T,1)="W *27,""[61""""p"" X:1 ^ZAA02G(""8BIT"")",^(7)="\\$C(27,91)_""4h""\$C(27,91)_""4l"""
 S ^(2)="27,81`27,73`27,119`27,88`27,36`27,34`27,86`27,38`27,148`27,32`27,84`27,35`27,37`27,89`27,117"
 S ^(3)="```````````````27,33`27,40`27,92`27,41`23`27,39`27,71```27,79`1`27,39`27,91"
 S ^(5)="PG DN`PG UP`CTRL HOME`F5`SHIFT F5`F3`SHIFT F3`F7`SHIFT TAB`F1`SHIFT F1`F4`F6`SHIFT F6`END",^(6)="```````````````F2`F9`SHIFT F9`F10`CTRL W`F8`HOME`INS`DEL`CTRL E`CTRL A`F8`SHIFT F8"
CLNUP D @(OS_"^ZAA02GINTRM") Q
 ;
DATA ;MSMPC COLOR - WS;MSM PC COLOR Monitor
 ;BO\$C(27,91,53,109)\BF\$C(27,91,109)\BI\$C(193)\BLC\$C(192)\BRC\$C(217)\C\"80"\CL\$C(27,91,75)\CS\$C(27,91,74)\D\$C(27,91,66)\DL\$C(27,91,80)\F\$C(27,91,50,74,27,91,72)\G0\""\G1\""\IL\"$C(27,91,76)"\DT\"$C(27,91,77)"
 ;H\$C(27,91,72)\HI\$C(27,91,49,109)\HL\$C(196)\IN\$C(27,91,64)\L\$C(27,91,68)\LI\$C(195)\LO\$C(27,91,50,109)\P\"$C(27,91)_%R_"";""_%C_""H"""\
 ;R\"24"\RI\$C(180)\ROF\$C(27,91,52,52,109)\RON\$C(27,91,52,49,109)\RT\$C(27,91,67)\SET\$C(27,91,52,52,109,27,80,49,59,49,124,57,57,47,65,50,27,47)\TI\$C(194)\TLC\$C(218)\TRC\$C(191)\
 ;U\$C(27,91,65)\UF\$C(27,91,51,55,109)\UO\$C(27,91,51,53,109)\V\$C(49)\VL\$C(179)\X\$C(197)\Z\$C(27,91,48,59,49,59,52,52,59,54,59,51,55,109)\SR\"$C(27,91)_%R_"";""_%C_""r"""\CSR\"$C(27,91,49,59,50,53,114)"
 ;UK\$C(27,17)\DK\$C(27,18)\RK\$C(27,19)\LK\$C(27,20)\INK\$C(27,82)\DLK\$C(27,126)