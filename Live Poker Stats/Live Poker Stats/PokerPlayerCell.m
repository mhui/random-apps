//
//  PokerPlayerCell.m
//  Live Poker Stats
//
//  Created by Hemant Bhonsle on 10/21/12.
//  Copyright (c) 2012 Hemant Bhonsle and Matthew Hui. All rights reserved.
//

#import "PokerPlayerCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation PokerPlayerCell

@synthesize name = _name;
@synthesize call = _call;
@synthesize raise = _raise;
@synthesize fold = _fold;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.name setFont:[UIFont fontWithName:@"MarkerFelt-Wide" size:16]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)willTransitionToState:(UITableViewCellStateMask)aState
{
    [super willTransitionToState:aState];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    // no indent in edit mode
    self.contentView.frame = CGRectMake(0,
                                        self.contentView.frame.origin.y,
                                        self.contentView.frame.size.width,
                                        self.contentView.frame.size.height);
    CGPoint xPoint = CGPointMake(78, 0);
    CGPoint xPointNext = CGPointMake(103, 0);
    if (self.editing )
    {
        NSLog(@"go forwards");
        self.contentView.frame = CGRectMake(0, self.contentView.frame.origin.y,self.contentView.frame.size.width + 80,self.contentView.frame.size.height);
        self.name.center = CGPointMake(xPointNext.x, self.name.center.y);
    } else {
        NSLog(@"go back");
        self.name.center = CGPointMake(xPoint.x, self.name.center.y);
    }
}



@end
