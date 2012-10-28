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
#import <QuartzCore/QuartzCore.h>

@interface RemindersViewController ()

@end

@implementation RemindersViewController

@synthesize groups, subGroups, groupIcons, selectedGroupIcons;
@synthesize person = _person;

#pragma mark - View lifecycle


- (id) init
{
    if (self = [super initWithNibName:@"SDNestedTableView" bundle:nil])
    {
        
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSUserDefaults standardUserDefaults]setValue:@"owedView" forKey:@"currentView"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.person.view.center.y == 190) {
        self.person.view.center = CGPointMake(160, 700);
        [self.person.view removeFromSuperview];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (self.person.view.center.y == 190) {
        self.person.view.center = CGPointMake(160, 700);
        [self.person.view removeFromSuperview];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
	   
    [ADVThemeManager customizeTableView:self.tableView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTable:) name:@"buttonPressed" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTable:) name:@"doneCreating" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTable:) name:@"cancelPerson" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTable:) name:@"editPerson" object:nil];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"listPeople"] != nil) {
        self.groups = [[[NSUserDefaults standardUserDefaults]objectForKey:@"listPeople"]mutableCopy];
        self.subGroups = [[[NSUserDefaults standardUserDefaults]objectForKey:@"listPeople"]mutableCopy];
    } else {
        self.groups = [NSMutableArray new];
        self.subGroups = [NSMutableArray new];
    }
        
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
    if ([[notification name]isEqualToString:@"buttonPressed"] && self.person.view.center.y != 190 && [[[NSUserDefaults standardUserDefaults]valueForKey:@"currentView"]isEqualToString:@"owedView"]) {
        self.person = [[CreatePerson alloc]init];
        [ADVThemeManager customizeView:self.person.view];
        self.person.view.center = CGPointMake(160, 700);
        [self.view addSubview:self.person.view];
        [self.view bringSubviewToFront:self.person.view];
        [UIView animateWithDuration:0.5 animations:^{
            self.person.view.center = CGPointMake(160, 190);
        }];
    } else if ([[notification name]isEqualToString:@"doneCreating"]) {
        self.groups = [[[NSUserDefaults standardUserDefaults]objectForKey:@"listPeople"]mutableCopy];
        self.subGroups = [[[NSUserDefaults standardUserDefaults]objectForKey:@"listPeople"]mutableCopy];
        [self.tableView reloadData];
        [UIView animateWithDuration:0.5 animations:^{
            self.person.view.center = CGPointMake(160, 700);
        }];
    } else if ([[notification name]isEqualToString:@"cancelPerson"]) {
        [UIView animateWithDuration:0.5 animations:^{
            self.person.view.center = CGPointMake(160, 700);
        }completion:^(BOOL finished) {
            if (finished) {
                [self.person.view removeFromSuperview];
            }
        }];
    } else if ([[notification name]isEqualToString:@"editPerson"]) {
        NSMutableDictionary *stats = [[NSUserDefaults standardUserDefaults]valueForKey:@"currentPlayerChosen"];
        self.person = [[CreatePerson alloc]init];
        [ADVThemeManager customizeView:self.person.view];
        self.person.view.center = CGPointMake(160, 700);
        self.person.nameField.text = [stats valueForKey:@"personName"];
        self.person.detailsField.text = [stats valueForKey:@"personDetail"];
        self.person.moneyField.text = [stats valueForKey:@"personPrice"];
        [self.view addSubview:self.person.view];
        [self.view bringSubviewToFront:self.person.view];
        [UIView animateWithDuration:0.5 animations:^{
            self.person.view.center = CGPointMake(160, 190);
        }];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"inEditMode"];
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
    item.valueLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    item.notifImageView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    item.itemText.text = [[self.groups objectAtIndex:indexPath.row]valueForKey:@"personName"];
    item.valueLabel.text = [[self.groups objectAtIndex:indexPath.row]valueForKey:@"personPrice"];
    item.cellTag = indexPath.row;
//    NSString* unselectedIconName = groupIcons[indexPath.row];
    item.unSelectedIconImage = [UIImage imageNamed:@"icon-clock"];
    
//    NSString* selectedIconName = selectedGroupIcons[indexPath.row];
    item.selectedIconImage = [UIImage imageNamed:@"icon-clock-selected"];
        
    return item;
}


- (SDSubCell *)item:(SDGroupCell *)item setSubItem:(SDSubCell *)subItem forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *data = [self.groups objectAtIndex:item.cellTag];
    subItem.itemText.text = [data valueForKey:@"personDetail"];
    subItem.valueLabel.text = [data valueForKey:@"personDate"];
    subItem.row = item.cellTag;
    return subItem;
}

- (void) mainTable:(UITableView *)mainTable itemDidChange:(SDGroupCell *)item
{
    SelectableCellState state = item.selectableCellState;
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:item];
    switch (state) {
        case Checked:
//            NSLog(@"Changed Item at indexPath:%@ to state \"Checked\"", indexPath);
            break;
        case Unchecked:
//            NSLog(@"Changed Item at indexPath:%@ to state \"Unchecked\"", indexPath);
            break;
        case Halfchecked:
//            NSLog(@"Changed Item at indexPath:%@ to state \"Halfchecked\"", indexPath);
            break;
        default:
            break;
    }
}

- (void) mainItem:(SDGroupCell *)item subItemDidChange: (SDSelectableCell *)subItem forTap:(BOOL)tapped
{
    SelectableCellState state = subItem.selectableCellState;
//    NSIndexPath *indexPath = [item.subTable indexPathForCell:subItem];
    switch (state) {
        case Checked:
//            NSLog(@"Changed Sub Item at indexPath:%@ to state \"Checked\"", indexPath);
            break;
        case Unchecked:
//            NSLog(@"Changed Sub Item at indexPath:%@ to state \"Unchecked\"", indexPath);
            break;
        default:
            break;
    }
}

- (void)expandingItem:(SDGroupCell *)item withIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"Expanded Item at indexPath: %@", indexPath);
    [[NSUserDefaults standardUserDefaults]setInteger:indexPath.row forKey:@"rowToInsert"];
    NSMutableDictionary *currentPlayer = [self.groups objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults]setValue:currentPlayer forKey:@"currentPlayerChosen"];
}

- (void)collapsingItem:(SDGroupCell *)item withIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"Collapsed Item at indexPath: %@", indexPath);
}

-(IBAction)clearTable:(id)sender
{
    NSMutableArray *list = [[NSMutableArray alloc]init];
    self.groups = list;
    self.subGroups = list;
    [[NSUserDefaults standardUserDefaults]setObject:list forKey:@"listPeople"];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableDictionary *thePlayer = [self.groups objectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults]setObject:thePlayer forKey:@"currentPlayerChosen"];
        [self.groups removeObject:thePlayer];
        [self.subGroups removeObject:thePlayer];
        [[NSUserDefaults standardUserDefaults]setObject:self.groups forKey:@"listPeople"];
        self.groups = [[[NSUserDefaults standardUserDefaults]objectForKey:@"listPeople"]mutableCopy];
        self.subGroups = [[[NSUserDefaults standardUserDefaults]objectForKey:@"listPeople"]mutableCopy];
        [UIView animateWithDuration:3.0 animations:^{
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationMiddle];
        }completion:^(BOOL finished){
            if (finished) {
                [self.tableView reloadData];
            }
        }];
    }
}

@end
