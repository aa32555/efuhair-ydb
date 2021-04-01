ZAA02GHICCHECK(BYCREATE,DTF,DTT,HIDEDELETED) ;;2018-08-30 09:32:06
 ;^MSCG("ZAA02GHICCHECK",type,code)=execute code 1_ascii(1)_execute code 2_ascii(1)...
 ; runs execute code 1, 2, ... for charges with given code; ZAA02GHIC record available in TRREC variable
 ; Types:
 ;  PC  - Procedure
 ;  AR  - A/R Class
 ;  PS  - Place of Service
 ;^MSCG("ZAA02GHICCHECK","PC",proc code,"PCDG")=delete
 ; if delete = 0 or "" reorders diagnoses so that primary is allowed by Procedure w/ related Diagnosis field (^PCDG)
 ; if delete > 0 removes diagnoses not allowed by Procedure w/ related Diagnosis field
 ;^MSCG("ZAA02GHICCHECK","PC",proc code,"MODS",modifier,2nd proc code)
 ; adds modifier to ZAA02GHIC record with proc code if there is ZAA02GHIC record with 2nd proc code for same
 ; entity, acct, patient, provider and service date
 ; 2nd proc code may be * in which case adds modifier if any other procedure with same entity, acct, etc.
 ;
 N (BYCREATE,DTF,DTT,HIDEDELETED)
 S BYCREATE=$G(BYCREATE,1),DTF=$G(DTF),DTT=$G(DTT)
 S TMPDTF=$ZDH(DTF,8,,,,,,,"")
 S TMPDTT=$ZDH(DTT,8,,,,,,,"")
 S DIR=+$G(^MSCG("ZAA02GHICCHECK"))
 I TMPDTT<=$H,DIR<0 Q
 I TMPDTT>$H D  I DIR>=0 Q
 . S DIFF=TMPDTT-$H-1
 . S TMPDTT=TMPDTF+DIFF
 . S DTF=$$DG^IDATE(TMPDTF)
 . S DTT=$$DG^IDATE(TMPDTT)
 . Q
 K ^ZAA02GHICCHECK($J)
 S ZAA02GHIC="^ZAA02GHIC"
 F  S ZAA02GHIC=$Q(@ZAA02GHIC) Q:ZAA02GHIC=""  D
 . I $QL(ZAA02GHIC)'=5 D  Q
 .. S CTR=$O(^ZAA02GHICCHECKHIS("ERROR",""),-1)+1
 .. S ^ZAA02GHICCHECKHIS("ERROR",CTR)=ZAA02GHIC_" = "_@ZAA02GHIC
 .. Q
 . S ENT=$QS(ZAA02GHIC,1)
 . S TRREC=@ZAA02GHIC
 . S ACCT=$P(TRREC,":",3) I ACCT="" S ACCT=" "
 . S PAT=$P(TRREC,":",7) I PAT="" S PAT=" "
 . S PROV=$P(TRREC,":",13) I PROV="" S PROV=" "
 . S DOS=$P($P(TRREC,":",16),"^",1) I DOS="" S DOS=" "
 . I 'BYCREATE,(DOS<DTF) Q
 . I DTT'="",DOS>DTT Q
 . I $P(TRREC,":",76)="Y",$G(HIDEDELETED) Q
 . S INPC=$P(TRREC,":",6) I INPC="" S INPC=" "
 . S PC=""
 . I INPC'="" S PC=$P($G(^INPC(INPC)),":",1)
 . I PC="" S PC=" "
 . S AR=$P(TRREC,":",45)
 . I AR="" S AR=" "
 . S PS=$P(TRREC,":",15)
 . I PS="" S PS=" "
 . S CTR=$O(^ZAA02GHICCHECK($J,ENT,ACCT,PAT,PROV,DOS,INPC,""),-1)+1
 . I $D(^MSCG("ZAA02GHICCHECK","PC",PC)) D
 .. I $D(^PCDG(INPC)),$D(^MSCG("ZAA02GHICCHECK","PC",PC,"PCDG")) S TRREC=$$DIAGCHECK(TRREC,INPC,+$G(^MSCG("ZAA02GHICCHECK","PC",PC,"PCDG")))
 .. I $D(^MSCG("ZAA02GHICCHECK","PC",PC,"MODS")) S TRREC=$$MODS(TRREC,PC,ENT,ACCT,PAT,PROV,DOS,INPC,CTR)
 .. S TRREC=$$EXEC(ZAA02GHIC,TRREC,ENT,CTR,"PC",PC)
 .. Q
 . I $D(^MSCG("ZAA02GHICCHECK","AR",AR)) S TRREC=$$EXEC(ZAA02GHIC,TRREC,ENT,CTR,"AR",AR)
 . I $D(^MSCG("ZAA02GHICCHECK","PS",PS)) S TRREC=$$EXEC(ZAA02GHIC,TRREC,ENT,CTR,"PS",PS)
 . S TRREC=$$EXEC(ZAA02GHIC,TRREC,ENT,CTR)
 . I TRREC'="" S ^ZAA02GHICCHECK($J,ENT,ACCT,PAT,PROV,DOS,INPC,CTR)=ZAA02GHIC_$C(1)_TRREC
 . I TRREC="" D SET(ZAA02GHIC,TRREC,ENT,ACCT,PAT,PROV,DOS,PC,INPC,CTR)
 . Q
 S ENT=0 F  S ENT=$O(^ZAA02GHICCHECK($J,ENT)) Q:'ENT  D
 . S ACCT="" F  S ACCT=$O(^ZAA02GHICCHECK($J,ENT,ACCT)) Q:ACCT=""  D
 .. S PAT="" F  S PAT=$O(^ZAA02GHICCHECK($J,ENT,ACCT,PAT)) Q:PAT=""  D
 ... S PROV="" F  S PROV=$O(^ZAA02GHICCHECK($J,ENT,ACCT,PAT,PROV)) Q:PROV=""  D
 .... S DOS="" F  S DOS=$O(^ZAA02GHICCHECK($J,ENT,ACCT,PAT,PROV,DOS)) Q:DOS=""  D
 ..... S INPC="" F  S INPC=$O(^ZAA02GHICCHECK($J,ENT,ACCT,PAT,PROV,DOS,INPC)) Q:INPC=""  D
 ...... S PC=$P($G(^INPC(INPC)),":",1)
 ...... I PC="" S PC=" "
 ...... S CTR="" F  S CTR=$O(^ZAA02GHICCHECK($J,ENT,ACCT,PAT,PROV,DOS,INPC,CTR)) Q:CTR=""  D
 ....... S ZAA02GHIC=$G(^ZAA02GHICCHECK($J,ENT,ACCT,PAT,PROV,DOS,INPC,CTR))
 ....... S TRREC=$P(ZAA02GHIC,$C(1),2),ZAA02GHIC=$P(ZAA02GHIC,$C(1),1)
 ....... I TRREC'="",PC'="" D
 ........ S MD="" F  S MD=$O(^ZAA02GHICCHECK($J,ENT,ACCT,PAT,PROV,DOS,INPC,CTR,MD)) Q:MD=""  D
 ......... S TRREC=$$ADDMOD(TRREC,PC,ENT,ACCT,PAT,PROV,DOS,INPC,CTR,MD)
 ........ Q
 ....... I TRREC'=$G(@ZAA02GHIC) D SET(ZAA02GHIC,TRREC,ENT,ACCT,PAT,PROV,DOS,PC,INPC,CTR)
 . Q
 K ^ZAA02GHICCHECK($J)
 J CLEANHIS
 Q
 
