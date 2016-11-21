//
//  EyeExam2.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 9/22/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EyeExam2 : NSObject

@property (nonatomic, retain) NSString *postid;
@property (nonatomic, retain) NSString *created;
@property (nonatomic, retain) NSString *patientid;
@property (nonatomic, retain) NSString *docid;

@property (nonatomic, retain) NSString *cc_examination;
@property (nonatomic, retain) NSString *cc_examtechnician;
@property (nonatomic, retain) NSString *cc_chiefcompliant;
@property (nonatomic, retain) NSString *cc_hpivision;
@property (nonatomic, retain) NSString *cc_hpioccular;

@property (nonatomic, retain) NSString *phx_patienthostiry;
@property (nonatomic, retain) NSString *phx_occularmed;
@property (nonatomic, retain) NSString *phx_sysmed;
@property (nonatomic, retain) NSString *phx_sochis;
@property (nonatomic, retain) NSString *phx_rewhis;
@property (nonatomic, retain) NSString *phx_allergy;

@property (nonatomic, retain) NSString *visrx_unadvalt;
@property (nonatomic, retain) NSString *visrx_unadvart;
@property (nonatomic, retain) NSString *visrx_unadvabi;
@property (nonatomic, retain) NSString *visrx_unanvalt;
@property (nonatomic, retain) NSString *visrx_unanvart;
@property (nonatomic, retain) NSString *visrx_unanvabi;
@property (nonatomic, retain) NSString *visrx_unaphlt;
@property (nonatomic, retain) NSString *visrx_unaphrt;
@property (nonatomic, retain) NSString *visrx_unaphbi;

@property (nonatomic, retain) NSString *visrx_psrsph;
@property (nonatomic, retain) NSString *visrx_psrsphlt;
@property (nonatomic, retain) NSString *visrx_psrcycle;
@property (nonatomic, retain) NSString *visrx_psrcyclelt;
@property (nonatomic, retain) NSString *visrx_psraxis;
@property (nonatomic, retain) NSString *visrx_psraxislt;
@property (nonatomic, retain) NSString *visrx_psrhprism;
@property (nonatomic, retain) NSString *visrx_psrvprism;
@property (nonatomic, retain) NSString *visrx_psrhprismlt;
@property (nonatomic, retain) NSString *visrx_psrvprismlt;
@property (nonatomic, retain) NSString *visrx_psradd;
@property (nonatomic, retain) NSString *visrx_psraddlt;
@property (nonatomic, retain) NSString *visrx_psrdna;
@property (nonatomic, retain) NSString *visrx_psrdnalt;
@property (nonatomic, retain) NSString *visrx_psrdnabi;
@property (nonatomic, retain) NSString *visrx_psrnva;
@property (nonatomic, retain) NSString *visrx_psrnvalt;
@property (nonatomic, retain) NSString *visrx_psrnvabi;
@property (nonatomic, retain) NSString *visrx_psrphp;
@property (nonatomic, retain) NSString *visrx_psrphplt;
@property (nonatomic, retain) NSString *visrx_psrphpbi;
@property (nonatomic, retain) NSString *visrx_psrprxdate;

@property (nonatomic, retain) NSString *visrx_autorefracti;
@property (nonatomic, retain) NSString *visrx_retinoscopy;


@property (nonatomic, retain) NSString *visrx_subrxsphlt;
@property (nonatomic, retain) NSString *visrx_subrxsphrt;
@property (nonatomic, retain) NSString *visrx_subrxcycle;
@property (nonatomic, retain) NSString *visrx_subrxcyclelt;
@property (nonatomic, retain) NSString *visrx_subrxaxis;
@property (nonatomic, retain) NSString *visrx_subrxaxislt;
@property (nonatomic, retain) NSString *visrx_subrxhprism;
@property (nonatomic, retain) NSString *visrx_subrxhprisml;
@property (nonatomic, retain) NSString *visrx_subrxvprism;
@property (nonatomic, retain) NSString *visrx_subrxvprisml;

@property (nonatomic, retain) NSString *visrx_subrxadd;
@property (nonatomic, retain) NSString *visrx_subrxaddlt;
@property (nonatomic, retain) NSString *visrx_subrxdva;
@property (nonatomic, retain) NSString *visrx_subrxdvalt;
@property (nonatomic, retain) NSString *visrx_subrxnva;
@property (nonatomic, retain) NSString *visrx_subrxnvalt;
@property (nonatomic, retain) NSString *visrx_subrxph;
@property (nonatomic, retain) NSString *visrx_subrxphlt;


