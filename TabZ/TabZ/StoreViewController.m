//
//  StoreViewController.m
//  TabZ
//
//  Created by Hemant Bhonsle on 8/26/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "StoreViewController.h"
#import <StoreKit/StoreKit.h>

@interface StoreViewController ()

@end

@implementation StoreViewController

@synthesize theStore = _theStore;
@synthesize loadingSpinner = _loadingSpinner;

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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/**
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,200,300,244)];
    tempView.backgroundColor=[UIColor clearColor];
    
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,300,44)];
    tempLabel.backgroundColor=[UIColor clearColor]; 
    tempLabel.shadowColor = [UIColor blackColor];
    tempLabel.shadowOffset = CGSizeMake(0,2);
    tempLabel.textColor = [UIColor whiteColor];
    tempLabel.font = [UIFont fontWithName:@"System Bold" size:26];
    tempLabel.text = @"Store";
    [tempView addSubview:tempLabel];
    
    return tempView;
}
*/

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Angel Character";
        cell.imageView.image = [UIImage imageNamed:@"angelSkin"];
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"angelPurchased"]) {
            cell.detailTextLabel.text = @"Bought";
        } else {
            cell.detailTextLabel.text = @"$0.99";
        }
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"Demon Character";
        cell.imageView.image = [UIImage imageNamed:@"demonSkin"];
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"demonPurchased"]) {
            cell.detailTextLabel.text = @"Bought";
        } else {
            cell.detailTextLabel.text = @"$0.99";
        }
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"Monkey Character";
        cell.imageView.image = [UIImage imageNamed:@"monkeySkin"];
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"monkeyPurchased"]) {
            cell.detailTextLabel.text = @"Bought";
        } else {
            cell.detailTextLabel.text = @"$0.99";
        }
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"Shark Character";
        cell.imageView.image = [UIImage imageNamed:@"sharkSkin"];
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"sharkPurchased"]) {
            cell.detailTextLabel.text = @"Bought";
        } else {
            cell.detailTextLabel.text = @"$0.99";
        }
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"Troll Character";
        cell.imageView.image = [UIImage imageNamed:@"trollSkin"];
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"trollPurchased"]) {
            cell.detailTextLabel.text = @"Bought";
        } else {
            cell.detailTextLabel.text = @"$0.99";
        }
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"Default Character";
        cell.detailTextLabel.text = @"FREE";
        cell.imageView.image = [UIImage imageNamed:@"playerFace2.png"];
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if (indexPath.row == 0) {
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"angelPurchased"]) {
            UIAlertView *angelEquipped = [[UIAlertView alloc]initWithTitle:@"Angel Character Equipped" message:nil delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
            [angelEquipped show];
            [[NSUserDefaults standardUserDefaults]setObject:@"angelCharacter" forKey:@"currentCharacter"];
            [self.theStore reloadData];
        } else {
            self.loadingSpinner.hidden = NO;
            [self.loadingSpinner startAnimating];
            SKProductsRequest *request = [[SKProductsRequest alloc]initWithProductIdentifiers:[NSSet setWithObject:@"LazerzAngel"]];
            request.delegate = self;
            [request start];
        }
        
    } else if (indexPath.row == 1) {
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"demonPurchased"]) {
            UIAlertView *angelEquipped = [[UIAlertView alloc]initWithTitle:@"Demon Character Equipped" message:nil delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
            [angelEquipped show];
            [[NSUserDefaults standardUserDefaults]setObject:@"demonCharacter" forKey:@"currentCharacter"];
            [self.theStore reloadData];
        } else {
            self.loadingSpinner.hidden = NO;
            [self.loadingSpinner startAnimating];
            SKProductsRequest *request = [[SKProductsRequest alloc]initWithProductIdentifiers:[NSSet setWithObject:@"LazerzDemon"]];
            request.delegate = self;
            [request start];
        }
        
    } else if (indexPath.row == 2) {
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"monkeyPurchased"]) {
            UIAlertView *angelEquipped = [[UIAlertView alloc]initWithTitle:@"Monkey Character Equipped" message:nil delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
            [angelEquipped show];
            [[NSUserDefaults standardUserDefaults]setObject:@"monkeyCharacter" forKey:@"currentCharacter"];
            [self.theStore reloadData];
        } else {
            self.loadingSpinner.hidden = NO;
            [self.loadingSpinner startAnimating];
            SKProductsRequest *request = [[SKProductsRequest alloc]initWithProductIdentifiers:[NSSet setWithObject:@"LazerzMonkey"]];
            request.delegate = self;
            [request start];
        }
        
    } else if (indexPath.row == 3) {
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"sharkPurchased"]) {
            UIAlertView *angelEquipped = [[UIAlertView alloc]initWithTitle:@"Shark Character Equipped" message:nil delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
            [angelEquipped show];
            [[NSUserDefaults standardUserDefaults]setObject:@"sharkCharacter" forKey:@"currentCharacter"];
            [self.theStore reloadData];
        } else {
            self.loadingSpinner.hidden = NO;
            [self.loadingSpinner startAnimating];
            SKProductsRequest *request = [[SKProductsRequest alloc]initWithProductIdentifiers:[NSSet setWithObject:@"LazerzShark"]];
            request.delegate = self;
            [request start];
        }
        
    } else if (indexPath.row == 4) {
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"trollPurchased"]) {
            UIAlertView *angelEquipped = [[UIAlertView alloc]initWithTitle:@"Troll Character Equipped" message:nil delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
            [angelEquipped show];
            [[NSUserDefaults standardUserDefaults]setObject:@"trollCharacter" forKey:@"currentCharacter"];
            [self.theStore reloadData];
        } else {
            self.loadingSpinner.hidden = NO;
            [self.loadingSpinner startAnimating];
            SKProductsRequest *request = [[SKProductsRequest alloc]initWithProductIdentifiers:[NSSet setWithObject:@"LazerzTroll"]];
            request.delegate = self;
            [request start];
        }
        
    } else if (indexPath.row == 5) {
        [[NSUserDefaults standardUserDefaults]setObject:@"defaultCharacter" forKey:@"currentCharacter"];
        UIAlertView *defaultEquipped = [[UIAlertView alloc]initWithTitle:@"Default Character Equipped" message:nil delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
        [defaultEquipped show];
        [self.theStore reloadData];
    }
}

