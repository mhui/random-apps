//
//  CreatePerson.h
//  Pay Me!
//
//  Created by Hemant Bhonsle on 10/24/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatePerson : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *moneyField;
@property (strong, nonatomic) IBOutlet UITextField *detailsField;

-(IBAction)createPerson:(id)sender;
//-(IBAction)createPerson2:(id)sender;
-(IBAction)cancelPerson:(id)sender;

@end
