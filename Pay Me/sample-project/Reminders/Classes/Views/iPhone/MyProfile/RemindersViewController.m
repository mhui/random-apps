//
//  ProfileViewController.m
//  Reminders
//
//  Created by Valentin Filip on 8/8/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import "RemindersViewController.h"
#import "ADVTheme.h"
#import "ReminderCell.h"

@interface RemindersViewController ()

@end

@implementation RemindersViewController

@synthesize groups, subGroups, groupIcons, selectedGroupIcons;

#pragma mark - View lifecycle


- (id) init
{
    if (self = [super initWithNibName:@"SDNestedTableView" bundle:nil])
    {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
	   
    [ADVThemeManager customizeTableView:self.tableView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTable:) name:@"buttonPressed" object:nil];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"listPeople"] != nil) {
        self.groups = [[NSUserDefaults standardUserDefaults]objectForKey:@"listPeople"];
        self.subGroups = [[NSUserDefaults standardUserDefaults]objectForKey:@"listPeople"];
    } else {
        self.groups = [NSArray new];
        self.subGroups = [NSArray new];
    }
    
    //self.groups =
    
    
    
    //self.groupIcons = @[@"icon-check", @"icon-list", @"icon-calendar", @"icon-clock"];
    
    //self.selectedGroupIcons = @[@"icon-check-selected", @"icon-list-selected", @"icon-calendar-selected", @"icon-clock-selected"];
        
    UIImageView *imgTableFooter = [[UIImageView alloc] initWithImage:[[ADVThemeManager sharedTheme] tableFooterBackground]];
    [self.tableView setTableFooterView:imgTableFooter];
    [self.tableView reloadData];    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidUnload {
    self.groups = nil;
    self.subGroups = nil;
    self.groupIcons = nil;
    self.selectedGroupIcons = nil;
    [super viewDidUnload];
}

-(void)reloadTable:(NSNotification *)notification
{
    if ([[notification name]isEqualToString:@"buttonPressed"]) {
        self.groups = [[NSUserDefaults standardUserDefaults]objectForKey:@"listPeople"];
        NSLog(@"set groups");
        self.subGroups = [[NSUserDefaults standardUserDefaults]objectForKey:@"listPeople"];
        NSLog(@"okay");
        [self.tableView reloadData];
    }
}


#pragma mark - Nested Tables methods

- (NSInteger)mainTable:(UITableView *)mainTable numberOfItemsInSection:(NSInteger)section
{
    return [groups count];
}

- (NSInteger)mainTable:(UITableView *)mainTable numberOfSubItemsforItem:(SDGroupCell *)item atIndexPath:(NSIndexPath *)indexPath
{
    return 1;
}

- (SDGroupCell *)mainTable:(UITableView *)mainTable setItem:(SDGroupCell *)item forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"code for main rows ran");
    item.itemText.text = [[self.groups objectAtIndex:indexPath.row]valueForKey:@"personName"];
    item.valueLabel.text = [[self.groups objectAtIndex:indexPath.row]valueForKey:@"personPrice"];
    
//    NSString* unselectedIconName = groupIcons[indexPath.row];
    item.unSelectedIconImage = [UIImage imageNamed:@"icon-clock"];
    
//    NSString* selectedIconName = selectedGroupIcons[indexPath.row];
    item.selectedIconImage = [UIImage imageNamed:@"icon-clock-selected"];
    
    return item;
}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 UITableViewCell* cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
 
 [cell.layer setShadowColor:[[UIColor grayColor] CGColor]];
 [cell.layer setShadowOffset:CGSizeMake(0, 2)];
 [cell.layer setShadowOpacity:0.5];
 if(indexPath.row == groups.count - 1){
 
 }
 return cell;
 }
 
 */

- (SDSubCell *)item:(SDGroupCell *)item setSubItem:(SDSubCell *)subItem forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSIndexPath *pathGroupCell = [self.tableView indexPathForCell:item];
//    NSArray *data = subGroups[pathGroupCell.row];
    NSLog(@"code ran");
    subItem.itemText.text = [[self.subGroups objectAtIndex:indexPath.row]valueForKey:@"personDetail"];
    NSLog(@"code ran still");
    subItem.valueLabel.text = [[self.subGroups objectAtIndex:indexPath.row]valueForKey:@"personDate"];
    return subItem;
}

- (void) mainTable:(UITableView *)mainTable itemDidChange:(SDGroupCell *)item
{
    SelectableCellState state = item.selectableCellState;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:item];
    switch (state) {
        case Checked:
            NSLog(@"Changed Item at indexPath:%@ to state \"Checked\"", indexPath);
            break;
        case Unchecked:
            NSLog(@"Changed Item at indexPath:%@ to state \"Unchecked\"", indexPath);
            break;
        case Halfchecked:
            NSLog(@"Changed Item at indexPath:%@ to state \"Halfchecked\"", indexPath);
            break;
        default:
            break;
    }
}

- (void) mainItem:(SDGroupCell *)item subItemDidChange: (SDSelectableCell *)subItem forTap:(BOOL)tapped
{
    SelectableCellState state = subItem.selectableCellState;
    NSIndexPath *indexPath = [item.subTable indexPathForCell:subItem];
    switch (state) {
        case Checked:
            NSLog(@"Changed Sub Item at indexPath:%@ to state \"Checked\"", indexPath);
            break;
        case Unchecked:
            NSLog(@"Changed Sub Item at indexPath:%@ to state \"Unchecked\"", indexPath);
            break;
        default:
            break;
    }
}

- (void)expandingItem:(SDGroupCell *)item withIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Expanded Item at indexPath: %@", indexPath);
}

- (void)collapsingItem:(SDGroupCell *)item withIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Collapsed Item at indexPath: %@", indexPath);
}

-(IBAction)clearTable:(id)sender
{
    NSMutableArray *list = [[NSMutableArray alloc]init];
    self.groups = list;
    [[NSUserDefaults standardUserDefaults]setObject:list forKey:@"listPeople"];
    [self.tableView reloadData];
}

//- (void)setEditing:(BOOL)editing animated:(BOOL)animate
//{
//    [super setEditing:editing animated:animate];
//    if(editing)
//    {
//        [self.tableView setEditing:YES animated:YES];
//    }
//    else
//    {
//        [self.tableView setEditing:NO animated:YES];
//        
//    }
//}

@end
