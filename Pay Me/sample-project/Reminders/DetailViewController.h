//
//  DetailViewController.h
//  plistproj
//
//  Created by Hemant Bhonsle on 4/29/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
