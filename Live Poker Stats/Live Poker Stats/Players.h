//
//  Players.h
//  Live Poker Stats
//
//  Created by Hemant Bhonsle on 10/20/12.
//  Copyright (c) 2012 Hemant Bhonsle and Matthew Hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Players : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UITextFieldDelegate, UIActionSheetDelegate>

@property (strong,nonatomic) IBOutlet UITableView *tablePlayers;
@property (strong,nonatomic) NSMutableArray *listPlayers;
@property (strong,nonatomic) UITextField *playerNameTextField;
@property (strong, nonatomic) UIAlertView *createPlayer;
@property (strong, nonatomic) UIAlertView *playerDetails;
@property (strong,nonatomic) UIActionSheet *playerOptions;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *checkLabel;
@property (strong, nonatomic) IBOutlet UILabel *raiseLabel;
@property (strong, nonatomic) IBOutlet UILabel *foldLabel;

-(IBAction)createPlayer:(id)sender;

@end
