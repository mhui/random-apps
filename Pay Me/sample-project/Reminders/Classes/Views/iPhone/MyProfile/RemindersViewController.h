//
//  ProfileViewController.h
//  Reminders
//
//  Created by Valentin Filip on 8/8/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDNestedTableViewController.h"
#import "CreatePerson.h"

@interface RemindersViewController : SDNestedTableViewController <UINavigationBarDelegate, UITableViewDelegate> {
    NSArray *items;
}

@property (nonatomic, strong) NSMutableArray* groups;
@property (nonatomic, strong) NSArray* groupIcons;
@property (nonatomic, strong) NSArray* selectedGroupIcons;
@property (nonatomic, strong) NSMutableArray* subGroups;
@property (nonatomic, strong) CreatePerson* person;

@end
