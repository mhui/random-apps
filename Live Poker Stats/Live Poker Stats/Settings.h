//
//  Settings.h
//  Live Poker Stats
//
//  Created by Hemant Bhonsle on 10/20/12.
//  Copyright (c) 2012 Hemant Bhonsle and Matthew Hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Settings : UIViewController <UIAlertViewDelegate>

@property (strong,nonatomic) UIAlertView *clearPlayers;

-(IBAction)clearAllPlayers:(id)sender;

@end
