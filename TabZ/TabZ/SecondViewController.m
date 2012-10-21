//
//  FirstViewController.m
//  TabZ
//
//  Created by Hemant Bhonsle on 6/16/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "SecondViewController.h"


@implementation SecondViewController
@synthesize answerred;
@synthesize red1;
@synthesize red2;
@synthesize red3;
@synthesize red4;
@synthesize red5;
@synthesize owe1;
@synthesize owe2;
@synthesize owe3;
@synthesize owe4;
@synthesize owe5;
@synthesize anAd;

NSUserDefaults *theInfo;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    red1.delegate = self;
    red2.delegate = self;
    red3.delegate = self;
    red4.delegate = self;
    red5.delegate = self;
    owe1.delegate = self;
    owe2.delegate = self;
    owe3.delegate = self;
    owe4.delegate = self;
    owe5.delegate = self;
    answerred.delegate = self;
    
    anAd.delegate = self;
    
    theInfo = [NSUserDefaults standardUserDefaults];
    
    red1.text = [theInfo objectForKey:@"red1"];
    red2.text = [theInfo objectForKey:@"red2"];
    red3.text = [theInfo objectForKey:@"red3"];
    red4.text = [theInfo objectForKey:@"red4"];
    red5.text = [theInfo objectForKey:@"red5"];
    
    owe1.text = [theInfo objectForKey:@"owe1"];
    owe2.text = [theInfo objectForKey:@"owe2"];
    owe3.text = [theInfo objectForKey:@"owe3"];
    owe4.text = [theInfo objectForKey:@"owe4"];
    owe5.text = [theInfo objectForKey:@"owe5"];
    
    answerred.text = [theInfo objectForKey:@"redTotal"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    red1.text = [theInfo objectForKey:@"red1"];
    red2.text = [theInfo objectForKey:@"red2"];
    red3.text = [theInfo objectForKey:@"red3"];
    red4.text = [theInfo objectForKey:@"red4"];
    red5.text = [theInfo objectForKey:@"red5"];
    
    owe1.text = [theInfo objectForKey:@"owe1"];
    owe2.text = [theInfo objectForKey:@"owe2"];
    owe3.text = [theInfo objectForKey:@"owe3"];
    owe4.text = [theInfo objectForKey:@"owe4"];
    owe5.text = [theInfo objectForKey:@"owe5"];
    
    answerred.text = [theInfo objectForKey:@"redTotal"];
    
    if ([theInfo boolForKey:@"noAds"]) {
        self.anAd.hidden = YES;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if (textField == owe1) {
        [theInfo setObject:textField.text forKey:@"owe1"];
    } else if (textField == owe2) {
        [theInfo setObject:textField.text forKey:@"owe2"];
    } else if (textField == owe3) {
        [theInfo setObject:textField.text forKey:@"owe3"];
    } else if (textField == owe4) {
        [theInfo setObject:textField.text forKey:@"owe4"];
    } else if (textField == owe5) {
        [theInfo setObject:textField.text forKey:@"owe5"];
    } else if (textField == red1) {
        [theInfo setObject:textField.text forKey:@"red1"];
    } else if (textField == red2) {
        [theInfo setObject:textField.text forKey:@"red2"];
    } else if (textField == red3) {
        [theInfo setObject:textField.text forKey:@"red3"];
    } else if (textField == red4) {
        [theInfo setObject:textField.text forKey:@"red4"];
    } else if (textField == red5) {
        [theInfo setObject:textField.text forKey:@"red5"];
    }
    
    float f = [owe1.text floatValue] + [owe2.text floatValue] + [owe3.text floatValue] +
    [owe4.text floatValue] + [owe5.text floatValue];     
    NSString *string = [NSString stringWithFormat:@"%.02f", f];
    [theInfo setObject:string forKey:@"redTotal"];
    answerred.text = string;
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == owe1) {
        [theInfo setObject:textField.text forKey:@"owe1"];
    } else if (textField == owe2) {
        [theInfo setObject:textField.text forKey:@"owe2"];
    } else if (textField == owe3) {
        [theInfo setObject:textField.text forKey:@"owe3"];
    } else if (textField == owe4) {
        [theInfo setObject:textField.text forKey:@"owe4"];
    } else if (textField == owe5) {
        [theInfo setObject:textField.text forKey:@"owe5"];
    } else if (textField == red1) {
        [theInfo setObject:textField.text forKey:@"red1"];
    } else if (textField == red2) {
        [theInfo setObject:textField.text forKey:@"red2"];
    } else if (textField == red3) {
        [theInfo setObject:textField.text forKey:@"red3"];
    } else if (textField == red4) {
        [theInfo setObject:textField.text forKey:@"red4"];
    } else if (textField == red5) {
        [theInfo setObject:textField.text forKey:@"red5"];
    }
    float f = [owe1.text floatValue] + [owe2.text floatValue] + [owe3.text floatValue] +
    [owe4.text floatValue] + [owe5.text floatValue];     
    NSString *string = [NSString stringWithFormat:@"%.02f", f];
    [theInfo setObject:string forKey:@"redTotal"];
    answerred.text = string;
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