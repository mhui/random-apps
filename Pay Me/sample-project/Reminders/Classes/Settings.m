//
//  Settings.m
//  Pay Me!
//
//  Created by Hemant Bhonsle on 11/8/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import "Settings.h"

@interface Settings ()

@end

@implementation Settings

@synthesize settingsTable = _settingsTable;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"buttonStatusInactive"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonInactive" object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Options";
    } else {
        return @"About";
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    } else {
        return 2;
    } 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SettingsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *cellValue = [NSString new];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cellValue = @"Master Clear";
            cell.detailTextLabel.text = @"All";
        } else if (indexPath.row == 1) {
            cellValue = @"Pay Me";
            cell.detailTextLabel.text = @"Clear";
        } else if (indexPath.row == 2) {
            cellValue = @"Pay To";
            cell.detailTextLabel.text = @"Clear";
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cellValue = @"Version";
            cell.detailTextLabel.text = @"1.0";
        } else {
            cellValue = @"Support";
            cell.detailTextLabel.text = @"hbhonsle3@gmail.com";
        }
    }
    cell.textLabel.text = cellValue;
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    
    cell.textLabel.font = [UIFont fontWithName:@"System" size:16];
    cell.detailTextLabel.font = [UIFont fontWithName:@"System" size:14];
    
    cell.textLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UIAlertView *masterClear = [[UIAlertView alloc]initWithTitle:@"Master Clear" message:@"Are you sure you wish to clear all entries in Pay Me and Pay To? This action cannot be undone." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
            masterClear.tag = 1;
            [masterClear show];
        } else if (indexPath.row == 1) {
            UIAlertView *masterClear2 = [[UIAlertView alloc]initWithTitle:@"Clear Pay Me" message:@"Are you sure you wish to clear all entries in Pay Me? This action cannot be undone." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
            masterClear2.tag = 3;
            [masterClear2 show];
        } else if (indexPath.row == 2) {
            UIAlertView *masterClear3 = [[UIAlertView alloc]initWithTitle:@"Clear Pay To" message:@"Are you sure you wish to clear all entries in Pay To? This action cannot be undone." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
            masterClear3.tag = 4;
            [masterClear3 show];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UIAlertView *version = [[UIAlertView alloc] initWithTitle:@"VERSION 1.0" message:@"You are currently running Version 1.0" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [version show];
        } else {
            UIAlertView *callSupport = [[UIAlertView alloc]initWithTitle:@"Email Support" message:@"Are you sure you wish to email support at: \n hbhonsle3@gmail.com" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
            callSupport.tag = 2;
            [callSupport show];
        }
    }
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,200,300,244)];
//    tempView.backgroundColor=[UIColor clearColor];
//    
//    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,300,44)];
//    tempLabel.backgroundColor=[UIColor clearColor];
//    tempLabel.shadowColor = [UIColor blackColor];
//    tempLabel.shadowOffset = CGSizeMake(0,2);
//    tempLabel.textColor = [UIColor whiteColor];
//    tempLabel.font = [UIFont fontWithName:@"System Bold" size:26];
//    if (section == 0) {
//        tempLabel.text = @"Options";
//    } else if (section == 1) {
//        tempLabel.text = @"About";
//    }
//    [tempView addSubview:tempLabel];
//    
//    return tempView;
//}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex && alertView.tag == 1) {
        
        //do some stuff for master clear
        NSLog(@"master clear");
        NSMutableArray *emptyArray = [[NSMutableArray alloc]init];
        [[NSUserDefaults standardUserDefaults]setObject:emptyArray forKey:@"listPeople"];
        [[NSUserDefaults standardUserDefaults]setObject:emptyArray forKey:@"listPeopleNext"];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"tableClearedMe"];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"tableClearedTo"];
    } else if (buttonIndex != alertView.cancelButtonIndex && alertView.tag == 2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:hbhonsle3@gmail.com"]];
    } else if (buttonIndex != alertView.cancelButtonIndex && alertView.tag == 3) {
        NSLog(@"table cleared me");
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"tableClearedMe"];
        NSMutableArray *emptyArray = [[NSMutableArray alloc]init];
        [[NSUserDefaults standardUserDefaults]setObject:emptyArray forKey:@"listPeople"];
    } else if (buttonIndex != alertView.cancelButtonIndex && alertView.tag == 4) {
        NSLog(@"table cleared to");
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"tableClearedTo"];
        NSMutableArray *emptyArray = [[NSMutableArray alloc]init];
        [[NSUserDefaults standardUserDefaults]setObject:emptyArray forKey:@"listPeopleNext"];
    }
}

@end
