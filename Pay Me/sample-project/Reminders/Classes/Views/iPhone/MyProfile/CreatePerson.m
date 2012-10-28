//
//  CreatePerson.m
//  Pay Me!
//
//  Created by Hemant Bhonsle on 10/24/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import "CreatePerson.h"

@interface CreatePerson ()

@end

@implementation CreatePerson

@synthesize nameField = _nameField;
@synthesize moneyField = _moneyField;
@synthesize detailsField = _detailsField;

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
    // Do any additional setup after loading the view from its nib.
    self.nameField.delegate = self;
    self.moneyField.delegate = self;
    self.detailsField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)createPerson:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"currentView"]isEqualToString:@"owedView"]) {
    NSMutableArray *listPeople = [[[NSUserDefaults standardUserDefaults]objectForKey:@"listPeople"]mutableCopy];
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"inEditMode"]) {
            [listPeople removeObject:[[NSUserDefaults standardUserDefaults]valueForKey:@"currentPlayerChosen"]];
        }
    NSMutableDictionary *testPerson = [[NSMutableDictionary alloc]init];
    [testPerson setValue:self.nameField.text forKey:@"personName"];
    [testPerson setValue:self.moneyField.text forKey:@"personPrice"];
    [testPerson setValue:self.detailsField.text forKey:@"personDetail"];
    
    NSDateFormatter *formatDate = [[NSDateFormatter alloc]init];
    [formatDate setDateFormat:@"MM/dd/yyyy"];
    NSDate *currentTime = [NSDate date];
    [testPerson setValue:[formatDate stringFromDate:currentTime] forKey:@"personDate"];
    
    [formatDate setDateFormat:@"hh:mm:ss a"];
    [testPerson setValue:[formatDate stringFromDate:currentTime] forKey:@"personTime"];
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"inEditMode"]) {
        [listPeople insertObject:testPerson atIndex:[[NSUserDefaults standardUserDefaults]integerForKey:@"rowToInsert"]];
    } else {
        [listPeople addObject:testPerson];
    }
    [[NSUserDefaults standardUserDefaults]setObject:listPeople forKey:@"listPeople"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"doneCreating" object:nil];
    } else {
        NSMutableArray *listPeople = [[[NSUserDefaults standardUserDefaults]objectForKey:@"listPeopleNext"]mutableCopy];
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"inEditMode"]) {
            [listPeople removeObject:[[NSUserDefaults standardUserDefaults]valueForKey:@"currentPlayerChosen"]];
        }
        NSMutableDictionary *testPerson = [[NSMutableDictionary alloc]init];
        [testPerson setValue:self.nameField.text forKey:@"personName"];
        [testPerson setValue:self.moneyField.text forKey:@"personPrice"];
        [testPerson setValue:self.detailsField.text forKey:@"personDetail"];
        
        NSDateFormatter *formatDate = [[NSDateFormatter alloc]init];
        [formatDate setDateFormat:@"MM/dd/yyyy"];
        NSDate *currentTime = [NSDate date];
        [testPerson setValue:[formatDate stringFromDate:currentTime] forKey:@"personDate"];
        
        [formatDate setDateFormat:@"hh:mm:ss a"];
        [testPerson setValue:[formatDate stringFromDate:currentTime] forKey:@"personTime"];
        
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"inEditMode"]) {
            [listPeople insertObject:testPerson atIndex:[[NSUserDefaults standardUserDefaults]integerForKey:@"rowToInsert"]];
        } else {
            [listPeople addObject:testPerson];
        }
        
        [[NSUserDefaults standardUserDefaults]setObject:listPeople forKey:@"listPeopleNext"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"doneCreating" object:nil];
    }
}


-(IBAction)cancelPerson:(id)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"cancelPerson" object:nil];
}

@end
