ZAA02GFAXD2 ;PG&A,ZAA02G-FAX,1.36,DEVICE DRIVER - ERROR MESSAGES;19JAN96 10:35A;;;07SEP2006  10:42
 ;Copyright (C) 1991-1994, Patterson, Gray and Associates Inc.
 ;
ERROR Q:$D(TEST)  Q:'JOB  Q:'$D(^ZAA02GFAXQ(.9,JOB))  S B=^ZAA02GFAXQ("DIR",10000-JOB),$P(B,"\",30)=$P(B,"\",30)+(14'[ER),$P(B,"\",3)=$P($T(ERRORD+ER),";",2),$P(B,"\",21)=$TR(PTS,",","")
 I 36[ER S $P(B,"\",10)=2,$P(B,"\",14)=4,$P(B,"\",24)=ER=3*300+$P($H,",",2)+120\90+($H*1000) K ^ZAA02GFAXQ(.9,JOB/1000000)
 S ^ZAA02GFAXQ("DIR",10000-JOB)=B S:$D(ERR) ^ZAA02GFAXQ("ERR",10000-JOB)=ERR Q
 ;
ERRORD ;
 ;COM-ERR;NO RESPONSE FROM MODEM 
 ;FAX-ERR;FAX/MODEM FROZE
 ;NO-ANSWR;NO FAX CONNECT
 ;NO-DIAL;DIALED BUT NO DIAL TONE
 ;XMT-ERR;TRANSMISSION ERROR
 ;BUSY;REMOTE FAX IS BUSY
 ;
TT S FAX="" D GETPORT^ZAA02GFAXC Q:FAX=""  S TEST=1,(JB,JOB)="" F K=1 S JOB=$O(^ZAA02GFAXQ("DIR",JOB)),I=10000-JOB,^ZAA02GFAXQ(.9,I)="",JB=JB_I_"," U 0 W ^(I),!
 G ^ZAA02GFAXD1