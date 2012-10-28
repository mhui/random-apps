//
//  SDSubCell.m
//  SDNestedTablesExample
//
//  Created by Daniele De Matteis on 21/05/2012.
//  Copyright (c) 2012 Daniele De Matteis. All rights reserved.
//

#import "SDSubCell.h"

@implementation SDSubCell

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super initWithCoder:aDecoder]))
    {
        offCheckBox = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"blueLedSmallOff"]];
        onCheckBox = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"blueLedSmall"]];
    }
    return self;
}

- (void) setupInterface
{
    [super setupInterface];
}

- (void) tapTransition
{
    [super tapTransition];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // no indent in edit mode
    self.contentView.frame = CGRectMake(0,
                                        self.contentView.frame.origin.y,
                                        self.contentView.frame.size.width,
                                        self.contentView.frame.size.height);
    self.valueLabel.center = CGPointMake(self.valueLabel.center.x, self.valueLabel.center.y);
    self.notifImageView.center = CGPointMake(self.notifImageView.center.x, self.notifImageView.center.y);
}

-(IBAction)editCell:(id)sender
{
    NSLog(@"edit the person cell");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"editPerson" object:nil];
}

@end
