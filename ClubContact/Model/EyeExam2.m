//
//  EyeExam2.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 9/22/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "EyeExam2.h"

@implementation EyeExam2


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
        
        
        if ([dic objectForKey:@"cc_chiefcompliant"])
        {
            _cc_chiefcompliant = [dic objectForKey:@"cc_chiefcompliant"];
        }
        else
        {
            _cc_chiefcompliant  = @"";
        }
        
        if ([dic objectForKey:@"cc_examination"])
        {
            _cc_examination = [dic objectForKey:@"cc_examination"];
        }
        else
        {
            _cc_examination  = @"";
        }
        
        
        
        if ([dic objectForKey:@"cc_examtechnician"])
        {
            _cc_examtechnician = [dic objectForKey:@"cc_examtechnician"];
        }
        else
        {
            _cc_examtechnician  = @"";
        }
        
        if ([dic objectForKey:@"cc_hpioccular"])
        {
            _cc_hpioccular = [dic objectForKey:@"cc_hpioccular"];
        }
        else
        {
            _cc_hpioccular  = @"";
        }
        
        if ([dic objectForKey:@"cc_hpivision"])
        {
            _cc_hpivision = [dic objectForKey:@"cc_hpivision"];
        }
        else
        {
            _cc_hpivision  = @"";
        }
        
        
        
        if ([dic objectForKey:@"phx_allergy"])
        {
            _phx_allergy = [dic objectForKey:@"phx_allergy"];
        }
        else
        {
            _phx_allergy  = @"";
        }
        
        if ([dic objectForKey:@"phx_patienthostiry"])
        {
            _phx_patienthostiry = [dic objectForKey:@"phx_patienthostiry"];
        }
        else
        {
            _phx_patienthostiry  = @"";
        }
        
        if ([dic objectForKey:@"phx_occularmed"])
        {
            _phx_occularmed = [dic objectForKey:@"phx_occularmed"];
        }
        else
        {
            _phx_occularmed  = @"";
        }
        
        if ([dic objectForKey:@"phx_sysmed"])
        {
            _phx_sysmed = [dic objectForKey:@"phx_sysmed"];
        }
        else
        {
            _phx_sysmed  = @"";
        }
        
        if ([dic objectForKey:@"phx_sochis"])
        {
            _phx_sochis = [dic objectForKey:@"phx_sochis"];
        }
        else
        {
            _phx_sochis  = @"";
        }
        
        if ([dic objectForKey:@"phx_rewhis"])
        {
            _phx_rewhis = [dic objectForKey:@"phx_rewhis"];
        }
        else
        {
            _phx_rewhis  = @"";
        }
        
        if ([dic objectForKey:@"visrx_unadvalt"])
        {
            _visrx_unadvalt = [dic objectForKey:@"visrx_unadvalt"];
        }
        else
        {
            _visrx_unadvalt  = @"";
        }
        
        if ([dic objectForKey:@"visrx_unadvart"])
        {
            _visrx_unadvart = [dic objectForKey:@"visrx_unadvart"];
        }
        else
        {
            _visrx_unadvart  = @"";
        }
        
        if ([dic objectForKey:@"visrx_unadvabi"])
        {
            _visrx_unadvabi = [dic objectForKey:@"visrx_unadvabi"];
        }
        else
        {
            _visrx_unadvabi  = @"";
        }
        
        if ([dic objectForKey:@"visrx_unanvalt"])
        {
            _visrx_unanvalt = [dic objectForKey:@"visrx_unanvalt"];
        }
        else
        {
            _visrx_unanvalt  = @"";
        }
        
        if ([dic objectForKey:@"visrx_unanvart"])
        {
            _visrx_unanvart = [dic objectForKey:@"visrx_unanvart"];
        }
        else
        {
            _visrx_unanvart  = @"";
        }
        
        if ([dic objectForKey:@"visrx_unanvabi"])
        {
            _visrx_unanvabi = [dic objectForKey:@"visrx_unanvabi"];
        }
        else
        {
            _visrx_unanvabi  = @"";
        }
        
        if ([dic objectForKey:@"visrx_unaphlt"])
        {
            _visrx_unaphlt = [dic objectForKey:@"visrx_unaphlt"];
        }
        else
        {
            _visrx_unaphlt  = @"";
        }
        
        if ([dic objectForKey:@"visrx_unaphrt"])
        {
            _visrx_unaphrt = [dic objectForKey:@"visrx_unaphrt"];
        }
        else
        {
            _visrx_unaphrt  = @"";
        }
        
        if ([dic objectForKey:@"visrx_unaphbi"])
        {
            _visrx_unaphbi = [dic objectForKey:@"visrx_unaphbi"];
        }
        else
        {
            _visrx_unaphbi  = @"";
        }
        
        
        
        
        
        
        
        if ([dic objectForKey:@"visrx_psrsph"])
        {
            _visrx_psrsph = [dic objectForKey:@"visrx_psrsph"];
        }
        else
        {
            _visrx_psrsph  = @"";
        }
        
        if ([dic objectForKey:@"visrx_psrsphlt"])
        {
            _visrx_psrsphlt = [dic objectForKey:@"visrx_psrsphlt"];
        }
        else
        {
            _visrx_psrsphlt  = @"";
        }
        
        if ([dic objectForKey:@"visrx_psrcycle"])
        {
            _visrx_psrcycle = [dic objectForKey:@"visrx_psrcycle"];
        }
        else
        {
            _visrx_psrcycle  = @"";
        }
        
        if ([dic objectForKey:@"visrx_psrcyclelt"])
        {
            _visrx_psrcyclelt = [dic objectForKey:@"visrx_psrcyclelt"];
        }
        else
        {
            _visrx_psrcyclelt  = @"";
        }
        
        if ([dic objectForKey:@"visrx_psraxis"])
        {
            _visrx_psraxis = [dic objectForKey:@"visrx_psraxis"];
        }
        else
        {
            _visrx_psraxis  = @"";
        }
        
        if ([dic objectForKey:@"visrx_psraxislt"])
        {
            _visrx_psraxislt = [dic objectForKey:@"visrx_psraxislt"];
        }
        else
        {
            _visrx_psraxislt  = @"";
        }
        
        
        if ([dic objectForKey:@"visrx_psrcyclelt"])
        {
            _visrx_psrcyclelt = [dic objectForKey:@"visrx_psrcyclelt"];
        }
        else
        {
            _visrx_psrcyclelt  = @"";
        }
        
        if ([dic objectForKey:@"visrx_psraxis"])
        {
            _visrx_psraxis = [dic objectForKey:@"visrx_psraxis"];
        }
        else
        {
            _visrx_psraxis  = @"";
        }
        
        if ([dic objectForKey:@"visrx_psraxislt"])
        {
            _visrx_psraxislt = [dic objectForKey:@"visrx_psraxislt"];
        }
        else
        {
            _visrx_psraxislt  = @"";
        }
        
        if ([dic objectForKey:@"visrx_psrhprismlt"])
        {
            _visrx_psrhprismlt = [dic objectForKey:@"visrx_psrhprismlt"];
        }
        else
        {
            _visrx_psrhprismlt  = @"";
        }
        
        if ([dic objectForKey:@"visrx_psrhprism"])
        {
            _visrx_psrhprism = [dic objectForKey:@"visrx_psrhprism"];
        }
        else
        {
            _visrx_psrhprism  = @"";
        }
        
        if ([dic objectForKey:@"visrx_psrvprism"])
        {
            _visrx_psrvprism = [dic objectForKey:@"visrx_psrvprism"];
        }
        else
        {
            _visrx_psrvprism  = @"";
        }
        
        if ([dic objectForKey:@"visrx_psrvprismlt"])
        {
            _visrx_psrvprismlt = [dic objectForKey:@"visrx_psrvprismlt"];
        }
        else
        {
            _visrx_psrvprismlt = @"";
        }
        
        if ([dic objectForKey:@"visrx_psradd"])
        {
            _visrx_psradd = [dic objectForKey:@"visrx_psradd"];
        }
        else
        {
            _visrx_psradd  = @"";
        }
        
        if ([dic objectForKey:@"visrx_psraddlt"])
        {
            _visrx_psraddlt = [dic objectForKey:@"visrx_psraddlt"];
        }
        else
        {
            _visrx_psraddlt  = @"";
        }
        
        
        if ([dic objectForKey:@"visrx_psrdna"])
        {
            _visrx_psrdna = [dic objectForKey:@"visrx_psrdna"];
        }
        else
        {
            _visrx_psrdna = @"";
        }
        
        if ([dic objectForKey:@"visrx_psrdnalt"])
        {
            _visrx_psrdnalt = [dic objectForKey:@"visrx_psrdnalt"];
        }
        else
        {
            _visrx_psrdnalt  = @"";
        }
        
        if ([dic objectForKey:@"visrx_psrdnabi"])
        {
            _visrx_psrdnabi = [dic objectForKey:@"visrx_psrdnabi"];
        }
        else
        {
            _visrx_psrdnabi  = @"";
        }
        
        if ([dic objectForKey:@"visrx_psrnva"])
        {
            _visrx_psrnva = [dic objectForKey:@"visrx_psrnva"];
        }
        else
        {
            _visrx_psrnva = @"";
        }
        
        if ([dic objectForKey:@"visrx_psrnvalt"])
        {
            _visrx_psrnvalt = [dic objectForKey:@"visrx_psrnvalt"];
        }
        else
        {
            _visrx_psrnvalt  = @"";
        }
        
        if ([dic objectForKey:@"visrx_psrnvabi"])
        {
            _visrx_psrnvabi = [dic objectForKey:@"visrx_psrnvabi"];
        }
        else
        {
            _visrx_psrnvabi  = @"";
        }
        
        if ([dic objectForKey:@"visrx_psrphp"])
        {
            _visrx_psrphp = [dic objectForKey:@"visrx_psrphp"];
        }
        else
        {
            _visrx_psrphp = @"";
        }
        
        if ([dic objectForKey:@"visrx_psrphplt"])
        {
            _visrx_psrphplt = [dic objectForKey:@"visrx_psrphplt"];
        }
        else
        {
            _visrx_psrphplt  = @"";
        }
        
        if ([dic objectForKey:@"visrx_psrphpbi"])
        {
            _visrx_psrphpbi = [dic objectForKey:@"visrx_psrphpbi"];
        }
        else
        {
            _visrx_psrphpbi  = @"";
        }
        
        if ([dic objectForKey:@"visrx_psrprxdate"])
        {
            _visrx_psrprxdate = [dic objectForKey:@"visrx_psrprxdate"];
        }
        else
        {
            _visrx_psrprxdate  = @"";
        }
        
        
        if ([dic objectForKey:@"visrx_autorefracti"])
        {
            _visrx_autorefracti = [dic objectForKey:@"visrx_autorefracti"];
        }
        else
        {
            _visrx_autorefracti = @"";
        }
        
        if ([dic objectForKey:@"visrx_retinoscopy"])
        {
            _visrx_retinoscopy = [dic objectForKey:@"visrx_retinoscopy"];
        }
        else
        {
            _visrx_retinoscopy  = @"";
        }
        
        
        
        
        
        
        if ([dic objectForKey:@"visrx_subrxsphrt"])
        {
            _visrx_subrxsphrt = [dic objectForKey:@"visrx_subrxsphrt"];
        }
        else
        {
            _visrx_subrxsphrt  = @"";
        }
        
        if ([dic objectForKey:@"visrx_subrxsphlt"])
        {
            _visrx_subrxsphlt = [dic objectForKey:@"visrx_subrxsphlt"];
        }
        else
        {
            _visrx_subrxsphlt  = @"";
        }
        
        if ([dic objectForKey:@"visrx_subrxcycle"])
        {
            _visrx_subrxcycle= [dic objectForKey:@"visrx_subrxcycle"];
        }
        else
        {
            _visrx_subrxcycle  = @"";
        }
        
        if ([dic objectForKey:@"visrx_subrxcyclelt"])
        {
            _visrx_subrxcyclelt = [dic objectForKey:@"visrx_subrxcyclelt"];
        }
        else
        {
            _visrx_subrxcyclelt  = @"";
        }
        
        if ([dic objectForKey:@"visrx_subrxaxis"])
        {
            _visrx_subrxaxis = [dic objectForKey:@"visrx_subrxaxis"];
        }
        else
        {
            _visrx_subrxaxis  = @"";
        }
        
        if ([dic objectForKey:@"visrx_subrxaxislt"])
        {
            _visrx_subrxaxislt = [dic objectForKey:@"visrx_subrxaxislt"];
        }
        else
        {
            _visrx_subrxaxislt  = @"";
        }
        
        if ([dic objectForKey:@"visrx_subrxhprism"])
        {
            _visrx_subrxhprism = [dic objectForKey:@"visrx_subrxhprism"];
        }
        else
        {
            _visrx_subrxhprism  = @"";
        }
        
        if ([dic objectForKey:@"visrx_subrxhprisml"])
        {
            _visrx_subrxhprisml = [dic objectForKey:@"visrx_subrxhprisml"];
        }
        else
        {
            _visrx_subrxhprisml  = @"";
        }
        
        if ([dic objectForKey:@"visrx_subrxvprism"])
        {
            _visrx_subrxvprism = [dic objectForKey:@"visrx_subrxvprism"];
        }
        else
        {
            _visrx_subrxvprism  = @"";
        }
        
        if ([dic objectForKey:@"visrx_subrxvprisml"])
        {
            _visrx_subrxvprisml = [dic objectForKey:@"visrx_subrxvprisml"];
        }
        else
        {
            _visrx_subrxvprisml  = @"";
        }
        
        if ([dic objectForKey:@"visrx_subrxadd"])
        {
            _visrx_subrxadd = [dic objectForKey:@"visrx_subrxadd"];
        }
        else
        {
            _visrx_subrxadd  = @"";
        }
        
        if ([dic objectForKey:@"visrx_subrxaddlt"])
        {
            _visrx_subrxaddlt = [dic objectForKey:@"visrx_subrxaddlt"];
        }
        else
        {
            _visrx_subrxaddlt  = @"";
        }
        
        if ([dic objectForKey:@"visrx_subrxdva"])
        {
            _visrx_subrxdva = [dic objectForKey:@"visrx_subrxdva"];
        }
        else
        {
            _visrx_subrxdva  = @"";
        }
        
        if ([dic objectForKey:@"visrx_subrxdvalt"])
        {
            _visrx_subrxdvalt = [dic objectForKey:@"visrx_subrxdvalt"];
        }
        else
        {
            _visrx_subrxdvalt  = @"";
        }
        
        if ([dic objectForKey:@"visrx_subrxnva"])
        {
            _visrx_subrxnva = [dic objectForKey:@"visrx_subrxnva"];
        }
        else
        {
            _visrx_subrxnva  = @"";
        }
        
        if ([dic objectForKey:@"visrx_subrxph"])
        {
            _visrx_subrxph = [dic objectForKey:@"visrx_subrxph"];
        }
        else
        {
            _visrx_subrxph  = @"";
        }
        
        if ([dic objectForKey:@"visrx_subrxphlt"])
        {
            _visrx_subrxphlt = [dic objectForKey:@"visrx_subrxphlt"];
        }
        else
        {
            _visrx_subrxphlt  = @"";
        }
        
        
        
        
        if ([dic objectForKey:@"visrx_fspecsph"])
        {
            _visrx_fspecsph = [dic objectForKey:@"visrx_fspecsph"];
        }
        else
        {
            _visrx_fspecsph  = @"";
        }
        
        if ([dic objectForKey:@"visrx_fspecsphlt"])
        {
            _visrx_fspecsphlt = [dic objectForKey:@"visrx_fspecsphlt"];
        }
        else
        {
            _visrx_fspecsphlt  = @"";
        }
        
        
        if ([dic objectForKey:@"visrx_fspecsph"])
        {
            _visrx_fspecsph = [dic objectForKey:@"visrx_fspecsph"];
        }
        else
        {
            _visrx_fspecsph  = @"";
        }
        
        if ([dic objectForKey:@"visrx_fspeccycle"])
        {
            _visrx_fspeccycle = [dic objectForKey:@"visrx_fspeccycle"];
        }
        else
        {
            _visrx_fspeccycle  = @"";
        }
        
        if ([dic objectForKey:@"visrx_fspeccyclelt"])
        {
            _visrx_fspeccyclelt = [dic objectForKey:@"visrx_fspeccyclelt"];
        }
        else
        {
            _visrx_fspeccyclelt  = @"";
        }
        
        if ([dic objectForKey:@"visrx_fspecaxis"])
        {
            _visrx_fspecaxis = [dic objectForKey:@"visrx_fspecaxis"];
        }
        else
        {
            _visrx_fspecaxis  = @"";
        }
        
        
        if ([dic objectForKey:@"visrx_fspecaxislt"])
        {
            _visrx_fspecaxislt = [dic objectForKey:@"visrx_fspecaxislt"];
        }
        else
        {
            _visrx_fspecaxislt  = @"";
        }
        
        if ([dic objectForKey:@"visrx_fspechprism"])
        {
            _visrx_fspechprism = [dic objectForKey:@"visrx_fspechprism"];
        }
        else
        {
            _visrx_fspechprism  = @"";
        }
        
        
        
        if ([dic objectForKey:@"visrx_fspechprisml"])
        {
            _visrx_fspechprisml = [dic objectForKey:@"visrx_fspechprisml"];
        }
        else
        {
            _visrx_fspechprisml  = @"";
        }
        
        if ([dic objectForKey:@"visrx_fspecvprism"])
        {
            _visrx_fspecvprism = [dic objectForKey:@"visrx_fspecvprism"];
        }
        else
        {
            _visrx_fspecvprism  = @"";
        }
        
        
        if ([dic objectForKey:@"visrx_fspecvprisml"])
        {
            _visrx_fspecvprisml = [dic objectForKey:@"visrx_fspecvprisml"];
        }
        else
        {
            _visrx_fspecvprisml  = @"";
        }
        
        if ([dic objectForKey:@"visrx_fspecadd"])
        {
            _visrx_fspecadd = [dic objectForKey:@"visrx_fspecadd"];
        }
        else
        {
            _visrx_fspecadd  = @"";
        }
        
        
        if ([dic objectForKey:@"visrx_fspecaddlt"])
        {
            _visrx_fspecaddlt = [dic objectForKey:@"visrx_fspecaddlt"];
        }
        else
        {
            _visrx_fspecaddlt  = @"";
        }
        
        if ([dic objectForKey:@"visrx_fspecaddbi"])
        {
            _visrx_fspecaddbi = [dic objectForKey:@"visrx_fspecaddbi"];
        }
        else
        {
            _visrx_fspecaddbi  = @"";
        }
        
        
        if ([dic objectForKey:@"visrx_fspecdva"])
        {
            _visrx_fspecdva = [dic objectForKey:@"visrx_fspecdva"];
        }
        else
        {
            _visrx_fspecdva  = @"";
        }
        
        if ([dic objectForKey:@"visrx_fspecdvalt"])
        {
            _visrx_fspecdvalt = [dic objectForKey:@"visrx_fspecdvalt"];
        }
        else
        {
            _visrx_fspecdvalt  = @"";
        }
        
        
        
        
        //
        if ([dic objectForKey:@"visrx_fspecdvabi"])
        {
            _visrx_fspecdvabi = [dic objectForKey:@"visrx_fspecdvabi"];
        }
        else
        {
            _visrx_fspecdvabi  = @"";
        }
        
        if ([dic objectForKey:@"visrx_fspecnva"])
        {
            _visrx_fspecnva = [dic objectForKey:@"visrx_fspecnva"];
        }
        else
        {
            _visrx_fspecnva  = @"";
        }
        
        
        if ([dic objectForKey:@"visrx_fspecnvalt"])
        {
            _visrx_fspecnvalt = [dic objectForKey:@"visrx_fspecnvalt"];
        }
        else
        {
            _visrx_fspecnvalt  = @"";
        }
        
        if ([dic objectForKey:@"visrx_fspecnvabi"])
        {
            _visrx_fspecnvabi = [dic objectForKey:@"visrx_fspecnvabi"];
        }
        else
        {
            _visrx_fspecnvabi  = @"";
        }

        
        //
        if ([dic objectForKey:@"visrx_fspecph"])
        {
            _visrx_fspecph = [dic objectForKey:@"visrx_fspecph"];
        }
        else
        {
            _visrx_fspecph  = @"";
        }
        
        if ([dic objectForKey:@"visrx_fspecphlt"])
        {
            _visrx_fspecphlt = [dic objectForKey:@"visrx_fspecphlt"];
        }
        else
        {
            _visrx_fspecphlt  = @"";
        }
        
        
        if ([dic objectForKey:@"visrx_fspecphbi"])
        {
            _visrx_fspecphbi = [dic objectForKey:@"visrx_fspecphbi"];
        }
        else
        {
            _visrx_fspecphbi  = @"";
        }
        
        if ([dic objectForKey:@"visrx_fspecrxdate"])
        {
            _visrx_fspecrxdate = [dic objectForKey:@"visrx_fspecrxdate"];
        }
        else
        {
            _visrx_fspecrxdate   = @"";
        }
        
        if ([dic objectForKey:@"visrx_fspecexdate"])
        {
            _visrx_fspecexdate = [dic objectForKey:@"visrx_fspecexdate"];
        }
        else
        {
            _visrx_fspecexdate  = @"";
        }
        
        
        
        
        
        
        
        
        //Surgery
        if ([dic objectForKey:@"vsurgery_imprerefr"])
        {
            _vsurgery_imprerefr = [dic objectForKey:@"vsurgery_imprerefr"];
        }
        else
        {
            _vsurgery_imprerefr  = @"";
        }
        
        
        if ([dic objectForKey:@"vsurgery_impressco"])
        {
            _vsurgery_impressco = [dic objectForKey:@"vsurgery_impressco"];
        }
        else
        {
            _vsurgery_impressco  = @"";
        }
        
        if ([dic objectForKey:@"vsurgery_trx"])
        {
            _vsurgery_trx = [dic objectForKey:@"vsurgery_trx"];
        }
        else
        {
            _vsurgery_trx  = @"";
        }
        
     
        if ([dic objectForKey:@"vsurgery_tcon"])
        {
            _vsurgery_tcon = [dic objectForKey:@"vsurgery_tcon"];
        }
        else
        {
            _vsurgery_tcon  = @"";
        }
        
        if ([dic objectForKey:@"surgery_pmconsel"])
        {
            _vsurgery_pmconsel = [dic objectForKey:@"surgery_pmconsel"];
        }
        else
        {
            _vsurgery_pmconsel  = @"";
        }
        
        
        
        
        //Exam
        
        if ([dic objectForKey:@"exam_conjuctiva"])
        {
            _exam_conjuctiva = [dic objectForKey:@"exam_conjuctiva"];
        }
        else
        {
            _exam_conjuctiva  = @"";
        }
        
        if ([dic objectForKey:@"exam_crdgorxlt"])
        {
            _exam_crdgorxlt = [dic objectForKey:@"exam_crdgorxlt"];
        }
        else
        {
            _exam_crdgorxlt   = @"";
        }
        
        if ([dic objectForKey:@"exam_crdgorxrt"])
        {
            _exam_crdgorxrt = [dic objectForKey:@"exam_crdgorxrt"];
        }
        else
        {
            _exam_crdgorxrt  = @"";
        }
        
        
        if ([dic objectForKey:@"exam_crdverlt"])
        {
            _exam_crdverlt = [dic objectForKey:@"exam_crdverlt"];
        }
        else
        {
            _exam_crdverlt  = @"";
        }
        
        if ([dic objectForKey:@"exam_crdverrt"])
        {
            _exam_crdverrt = [dic objectForKey:@"exam_crdverrt"];
        }
        else
        {
            _exam_crdverrt   = @"";
        }
        
        if ([dic objectForKey:@"exam_exexam"])
        {
            _exam_exexam = [dic objectForKey:@"exam_exexam"];
        }
        else
        {
            _exam_exexam  = @"";
        }
        
        
        if ([dic objectForKey:@"exam_technician"])
        {
            _exam_technician = [dic objectForKey:@"exam_technician"];
        }
        else
        {
            _exam_technician   = @"";
        }
        
        if ([dic objectForKey:@"exam_slitexam"])
        {
            _exam_slitexam = [dic objectForKey:@"exam_slitexam"];
        }
        else
        {
            _exam_slitexam  = @"";
        }
        
        
        if ([dic objectForKey:@"surgeryhistory"])
        {
            _surgeryhistory = [dic objectForKey:@"surgeryhistory"];
        }
        else
        {
            _surgeryhistory  = @"";
        }
        
        if ([dic objectForKey:@"medicationhistory"])
        {
            _medicationhistory = [dic objectForKey:@"medicationhistory"];
        }
        else
        {
            _medicationhistory  = @"";
        }
        
        if ([dic objectForKey:@"occularhostory"])
        {
            _occularhostory = [dic objectForKey:@"occularhostory"];
        }
        else
        {
            _occularhostory  = @"";
        }

        if ([dic objectForKey:@"occularmedication"])
        {
            _occularmedication = [dic objectForKey:@"occularmedication"];
        }
        else
        {
            _occularmedication  = @"";
        }
        
        if ([dic objectForKey:@"formimage1"])
        {
            _formimage1 = [dic objectForKey:@"formimage1"];
        }
        else
        {
            _formimage1  = @"";
        }
        
        if ([dic objectForKey:@"formimage2"])
        {
            _formimage2 = [dic objectForKey:@"formimage2"];
        }
        else
        {
            _formimage2  = @"";
        }
        
        if ([dic objectForKey:@"formimage3"])
        {
            _formimage3 = [dic objectForKey:@"formimage3"];
        }
        else
        {
            _formimage3  = @"";
        }
        
        
        if ([dic objectForKey:@"seondarycomplain"])
        {
            _seondarycomplain = [dic objectForKey:@"seondarycomplain"];
        }
        else
        {
            _seondarycomplain  = @"";
        }
        
        if ([dic objectForKey:@"medicalsurgery"])
        {
            _medicalsurgery = [dic objectForKey:@"medicalsurgery"];
        }
        else
        {
            _medicalsurgery  = @"";
        }
        
        
        if ([dic objectForKey:@"occularsurgery"])
        {
            _occularsurgery = [dic objectForKey:@"occularsurgery"];
        }
        else
        {
            _occularsurgery  = @"";
        }
        
        if ([dic objectForKey:@"examlidslashes"])
        {
            _examlidslashes = [dic objectForKey:@"examlidslashes"];
        }
        else
        {
            _examlidslashes  = @"";
        }
        
        if ([dic objectForKey:@"examcornea"])
        {
            _examcornea = [dic objectForKey:@"examcornea"];
        }
        else
        {
            _examcornea  = @"";
        }
        
        if ([dic objectForKey:@"examlens"])
        {
            _examlens = [dic objectForKey:@"examlens"];
        }
        else
        {
            _examlens  = @"";
        }
        
        
        if ([dic objectForKey:@"examac"])
        {
            _examac = [dic objectForKey:@"examac"];
        }
        else
        {
            _examac  = @"";
        }
        
        if ([dic objectForKey:@"examiris"])
        {
            _examiris = [dic objectForKey:@"examiris"];
        }
        else
        {
            _examiris  = @"";
        }
        
        if ([dic objectForKey:@"exmpupil"])
        {
            _exmpupil = [dic objectForKey:@"exmpupil"];
        }
        else
        {
            _exmpupil  = @"";
        }
        
        if ([dic objectForKey:@"assesfreetext"])
        {
            _assesfreetext = [dic objectForKey:@"assesfreetext"];
        }
        else
        {
            _assesfreetext  = @"";
        }
        
        if ([dic objectForKey:@"examiopod"])
        {
            _examiopod = [dic objectForKey:@"examiopod"];
        }
        else
        {
            _examiopod  = @"";
        }
        
        if ([dic objectForKey:@"examiopos"])
        {
            _examiopos = [dic objectForKey:@"examiopos"];
        }
        else
        {
            _examiopos  = @"";
        }
        
        if ([dic objectForKey:@"exampachod"])
        {
            _exampachod = [dic objectForKey:@"exampachod"];
        }
        else
        {
            _exampachod  = @"";
        }
        
        if ([dic objectForKey:@"exampachos"])
        {
            _exampachos = [dic objectForKey:@"exampachos"];
        }
        else
        {
            _exampachos  = @"";
        }
        
        if ([dic objectForKey:@"concentrationlt"])
        {
            _concentrationlt = [dic objectForKey:@"concentrationlt"];
        }
        else
        {
            _concentrationlt  = @"";
        }
        
        if ([dic objectForKey:@"concentrationrt"])
        {
            _concentrationrt = [dic objectForKey:@"concentrationrt"];
        }
        else
        {
            _concentrationrt  = @"";
        }
        
        if ([dic objectForKey:@"amslergridrt"])
        {
            _amslergridrt = [dic objectForKey:@"amslergridrt"];
        }
        else
        {
            _amslergridrt  = @"";
        }
        
        if ([dic objectForKey:@"amslergridlt"])
        {
            _amslergridlt = [dic objectForKey:@"amslergridlt"];
        }
        else
        {
            _amslergridlt  = @"";
        }
        
        
        
        
        if ([dic objectForKey:@"assesmentslit"])
        {
            _assesmentslit = [dic objectForKey:@"assesmentslit"];
        }
        else
        {
            _assesmentslit  = @"";
        }
        
        if ([dic objectForKey:@"assesmentvisiorrx"])
        {
            _assesmentvisiorrx = [dic objectForKey:@"assesmentvisiorrx"];
        }
        else
        {
            _assesmentvisiorrx  = @"";
        }
        
        if ([dic objectForKey:@"assesmentretina"])
        {
            _assesmentretina = [dic objectForKey:@"assesmentretina"];
        }
        else
        {
            _assesmentretina  = @"";
        }
        
        if ([dic objectForKey:@"planslit"])
        {
            _planslit = [dic objectForKey:@"planslit"];
        }
        else
        {
            _planslit  = @"";
        }
        
        
        if ([dic objectForKey:@"planvisionrrx"])
        {
            _planvisionrrx = [dic objectForKey:@"planvisionrrx"];
        }
        else
        {
            _planvisionrrx  = @"";
        }
        
        if ([dic objectForKey:@"planretina"])
        {
            _planretina = [dic objectForKey:@"planretina"];
        }
        else
        {
            _planretina  = @"";
        }
        
        
    }
    
    
        return self;
    
}

@end
