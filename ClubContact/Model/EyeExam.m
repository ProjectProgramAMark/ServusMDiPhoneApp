//
//  EyeExam.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 9/4/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "EyeExam.h"

@implementation EyeExam

- (id)initWithDic:(NSDictionary *)dic {
    
    self = [super init];
    if (self)
    {
        
        if ([dic objectForKey:@"nid"])
        {
            _postid = [dic objectForKey:@"nid"];
        }
        else
        {
            _postid = @"";
        }
        
        if ([dic objectForKey:@"created"])
        {
            _created = [dic objectForKey:@"created"];
        }
        else
        {
            _created = @"";
        }
        
        if ([dic objectForKey:@"patientid"])
        {
            _patientid = [dic objectForKey:@"patientid"];
        }
        else
        {
            _patientid = @"";
        }
        
        if ([dic objectForKey:@"docid"])
        {
            _docid = [dic objectForKey:@"docid"];
        }
        else
        {
            _docid = @"";
        }
        
        if ([dic objectForKey:@"odan_lidslashes"])
        {
            _odan_lidslashes = [dic objectForKey:@"odan_lidslashes"];
        }
        else
        {
            _odan_lidslashes = @"";
        }
        
        if ([dic objectForKey:@"odan_conjuctiva"])
        {
            _odan_conjuctiva = [dic objectForKey:@"odan_conjuctiva"];
        }
        else
        {
            _odan_conjuctiva = @"";
        }
        
        if ([dic objectForKey:@"odan_sclera"])
        {
            _odan_sclera = [dic objectForKey:@"odan_sclera"];
        }
        else
        {
            _odan_sclera = @"";
        }
        
        if ([dic objectForKey:@"odan_angles"])
        {
            _odan_angles = [dic objectForKey:@"odan_angles"];
        }
        else
        {
            _odan_angles = @"";
        }
        
        if ([dic objectForKey:@"odan_cornea"])
        {
            _odan_cornea = [dic objectForKey:@"odan_cornea"];
        }
        else
        {
            _odan_cornea = @"";
        }
        
        if ([dic objectForKey:@"odan_iris"])
        {
            _odan_iris = [dic objectForKey:@"odan_iris"];
        }
        else
        {
            _odan_iris = @"";
        }
        
        if ([dic objectForKey:@"odan_ac"])
        {
            _odan_ac = [dic objectForKey:@"odan_ac"];
        }
        else
        {
            _odan_ac = @"";
        }
        
        if ([dic objectForKey:@"odan_lens"])
        {
            _odan_lens = [dic objectForKey:@"odan_lens"];
        }
        else
        {
            _odan_lens = @"";
        }
        
        
        
        
        
        
        //OSAN
        if ([dic objectForKey:@"osan_lids"])
        {
            _osan_lids = [dic objectForKey:@"osan_lids"];
        }
        else
        {
            _osan_lids = @"";
        }
        
        if ([dic objectForKey:@"osan_conjuctiva"])
        {
            _osan_conjuctiva = [dic objectForKey:@"osan_conjuctiva"];
        }
        else
        {
            _osan_conjuctiva = @"";
        }
        
        if ([dic objectForKey:@"osan_sclera"])
        {
            _osan_sclera = [dic objectForKey:@"osan_sclera"];
        }
        else
        {
            _osan_sclera = @"";
        }
        
        if ([dic objectForKey:@"osan_angles"])
        {
            _osan_angles = [dic objectForKey:@"osan_angles"];
        }
        else
        {
            _osan_angles = @"";
        }
        
        if ([dic objectForKey:@"osan_cornea"])
        {
            _osan_cornea = [dic objectForKey:@"osan_cornea"];
        }
        else
        {
            _osan_cornea = @"";
        }
        
        if ([dic objectForKey:@"osan_ac"])
        {
            _osan_ac = [dic objectForKey:@"osan_ac"];
        }
        else
        {
            _osan_ac = @"";
        }
        
        if ([dic objectForKey:@"osan_lens"])
        {
            _osan_lens = [dic objectForKey:@"osan_lens"];
        }
        else
        {
            _osan_lens = @"";
        }
        
        
        if ([dic objectForKey:@"osan_lids"])
        {
            _osan_lids = [dic objectForKey:@"osan_lids"];
        }
        else
        {
            _osan_lids = @"";
        }
        
        
        
        
        //OD POS
        if ([dic objectForKey:@"odpos_media"])
        {
            _odpos_media= [dic objectForKey:@"odpos_media"];
        }
        else
        {
            _odpos_media = @"";
        }
        
        if ([dic objectForKey:@"odpos_cs"])
        {
            _odpos_cs = [dic objectForKey:@"odpos_cs"];
        }
        else
        {
            _odpos_cs = @"";
        }
        
        if ([dic objectForKey:@"odpos_shape"])
        {
            _odpos_shape= [dic objectForKey:@"odpos_shape"];
        }
        else
        {
            _odpos_shape = @"";
        }
        
        if ([dic objectForKey:@"odpos_rim"])
        {
            _odpost_rim = [dic objectForKey:@"odpos_rim"];
        }
        else
        {
            _odpost_rim = @"";
        }
        
        if ([dic objectForKey:@"odpos_vp"])
        {
            _odpos_vp = [dic objectForKey:@"odpos_vp"];
        }
        else
        {
            _odpos_vp = @"";
        }
        
        if ([dic objectForKey:@"odpos_postpole"])
        {
            _odpos_postpole = [dic objectForKey:@"odpos_postpole"];
        }
        else
        {
            _odpos_postpole = @"";
        }
        
        if ([dic objectForKey:@"odpos_av"])
        {
            _odpos_av= [dic objectForKey:@"odpos_av"];
        }
        else
        {
            _odpos_av = @"";
        }
        
        if ([dic objectForKey:@"odpos_alr"])
        {
            _odpos_alr = [dic objectForKey:@"odpos_alr"];
        }
        else
        {
            _odpos_alr = @"";
        }
        
        if ([dic objectForKey:@"odpos_macula"])
        {
            _odpos_macula= [dic objectForKey:@"odpos_macula"];
        }
        else
        {
            _odpos_macula = @"";
        }
        
        if ([dic objectForKey:@"odpos_periphery"])
        {
            _odpos_periphery = [dic objectForKey:@"odpos_periphery"];
        }
        else
        {
            _odpos_periphery = @"";
        }
        
        
        
        //OS POS
        if ([dic objectForKey:@"ospos_media"])
        {
            _ospos_media= [dic objectForKey:@"ospos_media"];
        }
        else
        {
            _ospos_media = @"";
        }
        
        if ([dic objectForKey:@"ospos_cd"])
        {
            _ospos_cs = [dic objectForKey:@"ospos_cd"];
        }
        else
        {
            _ospos_cs = @"";
        }
        
        if ([dic objectForKey:@"ospos_shape"])
        {
            _ospos_shape= [dic objectForKey:@"ospos_shape"];
        }
        else
        {
            _ospos_shape = @"";
        }
        
        if ([dic objectForKey:@"ospos_rim"])
        {
            _ospost_rim = [dic objectForKey:@"ospos_rim"];
        }
        else
        {
            _ospost_rim = @"";
        }
        
        if ([dic objectForKey:@"ospos_vp"])
        {
            _ospos_vp = [dic objectForKey:@"ospos_vp"];
        }
        else
        {
            _ospos_vp = @"";
        }
        
        if ([dic objectForKey:@"ospos_postpole"])
        {
            _ospos_postpole = [dic objectForKey:@"ospos_postpole"];
        }
        else
        {
            _ospos_postpole = @"";
        }
        
        if ([dic objectForKey:@"ospos_av"])
        {
            _ospos_av= [dic objectForKey:@"ospos_av"];
        }
        else
        {
            _ospos_av = @"";
        }
        
        if ([dic objectForKey:@"ospos_alr"])
        {
            _ospos_alr = [dic objectForKey:@"ospos_alr"];
        }
        else
        {
            _ospos_alr = @"";
        }
        
        if ([dic objectForKey:@"ospos_macula"])
        {
            _ospos_macula= [dic objectForKey:@"ospos_macula"];
        }
        else
        {
            _ospos_macula = @"";
        }
        
        if ([dic objectForKey:@"ospos_periphery"])
        {
            _ospos_periphery = [dic objectForKey:@"ospos_periphery"];
        }
        else
        {
            _ospos_periphery = @"";
        }
        
        
        //Assesment
        if ([dic objectForKey:@"assesment"])
        {
            _assesment = [dic objectForKey:@"assesment"];
        }
        else
        {
            _assesment = @"";
        }
        
        
        
        //Glass RX
        if ([dic objectForKey:@"glassrx_type"])
        {
            _glassrx_type = [dic objectForKey:@"glassrx_type"];
        }
        else
        {
            _glassrx_type = @"";
        }
        
        if ([dic objectForKey:@"glassrx_od"])
        {
            _glassrx_od = [dic objectForKey:@"glassrx_od"];
        }
        else
        {
            _glassrx_od = @"";
        }
        
        if ([dic objectForKey:@"glassrx_os"])
        {
            _glassrx_os = [dic objectForKey:@"glassrx_os"];
        }
        else
        {
            _glassrx_os = @"";
        }
        
        if ([dic objectForKey:@"glassrx_prism"])
        {
            _glassrx_prism = [dic objectForKey:@"glassrx_prism"];
        }
        else
        {
            _glassrx_prism = @"";
        }
        
        if ([dic objectForKey:@"glassrx_add"])
        {
            _glassrx_add = [dic objectForKey:@"glassrx_add"];
        }
        else
        {
            _glassrx_add = @"";
        }
        
        
        
        
        //Glass RX2
        if ([dic objectForKey:@"glassrx2_type"])
        {
            _glassrx2_type = [dic objectForKey:@"glassrx2_type"];
        }
        else
        {
            _glassrx2_type = @"";
        }
        
        if ([dic objectForKey:@"glassrx2_od"])
        {
            _glassrx2_od = [dic objectForKey:@"glassrx2_od"];
        }
        else
        {
            _glassrx2_od = @"";
        }
        
        if ([dic objectForKey:@"glassrx2_os"])
        {
            _glassrx2_os = [dic objectForKey:@"glassrx2_os"];
        }
        else
        {
            _glassrx2_os = @"";
        }
        
        if ([dic objectForKey:@"glassrx2_prism"])
        {
            _glassrx2_prism = [dic objectForKey:@"glassrx2_prism"];
        }
        else
        {
            _glassrx2_prism = @"";
        }
        
        if ([dic objectForKey:@"glassrx2_add"])
        {
            _glassrx2_add = [dic objectForKey:@"glassrx2_add"];
        }
        else
        {
            _glassrx2_add = @"";
        }
        
        
        
        
        
        
        
        
        
        // Contacts RX
        
        if ([dic objectForKey:@"contactsrx_type"])
        {
            _contactsrx_type = [dic objectForKey:@"contactsrx_type"];
        }
        else
        {
            _contactsrx_type = @"";
        }
        
        if ([dic objectForKey:@"contactsrx_od"])
        {
            _contactsrx_od = [dic objectForKey:@"contactsrx_od"];
        }
        else
        {
            _contactsrx_od = @"";
        }
        
        if ([dic objectForKey:@"contactsrx_os"])
        {
            _contactsrx_os = [dic objectForKey:@"contactsrx_os"];
        }
        else
        {
            _contactsrx_os = @"";
        }
        
        if ([dic objectForKey:@"contactsrx_bc"])
        {
            _contactsrx_bc = [dic objectForKey:@"contactsrx_bc"];
        }
        else
        {
            _contactsrx_bc = @"";
        }
        
        if ([dic objectForKey:@"contactsrx_diam"])
        {
            _contactsrx_diam = [dic objectForKey:@"contactsrx_diam"];
        }
        else
        {
            _contactsrx_diam = @"";
        }
        
        if ([dic objectForKey:@"contactsrx_brand"])
        {
            _contactsrx_brand = [dic objectForKey:@"contactsrx_brand"];
        }
        else
        {
            _contactsrx_brand = @"";
        }
        
        if ([dic objectForKey:@"contactsrx_wt"])
        {
            _contactsrx_wt = [dic objectForKey:@"contactsrx_wt"];
        }
        else
        {
            _contactsrx_wt = @"";
        }
        
        if ([dic objectForKey:@"contactsrx_color"])
        {
            _contactsrx_color = [dic objectForKey:@"contactsrx_color"];
        }
        else
        {
            _contactsrx_color = @"";
        }
        
        if ([dic objectForKey:@"contactsrx_solution"])
        {
            _contactsrx_solution = [dic objectForKey:@"contactsrx_solution"];
        }
        else
        {
            _contactsrx_solution = @"";
        }
        
        if ([dic objectForKey:@"contactsrx_enzyme"])
        {
            _contactsrx_enzyme = [dic objectForKey:@"contactsrx_enzyme"];
        }
        else
        {
            _contactsrx_enzyme = @"";
        }
        
        if ([dic objectForKey:@"contactsrx_amount"])
        {
            _contactsrx_amount = [dic objectForKey:@"contactsrx_amount"];
        }
        else
        {
            _contactsrx_amount = @"";
        }
        
        if ([dic objectForKey:@"contactsrx_dispense"])
        {
            _contactsrx_dispense = [dic objectForKey:@"contactsrx_dispense"];
        }
        else
        {
            _contactsrx_dispense = @"";
        }
        
        
        
        
        //Aditional Testing
        if ([dic objectForKey:@"adtest_topography"])
        {
            _adtest_topography = [dic objectForKey:@"adtest_topography"];
        }
        else
        {
            _adtest_topography = @"";
        }
        
        if ([dic objectForKey:@"adtest_cycloplegia"])
        {
            _adtest_cycloplegia = [dic objectForKey:@"adtest_cycloplegia"];
        }
        else
        {
            _adtest_cycloplegia = @"";
        }
        
        if ([dic objectForKey:@"adtest_tonometry"])
        {
            _adtest_tonometry = [dic objectForKey:@"adtest_tonometry"];
        }
        else
        {
            _adtest_tonometry = @"";
        }
        
        if ([dic objectForKey:@"adtest_fields"])
        {
            _adtest_fields = [dic objectForKey:@"adtest_fields"];
        }
        else
        {
            _adtest_fields = @"";
        }
        
        if ([dic objectForKey:@"adtest_retinal"])
        {
            _adtest_retinal = [dic objectForKey:@"adtest_retinal"];
        }
        else
        {
            _adtest_retinal = @"";
        }
        
        if ([dic objectForKey:@"adtest_clcheck"])
        {
            _adtest_clcheck = [dic objectForKey:@"adtest_clcheck"];
        }
        else
        {
            _adtest_clcheck = @"";
        }
        
        if ([dic objectForKey:@"adtest_medfollow"])
        {
            _adtest_medfollow = [dic objectForKey:@"adtest_medfollow"];
        }
        else
        {
            _adtest_medfollow = @"";
        }
        
        if ([dic objectForKey:@"adtest_exam"])
        {
            _adtest_exam = [dic objectForKey:@"adtest_exam"];
        }
        else
        {
            _adtest_exam = @"";
        }
        
        
        
        //Recommendation
        if ([dic objectForKey:@"rec_hindex"])
        {
            _rec_hindex = [dic objectForKey:@"rec_hindex"];
        }
        else
        {
            _rec_hindex = @"";
        }
        
        if ([dic objectForKey:@"rec_bfcal"])
        {
            _rec_bfcal = [dic objectForKey:@"rec_bfcal"];
        }
        else
        {
            _rec_bfcal = @"";
        }
        
        if ([dic objectForKey:@"rec_progressive"])
        {
            _rec_progressive = [dic objectForKey:@"rec_progressive"];
        }
        else
        {
            _rec_progressive = @"";
        }
        
        
        //Others
        if ([dic objectForKey:@"additionalintructi"])
        {
            _additionalintructi= [dic objectForKey:@"additionalintructi"];
        }
        else
        {
            _additionalintructi = @"";
        }
        
        if ([dic objectForKey:@"corrospondence"])
        {
            _corrospondence= [dic objectForKey:@"corrospondence"];
        }
        else
        {
            _corrospondence = @"";
        }
        
        if ([dic objectForKey:@"copychart"])
        {
            _copychart = [dic objectForKey:@"copychart"];
        }
        else
        {
            _copychart = @"";
        }
        
        if ([dic objectForKey:@"od"])
        {
            _od = [dic objectForKey:@"od"];
        }
        else
        {
            _od = @"";
        }
        
        
    }
    return self;
}

@end