#pragma mark Store Kit delegate

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    SKProduct *product = [response.products objectAtIndex:0];
    SKPayment *payment = [SKPayment paymentWithProduct:product];  
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];  
    [[SKPaymentQueue defaultQueue] addPayment:payment]; 
}

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    self.loadingSpinner.hidden = YES;
    [self.loadingSpinner stopAnimating];
    for(SKPaymentTransaction *transaction in transactions)
    {
        switch(transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
            {
                break;
            }
            case SKPaymentTransactionStatePurchased:
            {
                //do crediting here
                NSLog(@"transactionid = %@",transaction);
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                
                NSLog(@"%@", transaction.payment.productIdentifier);
                // use transaction.payment.productIdentifier to see what they purchased.
                
                NSString *productPurchased = transaction.payment.productIdentifier;
                
                if ([productPurchased isEqualToString:@"LazerzAngel"]) {
                    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"angelPurchased"];
                    [[NSUserDefaults standardUserDefaults]setObject:@"angelCharacter" forKey:@"currentCharacter"];
                } 
                
                else if ([productPurchased isEqualToString:@"LazerzDemon"]) {
                    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"demonPurchased"];
                    [[NSUserDefaults standardUserDefaults]setObject:@"demonCharacter" forKey:@"currentCharacter"];
                } 
                
                else if ([productPurchased isEqualToString:@"LazerzMonkey"]) {
                    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"monkeyPurchased"];
                    [[NSUserDefaults standardUserDefaults]setObject:@"monkeyCharacter" forKey:@"currentCharacter"];
                } 
                
                else if ([productPurchased isEqualToString:@"LazerzShark"]) {
                    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"sharkPurchased"];
                    [[NSUserDefaults standardUserDefaults]setObject:@"sharkCharacter" forKey:@"currentCharacter"];
                } 
                
                else if ([productPurchased isEqualToString:@"LazerzTroll"]) {
                    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"trollPurchased"];
                    [[NSUserDefaults standardUserDefaults]setObject:@"trollCharacter" forKey:@"currentCharacter"];
                }
                
                [self.theStore reloadData];
                
                break;
            }
                
            case SKPaymentTransactionStateFailed:
            {
                
                if(transaction.error.code != SKErrorPaymentCancelled)
                {
                    UIAlertView *paymenError = [[UIAlertView alloc]initWithTitle:@"Payment Error" message:@"Sorry but there was an issue with the transaction. Payment not processed." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
                    [paymenError show];
                }
                
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                
                break;
            }
        }
    }
    
}

@end
