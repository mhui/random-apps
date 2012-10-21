//
//  Session.h
//  Live Poker Stats
//
//  Created by Hemant Bhonsle on 10/20/12.
//  Copyright (c) 2012 Hemant Bhonsle and Matthew Hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Session : UIViewController <UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UITextFieldDelegate>

@property (strong, nonatomic) UIAlertView *chooseTableType;
@property (strong, nonatomic) IBOutlet UITableView *tablePlayers;
@property (strong, nonatomic) NSMutableArray *listPlayers;
@property (strong, nonatomic) UIActionSheet *playerOptions;
@property (strong, nonatomic) UITextField *numDefaultPlayers;
@property (strong, nonatomic) NSMutableDictionary *currentPlayer;
@property (nonatomic) int cellChosen;

@end