@property (nonatomic, retain) NSString *visrx_fspecsph;
@property (nonatomic, retain) NSString *visrx_fspecsphlt;
@property (nonatomic, retain) NSString *visrx_fspeccycle;
@property (nonatomic, retain) NSString *visrx_fspeccyclelt;
@property (nonatomic, retain) NSString *visrx_fspecaxis;
@property (nonatomic, retain) NSString *visrx_fspecaxislt;
@property (nonatomic, retain) NSString *visrx_fspechprism;
@property (nonatomic, retain) NSString *visrx_fspechprisml;
@property (nonatomic, retain) NSString *visrx_fspecvprisml;
@property (nonatomic, retain) NSString *visrx_fspecvprism;
@property (nonatomic, retain) NSString *visrx_fspecadd;
@property (nonatomic, retain) NSString *visrx_fspecaddlt;
@property (nonatomic, retain) NSString *visrx_fspecaddbi;
@property (nonatomic, retain) NSString *visrx_fspecdva;
@property (nonatomic, retain) NSString *visrx_fspecdvalt;
@property (nonatomic, retain) NSString *visrx_fspecdvabi;
@property (nonatomic, retain) NSString *visrx_fspecnva;
@property (nonatomic, retain) NSString *visrx_fspecnvalt;
@property (nonatomic, retain) NSString *visrx_fspecnvabi;
@property (nonatomic, retain) NSString *visrx_fspecph;
@property (nonatomic, retain) NSString *visrx_fspecphlt;
@property (nonatomic, retain) NSString *visrx_fspecphbi;
@property (nonatomic, retain) NSString *visrx_fspecrxdate;
@property (nonatomic, retain) NSString *visrx_fspecexdate;


@property (nonatomic, retain) NSString *vsurgery_impressco;
@property (nonatomic, retain) NSString *vsurgery_imprerefr;
@property (nonatomic, retain) NSString *vsurgery_trx;
@property (nonatomic, retain) NSString *vsurgery_tcon;
@property (nonatomic, retain) NSString *vsurgery_pmconsel;


@property (nonatomic, retain) NSString *exam_crdgorxrt;
@property (nonatomic, retain) NSString *exam_crdgorxlt;
@property (nonatomic, retain) NSString *exam_crdverrt;
@property (nonatomic, retain) NSString *exam_crdverlt;
@property (nonatomic, retain) NSString *exam_exexam;
@property (nonatomic, retain) NSString *exam_technician;
@property (nonatomic, retain) NSString *exam_slitexam;
@property (nonatomic, retain) NSString *exam_conjuctiva;



@property (nonatomic, retain) NSString *surgeryhistory;
@property (nonatomic, retain) NSString *medicationhistory;
@property (nonatomic, retain) NSString *occularhostory;
@property (nonatomic, retain) NSString *occularmedication;
@property (nonatomic, retain) NSString *formimage1;
@property (nonatomic, retain) NSString *formimage2;
@property (nonatomic, retain) NSString *formimage3;


@property (nonatomic, retain) NSString *seondarycomplain;
@property (nonatomic, retain) NSString *medicalsurgery;
@property (nonatomic, retain) NSString *occularsurgery;
@property (nonatomic, retain) NSString *examlidslashes;
@property (nonatomic, retain) NSString *examcornea;
@property (nonatomic, retain) NSString *examlens;
@property (nonatomic, retain) NSString *examac;
@property (nonatomic, retain) NSString *examiris;
@property (nonatomic, retain) NSString *exmpupil;
@property (nonatomic, retain) NSString *assesfreetext;
@property (nonatomic, retain) NSString *examiopod;
@property (nonatomic, retain) NSString *examiopos;
@property (nonatomic, retain) NSString *exampachod;
@property (nonatomic, retain) NSString *exampachos;
@property (nonatomic, retain) NSString *concentrationrt;
@property (nonatomic, retain) NSString *concentrationlt;
@property (nonatomic, retain) NSString *amslergridrt;
@property (nonatomic, retain) NSString *amslergridlt;

@property (nonatomic, retain) NSString *assesmentslit;
@property (nonatomic, retain) NSString *assesmentvisiorrx;
@property (nonatomic, retain) NSString *assesmentretina;
@property (nonatomic, retain) NSString *planslit;
@property (nonatomic, retain) NSString *planvisionrrx;
@property (nonatomic, retain) NSString *planretina;


- (id)initWithDic:(NSDictionary *)dic;

@end
