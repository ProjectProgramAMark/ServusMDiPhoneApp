//
//  RegisterComInforViewController.h
//  ClubContact
//
//  Created by Duong Nguyen on 2/27/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Chameleon.h"
#import "CountryPicker.h"
#import "AFViewShaker.h"
#import "RegisterTableViewCell.h"
#import "SubscriptionPlanViewController.h"
#import "SpecialitySelectorViewController.h"
#import "RegOther2ViewController.h"
@interface RegisterComInforViewController : BaseViewController <CountryPickerDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, SubscriptionPlanViewController> {
    CountryPicker *countryPicker;
    IBOutlet UIButton *backButton;
    IBOutlet UIButton *doneButton;
    
    IBOutlet UIScrollView *iphoneBackScroll;
    IBOutlet UIView *textEnterView;
    
    IBOutlet UILabel *poweredLabel;
    IBOutlet UIImageView *fidemLogoIMG;
    
     IBOutlet UITableView *dataTableView;
}

@property (nonatomic, retain) Account *account;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UITextField *comNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *comAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *comCityTextField;
@property (weak, nonatomic) IBOutlet UITextField *comStateTextField;
@property (weak, nonatomic) IBOutlet UITextField *comZipCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *comPhoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *countryText;
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray * allTextFields;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray * allButtons;
@property (nonatomic, strong) AFViewShaker * viewShaker;


@end
