//
//  Players.m
//  Live Poker Stats
//
//  Created by Hemant Bhonsle on 10/20/12.
//  Copyright (c) 2012 Hemant Bhonsle and Matthew Hui. All rights reserved.
//

#import "Players.h"
#import "PokerPlayerCell.h"
#import "PokerPlayerDetails.h"
#import <QuartzCore/QuartzCore.h>

@interface Players ()

@end

@implementation Players

@synthesize tablePlayers = _tablePlayers;
@synthesize listPlayers = _listPlayers;
@synthesize playerNameTextField = _playerNameTextField;
@synthesize createPlayer = _createPlayer;
@synthesize playerDetails = _playerDetails;
@synthesize nameLabel = _nameLabel;
 
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
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"listPlayers"] != nil) {
        self.listPlayers = [[[NSUserDefaults standardUserDefaults]objectForKey:@"listPlayers"]mutableCopy];
    } else {
        self.listPlayers = [NSMutableArray new];
        [[NSUserDefaults standardUserDefaults]setObject:self.listPlayers forKey:@"listPlayers"];
    }
    [self.tablePlayers reloadData];
}

-(IBAction)createPlayer:(id)sender
{
    self.createPlayer = [[UIAlertView alloc] initWithTitle:@"Please Enter Name of Player"
                                                                        message:@""
                                                                       delegate:self
                                                              cancelButtonTitle:@"Cancel"
                                                              otherButtonTitles:@"Create", nil];
    
    self.playerNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 15.0, 245.0, 25.0)];
    self.playerNameTextField.delegate=self;
    [self.playerNameTextField setBackgroundColor:[UIColor whiteColor]];
    [self.playerNameTextField setKeyboardType:UIKeyboardTypeDefault];
    self.playerNameTextField.placeholder=@"Username";
    self.playerNameTextField.secureTextEntry=NO;
    self.playerNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.createPlayer addSubview:self.playerNameTextField];
    [self.createPlayer show];
    [self.playerNameTextField becomeFirstResponder];
}

#pragma mark - UIAlertView delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSMutableDictionary *newPlayer = [NSMutableDictionary new];
    if (buttonIndex != alertView.cancelButtonIndex) {
        [newPlayer setValue:self.playerNameTextField.text forKey:@"playerName"];
        [newPlayer setValue:[NSNumber numberWithInt:0] forKey:@"playerRaise"];
        [newPlayer setValue:[NSNumber numberWithInt:0] forKey:@"playerCall"];
        [newPlayer setValue:[NSNumber numberWithInt:0] forKey:@"playerFold"];
        [self.listPlayers addObject:newPlayer];
        [[NSUserDefaults standardUserDefaults]setObject:self.listPlayers forKey:@"listPlayers"];
        [self.tablePlayers reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
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
    static NSString *CellIdentifier = @"PlayerCell";
    PokerPlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSDictionary *currentPlayer = [self.listPlayers objectAtIndex:indexPath.row];
    cell.name.text = [currentPlayer objectForKey:@"playerName"];
    cell.call.text = [[currentPlayer objectForKey:@"playerCall"]stringValue];
    cell.fold.text = [[currentPlayer objectForKey:@"playerFold"]stringValue];
    cell.raise.text = [[currentPlayer objectForKey:@"playerRaise"]stringValue];
    [cell.name setFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:16]];
    cell.name.textColor = [UIColor darkGrayColor];
    cell.shouldIndentWhileEditing = NO;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSMutableDictionary *thePlayer = [self.listPlayers objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults]setObject:thePlayer forKey:@"currentPlayerChosen"];
    [self viewPlayer];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"runs");
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableDictionary *thePlayer = [self.listPlayers objectAtIndex:indexPath.row];
        NSLog(@"entered delete");
        [[NSUserDefaults standardUserDefaults]setObject:thePlayer forKey:@"currentPlayerChosen"];
        [self.listPlayers removeObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"currentPlayerChosen"]];
        [self.tablePlayers deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        [self deletePlayer];
    }
}

-(void)viewPlayer
{
    PokerPlayerDetails *playerPage = [[PokerPlayerDetails alloc]init];
    
    [self.navigationController pushViewController:playerPage animated:YES];
}

-(void)deletePlayer
{
    [self.listPlayers removeObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"currentPlayerChosen"]];
    [[NSUserDefaults standardUserDefaults]setObject:self.listPlayers forKey:@"listPlayers"];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animate
{
    [super setEditing:editing animated:animate];
    if(editing)
    {
        [self.tablePlayers setEditing:YES animated:YES];
    }
    else
    {
        [self.tablePlayers setEditing:NO animated:YES];

    }
}


@end
