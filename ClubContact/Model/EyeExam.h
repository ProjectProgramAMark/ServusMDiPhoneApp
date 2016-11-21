//
//  EyeExam.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 9/4/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EyeExam : NSObject



@property (nonatomic, retain) NSString *postid;
@property (nonatomic, retain) NSString *created;
@property (nonatomic, retain) NSString *patientid;
@property (nonatomic, retain) NSString *docid;


@property (nonatomic, retain) NSString *odan_lidslashes;
@property (nonatomic, retain) NSString *odan_conjuctiva;
@property (nonatomic, retain) NSString *odan_sclera;
@property (nonatomic, retain) NSString *odan_angles;
@property (nonatomic, retain) NSString *odan_cornea;
@property (nonatomic, retain) NSString *odan_iris;
@property (nonatomic, retain) NSString *odan_ac;
@property (nonatomic, retain) NSString *odan_lens;

@property (nonatomic, retain) NSString *osan_lids;
@property (nonatomic, retain) NSString *osan_conjuctiva;
@property (nonatomic, retain) NSString *osan_sclera;
@property (nonatomic, retain) NSString *osan_angles;
@property (nonatomic, retain) NSString *osan_cornea;
@property (nonatomic, retain) NSString *osan_iris;
@property (nonatomic, retain) NSString *osan_ac;
@property (nonatomic, retain) NSString *osan_lens;

@property (nonatomic, retain) NSString *odpos_media;
@property (nonatomic, retain) NSString *odpos_cs;
@property (nonatomic, retain) NSString *odpos_shape;
@property (nonatomic, retain) NSString *odpost_rim;
@property (nonatomic, retain) NSString *odpos_vp;
@property (nonatomic, retain) NSString *odpos_postpole;
@property (nonatomic, retain) NSString *odpos_av;
@property (nonatomic, retain) NSString *odpos_alr;
@property (nonatomic, retain) NSString *odpos_macula;
@property (nonatomic, retain) NSString *odpos_periphery;

@property (nonatomic, retain) NSString *ospos_media;
@property (nonatomic, retain) NSString *ospos_cs;
@property (nonatomic, retain) NSString *ospos_shape;
@property (nonatomic, retain) NSString *ospost_rim;
@property (nonatomic, retain) NSString *ospos_vp;
@property (nonatomic, retain) NSString *ospos_postpole;
@property (nonatomic, retain) NSString *ospos_av;
@property (nonatomic, retain) NSString *ospos_alr;
@property (nonatomic, retain) NSString *ospos_macula;
@property (nonatomic, retain) NSString *ospos_periphery;

@property (nonatomic, retain) NSString *assesment;

@property (nonatomic, retain) NSString *glassrx_type;
@property (nonatomic, retain) NSString *glassrx_od;
@property (nonatomic, retain) NSString *glassrx_os;
@property (nonatomic, retain) NSString *glassrx_prism;
@property (nonatomic, retain) NSString *glassrx_add;

@property (nonatomic, retain) NSString *glassrx2_type;
@property (nonatomic, retain) NSString *glassrx2_od;
@property (nonatomic, retain) NSString *glassrx2_os;
@property (nonatomic, retain) NSString *glassrx2_prism;
@property (nonatomic, retain) NSString *glassrx2_add;

@property (nonatomic, retain) NSString *contactsrx_type;
@property (nonatomic, retain) NSString *contactsrx_od;
@property (nonatomic, retain) NSString *contactsrx_os;
@property (nonatomic, retain) NSString *contactsrx_bc;
@property (nonatomic, retain) NSString *contactsrx_diam;
@property (nonatomic, retain) NSString *contactsrx_brand;
@property (nonatomic, retain) NSString *contactsrx_wt;
@property (nonatomic, retain) NSString *contactsrx_color;
@property (nonatomic, retain) NSString *contactsrx_solution;
@property (nonatomic, retain) NSString *contactsrx_enzyme;
@property (nonatomic, retain) NSString *contactsrx_amount;
@property (nonatomic, retain) NSString *contactsrx_dispense;

@property (nonatomic, retain) NSString *adtest_topography;
@property (nonatomic, retain) NSString *adtest_cycloplegia;
@property (nonatomic, retain) NSString *adtest_tonometry;
@property (nonatomic, retain) NSString *adtest_fields;
@property (nonatomic, retain) NSString *adtest_retinal;
@property (nonatomic, retain) NSString *adtest_clcheck;
@property (nonatomic, retain) NSString *adtest_medfollow;
@property (nonatomic, retain) NSString *adtest_exam;

@property (nonatomic, retain) NSString *rec_hindex;
@property (nonatomic, retain) NSString *rec_bfcal;
@property (nonatomic, retain) NSString *rec_progressive;

@property (nonatomic, retain) NSString *additionalintructi;
@property (nonatomic, retain) NSString *corrospondence;
@property (nonatomic, retain) NSString *copychart;
@property (nonatomic, retain) NSString *od;

- (id)initWithDic:(NSDictionary *)dic;

@end
