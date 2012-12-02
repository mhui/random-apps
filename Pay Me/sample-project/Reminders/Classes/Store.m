//
//  Store.m
//  Pay Me!
//
//  Created by Hemant Bhonsle on 11/8/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import "Store.h"

@interface Store ()

@end

@implementation Store

@synthesize storeTable = _storeTable;

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
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Coming Soon!";
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StoreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *cellValue = [NSString new];
    /**
        if (indexPath.row == 0) {
            cellValue = @"Blue";
            cell.detailTextLabel.text = @"Theme";
        } else if (indexPath.row == 1) {
            cellValue = @"Green";
            cell.detailTextLabel.text = @"Theme";
        } else if (indexPath.row == 2) {
            cellValue = @"Purple";
            cell.detailTextLabel.text = @"Theme";
        }
    */
    cellValue = @"Stay tuned...";
    cell.detailTextLabel.text = @"";
    
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
            [[NSUserDefaults standardUserDefaults]setValue:@"blue" forKey:@"colorChosen"];
        } else if (indexPath.row == 1) {
            [[NSUserDefaults standardUserDefaults]setValue:@"green" forKey:@"colorChosen"];
        } else if (indexPath.row == 2) {
            [[NSUserDefaults standardUserDefaults]setValue:@"purple" forKey:@"colorChosen"];
        }
    }
}




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

}

@end