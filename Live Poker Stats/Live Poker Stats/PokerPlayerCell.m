//
//  PokerPlayerCell.m
//  Live Poker Stats
//
//  Created by Hemant Bhonsle on 10/21/12.
//  Copyright (c) 2012 Hemant Bhonsle and Matthew Hui. All rights reserved.
//

#import "PokerPlayerCell.h"

@implementation PokerPlayerCell

@synthesize name = _name;
@synthesize call = _call;
@synthesize raise = _raise;
@synthesize fold = _fold;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
