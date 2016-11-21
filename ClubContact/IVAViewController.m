//
//  IVAViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 8/1/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "IVAViewController.h"

@interface IVAViewController ()

@end

@implementation IVAViewController
@synthesize backgroundIMage;
@synthesize ivaIMage;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PatientLogin *plogin = [PatientLogin getFromUserDefault];
    AVSpeechUtterance *utterance = [AVSpeechUtterance
                                    speechUtteranceWithString:[NSString stringWithFormat:@"Hello  %@.  How  can I assist  you  today?", plogin.firstname]];
    
    AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc] init];
   // utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"];
    utterance.rate = 0.20f;
    
    [synth speakUtterance:utterance];
    self.view.backgroundColor = [UIColor clearColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewWillAppear:(BOOL)animated {
    backgroundIMage.image = ivaIMage;
}

- (IBAction)closeViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
