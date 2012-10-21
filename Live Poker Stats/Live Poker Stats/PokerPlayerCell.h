//
//  PokerPlayerCell.h
//  Live Poker Stats
//
//  Created by Hemant Bhonsle on 10/21/12.
//  Copyright (c) 2012 Hemant Bhonsle and Matthew Hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PokerPlayerCell : UITableViewCell

@property(strong,nonatomic)IBOutlet UILabel *name;
@property(strong,nonatomic)IBOutlet UILabel *fold;
@property(strong,nonatomic)IBOutlet UILabel *call;
@property(strong,nonatomic)IBOutlet UILabel *raise;

@end
