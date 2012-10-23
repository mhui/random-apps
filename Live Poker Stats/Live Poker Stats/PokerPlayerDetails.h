//
//  PokerPlayerDetails.h
//  Live Poker Stats
//
//  Created by Hemant Bhonsle on 10/22/12.
//  Copyright (c) 2012 Hemant Bhonsle and Matthew Hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PokerPlayerDetails : UIViewController

@property(strong,nonatomic)IBOutlet UILabel *name;
@property(strong,nonatomic)IBOutlet UILabel *fold;
@property(strong,nonatomic)IBOutlet UILabel *call;
@property(strong,nonatomic)IBOutlet UILabel *raise;
@property(strong,nonatomic)IBOutlet UILabel *vpip;
@property(strong,nonatomic)IBOutlet UILabel *pfr;
@property(strong,nonatomic)IBOutlet UILabel *hands;

@end
