//
//  PokerPlayerDetails.m
//  Live Poker Stats
//
//  Created by Hemant Bhonsle on 10/22/12.
//  Copyright (c) 2012 Hemant Bhonsle and Matthew Hui. All rights reserved.
//

#import "PokerPlayerDetails.h"

@interface PokerPlayerDetails ()

@end

@implementation PokerPlayerDetails

@synthesize name = _name;
@synthesize call = _call;
@synthesize raise = _raise;
@synthesize fold = _fold;
@synthesize vpip = _vpip;
@synthesize pfr = _pfr;
@synthesize hands = _hands;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSMutableDictionary *currentPlayer = [[NSUserDefaults standardUserDefaults]objectForKey:@"currentPlayerChosen"];
    self.name.text = [currentPlayer valueForKey:@"playerName"];
    self.call.text = [[currentPlayer valueForKey:@"playerCall"]stringValue];
    self.fold.text = [[currentPlayer valueForKey:@"playerFold"]stringValue];
    self.raise.text = [[currentPlayer valueForKey:@"playerRaise"]stringValue];
    self.vpip.text = @"vpip calc";
    self.pfr.text = @"pfr calc";
    self.hands.text = @"h";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
