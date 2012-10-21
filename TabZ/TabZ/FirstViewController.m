//
//  FirstViewController.m
//  TabZ
//
//  Created by Hemant Bhonsle on 6/16/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "FirstViewController.h"


@implementation FirstViewController
@synthesize answerGreen;
@synthesize green1;
@synthesize green2;
@synthesize green3;
@synthesize green4;
@synthesize green5;
@synthesize owed1;
@synthesize owed2;
@synthesize owed3;
@synthesize owed4;
@synthesize owed5;
@synthesize anAd;

NSUserDefaults *theInfo;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    green1.delegate = self;
    green2.delegate = self;
    green3.delegate = self;
    green4.delegate = self;
    green5.delegate = self;
    owed1.delegate = self;
    owed2.delegate = self;
    owed3.delegate = self;
    owed4.delegate = self;
    owed5.delegate = self;
    answerGreen.delegate = self;
    
    anAd.delegate = self;
    
    theInfo = [NSUserDefaults standardUserDefaults];
    
    green1.text = [theInfo objectForKey:@"green1"];
    green2.text = [theInfo objectForKey:@"green2"];
    green3.text = [theInfo objectForKey:@"green3"];
    green4.text = [theInfo objectForKey:@"green4"];
    green5.text = [theInfo objectForKey:@"green5"];
    
    owed1.text = [theInfo objectForKey:@"owed1"];
    owed2.text = [theInfo objectForKey:@"owed2"];
    owed3.text = [theInfo objectForKey:@"owed3"];
    owed4.text = [theInfo objectForKey:@"owed4"];
    owed5.text = [theInfo objectForKey:@"owed5"];
    
    answerGreen.text = [theInfo objectForKey:@"greenTotal"];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"%d", [theInfo boolForKey:@"noAds"]);

    green1.text = [theInfo objectForKey:@"green1"];
    green2.text = [theInfo objectForKey:@"green2"];
    green3.text = [theInfo objectForKey:@"green3"];
    green4.text = [theInfo objectForKey:@"green4"];
    green5.text = [theInfo objectForKey:@"green5"];
    
    owed1.text = [theInfo objectForKey:@"owed1"];
    owed2.text = [theInfo objectForKey:@"owed2"];
    owed3.text = [theInfo objectForKey:@"owed3"];
    owed4.text = [theInfo objectForKey:@"owed4"];
    owed5.text = [theInfo objectForKey:@"owed5"];
    
    answerGreen.text = [theInfo objectForKey:@"greenTotal"];
    
    [theInfo setInteger:([theInfo integerForKey:@"inAppPurchase"] + 1) forKey:@"inAppPurchase"];
    
    if ([theInfo integerForKey:@"inAppPurchase"] % 10 == 0 && ![theInfo boolForKey:@"noAds"]) {
        UIAlertView *supportDev = [[UIAlertView alloc]initWithTitle:@"Remove Ads + Support Developer!" message:@"Please support the developer by purchasing the no-ads version for $0.99."delegate:self cancelButtonTitle:@"Maybe Later" otherButtonTitles:@"Okay", nil];
        [supportDev show];
    }
    
    if ([theInfo boolForKey:@"noAds"]) {
        self.anAd.hidden = YES;
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex) {
        SKProductsRequest *request= [[SKProductsRequest alloc] 
                                     initWithProductIdentifiers: [NSSet setWithObject:
                                                                  @"support333dev"]];
        request.delegate = self;
        [request start];
    }
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    NSArray *myProduct = response.products;
    NSLog(@"%@",[[myProduct objectAtIndex:0] productIdentifier]);
    
    //Since only one product, we do not need to choose from the array. Proceed directly to payment.
    
    SKPayment *newPayment = [SKPayment paymentWithProduct:[myProduct objectAtIndex:0]];
    [[SKPaymentQueue defaultQueue] addPayment:newPayment];
    
    [request autorelease];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            default:
                break;
        }
    }
}

- (void) completeTransaction: (SKPaymentTransaction *)transaction
{
    NSLog(@"Transaction Completed");
    
    [theInfo setBool:YES forKey:@"noAds"];
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void) restoreTransaction: (SKPaymentTransaction *)transaction
{
    NSLog(@"Transaction Restored");
    
    [theInfo setBool:YES forKey:@"noAds"];
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        // Display an error here.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Purchase Unsuccessful"
                                                        message:@"Your purchase failed. Please try again."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    [theInfo setBool:NO forKey:@"noAds"];
    
    // Finally, remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if (textField == owed1) {
        [theInfo setObject:textField.text forKey:@"owed1"];
    } else if (textField == owed2) {
        [theInfo setObject:textField.text forKey:@"owed2"];
    } else if (textField == owed3) {
        [theInfo setObject:textField.text forKey:@"owed3"];
    } else if (textField == owed4) {
        [theInfo setObject:textField.text forKey:@"owed4"];
    } else if (textField == owed5) {
        [theInfo setObject:textField.text forKey:@"owed5"];
    } else if (textField == green1) {
        [theInfo setObject:textField.text forKey:@"green1"];
    } else if (textField == green2) {
        [theInfo setObject:textField.text forKey:@"green2"];
    } else if (textField == green3) {
        [theInfo setObject:textField.text forKey:@"green3"];
    } else if (textField == green4) {
        [theInfo setObject:textField.text forKey:@"green4"];
    } else if (textField == green5) {
        [theInfo setObject:textField.text forKey:@"green5"];
    }
    
    float f = [owed1.text floatValue] + [owed2.text floatValue] + [owed3.text floatValue] +
    [owed4.text floatValue] + [owed5.text floatValue];     
    NSString *string = [NSString stringWithFormat:@"%.02f", f];
    [theInfo setObject:string forKey:@"greenTotal"];
    answerGreen.text = string;
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == owed1) {
        [theInfo setObject:textField.text forKey:@"owed1"];
    } else if (textField == owed2) {
        [theInfo setObject:textField.text forKey:@"owed2"];
    } else if (textField == owed3) {
        [theInfo setObject:textField.text forKey:@"owed3"];
    } else if (textField == owed4) {
        [theInfo setObject:textField.text forKey:@"owed4"];
    } else if (textField == owed5) {
        [theInfo setObject:textField.text forKey:@"owed5"];
    } else if (textField == green1) {
        [theInfo setObject:textField.text forKey:@"green1"];
    } else if (textField == green2) {
        [theInfo setObject:textField.text forKey:@"green2"];
    } else if (textField == green3) {
        [theInfo setObject:textField.text forKey:@"green3"];
    } else if (textField == green4) {
        [theInfo setObject:textField.text forKey:@"green4"];
    } else if (textField == green5) {
        [theInfo setObject:textField.text forKey:@"green5"];
    }
    
    float f = [owed1.text floatValue] + [owed2.text floatValue] + [owed3.text floatValue] +
    [owed4.text floatValue] + [owed5.text floatValue];     
    NSString *string = [NSString stringWithFormat:@"%.02f", f];
    [theInfo setObject:string forKey:@"greenTotal"];
    answerGreen.text = string;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
  
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"did not load banner!!!");
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationCurveEaseIn animations:^{
        banner.center = CGPointMake(160, 470);
    } completion:^(BOOL finished){}];
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    NSLog(@"Did load ad banner!!!");
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationCurveEaseIn animations:^{
        banner.center = CGPointMake(160, 386);
    } completion:^(BOOL finished){}];
}

@end
