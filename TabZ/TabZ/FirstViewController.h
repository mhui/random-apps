//
//  FirstViewController.h
//  TabZ
//
//  Created by Hemant Bhonsle on 6/16/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <StoreKit/StoreKit.h>

@interface FirstViewController : UIViewController <UITextFieldDelegate, ADBannerViewDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver, UIAlertViewDelegate> 

@property (nonatomic, retain) IBOutlet UITextField *green1;
@property (nonatomic, retain) IBOutlet UITextField *green2;
@property (nonatomic, retain) IBOutlet UITextField *green3;
@property (nonatomic, retain) IBOutlet UITextField *green4;
@property (nonatomic, retain) IBOutlet UITextField *green5;
@property (nonatomic, retain) IBOutlet UITextField *owed1;
@property (nonatomic, retain) IBOutlet UITextField *owed2;
@property (nonatomic, retain) IBOutlet UITextField *owed3;
@property (nonatomic, retain) IBOutlet UITextField *owed4;
@property (nonatomic, retain) IBOutlet UITextField *owed5;
@property (nonatomic, retain) IBOutlet UITextField *answerGreen;

@property (nonatomic, retain) IBOutlet ADBannerView *anAd;

- (void) completeTransaction: (SKPaymentTransaction *)transaction;
- (void) restoreTransaction: (SKPaymentTransaction *)transaction;
- (void) failedTransaction: (SKPaymentTransaction *)transaction;

@end
