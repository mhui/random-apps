//
//  SecondViewController.h
//  TabZ
//
//  Created by Hemant Bhonsle on 6/16/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface SecondViewController : UIViewController <UITextFieldDelegate, ADBannerViewDelegate>

@property (nonatomic, retain) IBOutlet UITextField *red1;
@property (nonatomic, retain) IBOutlet UITextField *red2;
@property (nonatomic, retain) IBOutlet UITextField *red3;
@property (nonatomic, retain) IBOutlet UITextField *red4;
@property (nonatomic, retain) IBOutlet UITextField *red5;
@property (nonatomic, retain) IBOutlet UITextField *owe1;
@property (nonatomic, retain) IBOutlet UITextField *owe2;
@property (nonatomic, retain) IBOutlet UITextField *owe3;
@property (nonatomic, retain) IBOutlet UITextField *owe4;
@property (nonatomic, retain) IBOutlet UITextField *owe5;
@property (nonatomic, retain) IBOutlet UITextField *answerred;

@property (nonatomic, retain) IBOutlet ADBannerView *anAd;
















@end