DIAGCHECK(TRREC,INPC,DEL)
 N (TRREC,INPC,DEL)
 D GETDIAG(TRREC,.DG)
 S CHG=0
 F I=1:1 Q:'$D(DG(I))  I DG(I) D
 . I '$D(^PCDG(INPC,DG(I))),DEL K DG(I) S CHG=1 Q
 . I $D(^PCDG(INPC,DG(I))),'DEL S TMP=DG(I),DG(I)=DG(1),DG(1)=TMP,CHG=(I>1),I=-1
 . Q
 I 'CHG Q TRREC
 Q $$SETDIAG(TRREC,.DG)
 
MODS(TRREC,PC,ENT,ACCT,PAT,PROV,DOS,INPC,CTR)
 N (TRREC,PC,ENT,ACCT,PAT,PROV,DOS,INPC,CTR)
 I (ACCT=" ")!(PAT=" ")!(PROV=" ")!(DOS=" ") Q TRREC
 S MODS=$TR($P(TRREC,":",27),"^"," ")
 F I=1:2 S MD=$E(MODS,I,I+1) Q:MD=""  S MODS(MD)=""
 S MD="" F  S MD=$O(^MSCG("ZAA02GHICCHECK","PC",PC,"MODS",MD)) Q:MD=""  D
 . I $D(MODS(MD)) Q
 . S TRREC=$$ADDMOD(TRREC,PC,ENT,ACCT,PAT,PROV,DOS,INPC,CTR,MD)
 Q TRREC
 
ADDMOD(TRREC,PC,ENT,ACCT,PAT,PROV,DOS,INPC,CTR,MD)
 N (TRREC,PC,ENT,ACCT,PAT,PROV,DOS,INPC,CTR,MD)
 S FND=0
 I $D(^MSCG("ZAA02GHICCHECK","PC",PC,"MODS",MD,"*")) D
 . I ($O(^ZAA02GHICCHECK($J,ENT,ACCT,PAT,PROV,DOS,INPC))'="")!($O(^ZAA02GHICCHECK($J,ENT,ACCT,PAT,PROV,DOS,INPC),-1)'="") D
 .. S $P(TRREC,":",27)=$P(TRREC,":",27)_MD
 .. S FND=1
 . Q
 I FND Q TRREC
 S PC2="" F  S PC2=$O(^MSCG("ZAA02GHICCHECK","PC",PC,"MODS",MD,PC2)) Q:PC2=""  D  Q:FND
 . S INPC2=$P($G(^PCG(PC2)),":",25)
 . I INPC2="" Q
 . I $D(^ZAA02GHICCHECK($J,ENT,ACCT,PAT,PROV,DOS,INPC2)) S $P(TRREC,":",27)=$P(TRREC,":",27)_MD,FND=1
 . Q
 I 'FND S ^ZAA02GHICCHECK($J,ENT,ACCT,PAT,PROV,DOS,INPC,CTR,MD)=""
 Q TRREC
