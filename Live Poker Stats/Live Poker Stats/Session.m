//
//  Session.m
//  Live Poker Stats
//
//  Created by Hemant Bhonsle on 10/20/12.
//  Copyright (c) 2012 Hemant Bhonsle and Matthew Hui. All rights reserved.
//

#import "Session.h"
#import "PokerPlayerCell.h"
#import <QuartzCore/QuartzCore.h>

@interface Session ()

@end

@implementation Session

@synthesize chooseTableType = _chooseTableType;
@synthesize listPlayers = _listPlayers;
@synthesize tablePlayers = _tablePlayers;
@synthesize playerOptions = _playerOptions;
@synthesize numDefaultPlayers = _numDefaultPlayers;
@synthesize currentPlayer = _currentPlayer;
@synthesize cellChosen = _cellChosen;

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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.chooseTableType = [[UIAlertView alloc]initWithTitle:@"Create New Game" message:@"Would you like to create a new game with created players or defaults values?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Created Players",@"Default Values", nil];
    self.chooseTableType.tag = 101;
    [self.chooseTableType show];
}

#pragma mark - UIAlertView delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 101) {
        if (buttonIndex == 0) {
            self.listPlayers = [[[NSUserDefaults standardUserDefaults]objectForKey:@"listPlayers"]mutableCopy];
            [self.tablePlayers reloadData];
        } else {
            UIAlertView *chooseNumDefaults = [[UIAlertView alloc]initWithTitle:@"    " message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Create Session",nil];
            chooseNumDefaults.tag = 99;
            self.numDefaultPlayers = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 15.0, 245.0, 25.0)];
            self.numDefaultPlayers.delegate=self;
            [self.numDefaultPlayers setBackgroundColor:[UIColor whiteColor]];
            [self.numDefaultPlayers setKeyboardType:UIKeyboardTypeNumberPad];
            self.numDefaultPlayers.borderStyle = UITextBorderStyleRoundedRect;
            self.numDefaultPlayers.placeholder=@"Number of Default Players";
            self.numDefaultPlayers.secureTextEntry=NO;
            [chooseNumDefaults addSubview:self.numDefaultPlayers];
            [chooseNumDefaults show];
            [self.numDefaultPlayers becomeFirstResponder];
        }
    } else if (alertView.tag == 99) {
        NSMutableArray *defaultsArray = [NSMutableArray new];
        for (int i = 0; i < [self.numDefaultPlayers.text intValue]; i++) {
            NSMutableDictionary *defaultPlayer = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:0],@"playerRaise",[NSNumber numberWithInt:0],@"playerCall",[NSNumber numberWithInt:0],@"playerFold", nil];
            NSString *playerName = [NSString stringWithFormat:@"Default Player %i",i+1];
            [defaultPlayer setValue:playerName forKey:@"playerName"];
            [defaultsArray addObject:defaultPlayer];
        }
        self.listPlayers = defaultsArray;
        [self.tablePlayers reloadData];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.listPlayers == nil) {
        return 0;
    } else {
        return [self.listPlayers count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"playerCell";
    PokerPlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSDictionary *currentPlayer = [self.listPlayers objectAtIndex:indexPath.row];
    cell.name.text = [currentPlayer objectForKey:@"playerName"];
    cell.call.text = [[currentPlayer objectForKey:@"playerCall"]stringValue];
    cell.fold.text = [[currentPlayer objectForKey:@"playerFold"]stringValue];
    cell.raise.text = [[currentPlayer objectForKey:@"playerRaise"]stringValue];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.cellChosen = indexPath.row;
    self.currentPlayer = [[self.listPlayers objectAtIndex:indexPath.row]mutableCopy];
    [[NSUserDefaults standardUserDefaults]setObject:self.currentPlayer forKey:@"currentPlayerChosen"];
    self.playerOptions = [[UIActionSheet alloc]initWithTitle:[self.currentPlayer valueForKey:@"playerName"] delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Fold", @"Raise", @"Check/Call", nil];
    [self.playerOptions showFromTabBar:self.tabBarController.tabBar];
}

#pragma mark - Action sheet delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSNumber *numToIncrement = [NSNumber numberWithInt:0];
    if (buttonIndex == 0) {
        numToIncrement = [self.currentPlayer valueForKey:@"playerFold"];
        numToIncrement = [NSNumber numberWithInt:[numToIncrement intValue]+1];
        [self.currentPlayer setValue:numToIncrement forKey:@"playerFold"];
    } else if (buttonIndex == 1) {
        numToIncrement = [self.currentPlayer valueForKey:@"playerRaise"];
        numToIncrement = [NSNumber numberWithInt:[numToIncrement intValue]+1];
        [self.currentPlayer setValue:numToIncrement forKey:@"playerRaise"];
    } else if (buttonIndex == 2) {
        numToIncrement = [self.currentPlayer valueForKey:@"playerCall"];
        numToIncrement = [NSNumber numberWithInt:[numToIncrement intValue]+1];
        [self.currentPlayer setValue:numToIncrement forKey:@"playerCall"];
    }
    [self.listPlayers replaceObjectAtIndex:self.cellChosen withObject:self.currentPlayer];
    if (![[[self.listPlayers objectAtIndex:0] valueForKey:@"playerName"]isEqualToString:@"Default Player 1"]) {
        [[NSUserDefaults standardUserDefaults]setObject:self.listPlayers forKey:@"listPlayers"];
    }
    [self.tablePlayers reloadData];
}

@end
