//
//  Settings.m
//  Live Poker Stats
//
//  Created by Hemant Bhonsle on 10/20/12.
//  Copyright (c) 2012 Hemant Bhonsle and Matthew Hui. All rights reserved.
//

#import "Settings.h"

@interface Settings ()

@end

@implementation Settings

@synthesize clearPlayers = _clearPlayers;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clearAllPlayers:(id)sender
{
    self.clearPlayers = [[UIAlertView alloc]initWithTitle:@"Are You Sure?" message:@"This will permanently clear all the players and data you have created." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Clear All Players", nil];
    [self.clearPlayers show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex) {
        NSMutableArray *arrayPlayers = [[[NSUserDefaults standardUserDefaults]objectForKey:@"listPlayers"]mutableCopy];
        [arrayPlayers removeAllObjects];
        [[NSUserDefaults standardUserDefaults]setObject:arrayPlayers forKey:@"listPlayers"];
    }
}

@end
