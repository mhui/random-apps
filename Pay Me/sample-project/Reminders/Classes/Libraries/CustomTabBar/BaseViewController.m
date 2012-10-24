//
//  BaseViewController.m
//  RaisedCenterTabBar
//
//  Created by Peter Boctor on 12/15/10.
//
// Copyright (c) 2011 Peter Boctor
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE
//

#import "BaseViewController.h"
#import "AppDelegate.h"

@implementation BaseViewController

// Create a view controller and setup it's tab bar item with a title and image
-(UIViewController*) viewControllerWithTabTitle:(NSString*) title image:(UIImage*)image
{
    UIViewController* viewController = [[UIViewController alloc] init];
    viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image tag:0];
    return viewController;
}

// Create a custom UIButton and add it to the center of our tab bar
-(void) addCenterButtonWithOptions:(NSDictionary *)options {
    UIImage *buttonImage = [UIImage imageNamed:options[@"buttonImage"]];
    UIImage *highlightImage = [UIImage imageNamed:options[@"highlightImage"]];
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    UITabBarItem *item = [self.tabBar.items objectAtIndex:2];
    item.enabled = NO;
    
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
    [button setContentMode:UIViewContentModeCenter];
    [button addTarget:self action:@selector(centerItemTapped) forControlEvents:UIControlEventTouchUpInside];
        
    CGPoint center = self.tabBar.center;
    center.y = center.y - 9.5;
    button.center = center;
        
    [self.view addSubview:button];
}

- (void)centerItemTapped {
    NSLog(@"okay1");
    NSMutableArray *listPeople = [[[NSUserDefaults standardUserDefaults]objectForKey:@"listPeople"]mutableCopy];
    NSLog(@"%i",[listPeople count]);
    NSMutableDictionary *testPerson = [[NSMutableDictionary alloc]init];
    [testPerson setValue:@"Person Name" forKey:@"personName"];
    [testPerson setValue:@"$" forKey:@"personPrice"];
    [testPerson setValue:@"Transaction Details" forKey:@"personDetail"];
    [testPerson setValue:@"Date and Time" forKey:@"personDate"];
    [listPeople addObject:testPerson];
    [[NSUserDefaults standardUserDefaults]setObject:listPeople forKey:@"listPeople"];
    NSLog(@"okay2");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonPressed" object:nil];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end