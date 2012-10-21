//
//  StoreViewController.h
//  TabZ
//
//  Created by Hemant Bhonsle on 8/26/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface StoreViewController : UIViewController<SKProductsRequestDelegate,SKPaymentTransactionObserver>

@property(strong, nonatomic)IBOutlet UITableView *theStore;
@property(strong,nonatomic)IBOutlet UIActivityIndicatorView *loadingSpinner;

@end