.
EXEC(ZAA02GHIC,TRREC,ENT,CTR,TYP,CD)
 N (ZAA02GHIC,TRREC,ENT,CTR,TYP,CD)
 S REC=$P(^MSCG("ZAA02GHICCHECK"),$C(1),2,$L(^MSCG("ZAA02GHICCHECK"),$C(1) ) )
 I $G(TYP)'="" S REC=$G(^MSCG("ZAA02GHICCHECK",TYP,CD))
 F I=1:1:$L(REC,$C(1)) X $P(REC,$C(1),I)
 Q TRREC
 
SET(ZAA02GHIC,TRREC,ENT,ACCT,PAT,PROV,DOS,PC,INPC,CTR)
 N HCTR S HCTR=$O(^ZAA02GHICCHECKHIS(ENT,ACCT,PAT,PROV,DOS,PC,""),-1)+1
 N DEL S DEL=(TRREC="")
 S ^ZAA02GHICCHECKHIS(ENT,ACCT,PAT,PROV,DOS,PC,HCTR,$P($H,",",1),$P($H,",",2),$QS(ZAA02GHIC,2),$QS(ZAA02GHIC,3),$QS(ZAA02GHIC,4),$QS(ZAA02GHIC,5))=$G(@ZAA02GHIC)_$C(1)_DEL
 S @ZAA02GHIC=TRREC
 I DEL K @ZAA02GHIC,^ZAA02GHICCHECK($J,ENT,ACCT,PAT,PROV,DOS,INPC,CTR)
 Q
.
GETDIAG(TRREC,DG)
 N (TRREC,DG)
 S DG(1)=$P(TRREC,":",22)
 S DG(2)=$P(TRREC,":",23)
 S DG(3)=$P($P(TRREC,":",21),"^",1)
 S DG(4)=$P($P(TRREC,":",21),"^",2)
 S NUM=5
 S LST=$P(TRREC,":",66)
 D ADDLST(.DG,.NUM,LST)
 S LST=$P(TRREC,":",42)
 D ADDLST(.DG,.NUM,LST)
 Q
 
SETDIAG(TRREC,DG)
 N (TRREC,DG)
 S IDX="" F I=1:1 S IDX=$O(DG(IDX)) Q:IDX=""  S CDG(I)=DG(IDX)
 S $P(TRREC,":",22)=$G(CDG(1))
 S $P(TRREC,":",23)=$G(CDG(2))
 S $P(TRREC,":",21)=$G(CDG(3))_"^"_$G(CDG(4))
 S (FLD9,FLD10)=""
 F I=5:1 S DG=$G(CDG(I)) Q:DG=""  D
 . S DG=$P($G(^INDG(DG)),":",1)
 . I DG="" Q
 . S TYP=10
 . I $P($G(^DGG(DG)),":",15)="Y" S TYP=9
 . S @("FLD"_TYP)=@("FLD"_TYP)_"^"_DG
 . Q
 S ($E(FLD9,1),$E(FLD10,1))=""
 S $P(TRREC,":",66)=FLD9
 S $P(TRREC,":",42)=FLD10
 Q TRREC
 
ADDLST(DG,NUM,LST)
 N (DG,NUM,LST)
 F I=1:1:$L(LST,"^") D
 . S DG=$P(LST,"^",I)
 . I DG="" Q
 . S DG=$P($G(^DGG(DG)),":",11)
 . I DG="" Q
 . S DG(NUM)=DG
 . S NUM=NUM+1
 Q
.
CLEANHIS
 N
 S HIS="^ZAA02GHICCHECKHIS"
 F  S HIS=$Q(@HIS) Q:HIS=""  D
 . I $QL(HIS)<8 K @HIS Q
 . S DT=$QS(HIS,8)
 . I $H-DT>366 K @HIS
 Q
 
UNDO
 s data="^ZAA02GHICCHECKHIS"
 f  s data=$q(@data) q:data=""  d
 . i $ql(data)<13 q
 . s ent=$qs(data,1)
 . s plc=$qs(data,10)
 . s prv=$qs(data,11)
 . s dt=$qs(data,12)
 . s ctr=$qs(data,13)
 . i $d(^ZAA02GHIC(ent,plc,prv,dt,ctr))!$p(@data,$c(1),2) s ^ZAA02GHIC(ent,plc,prv,dt,ctr)=$p(@data,$c(1),1)
 . i $p(@data,$c(1),1)="" k ^ZAA02GHIC(ent,plc,prv,dt,ctr)
 q
 
.