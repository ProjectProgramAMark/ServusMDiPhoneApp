//
//  TermsViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 8/12/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TermsViewController : UIViewController <UIWebViewDelegate> {
    IBOutlet UIWebView *webView;
    IBOutlet UIActivityIndicatorView *acIndicator;
}

@end
