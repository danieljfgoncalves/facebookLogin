//
//  ViewController.m
//  TodayPhoto
//
//  Created by Daniel Goncalves on 2015-05-13.
//  Copyright (c) 2015 Daniel J Goncalves. All rights reserved.
//

#import "TPLoginVC.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface TPLoginVC ()

@end

@implementation TPLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackground];
    
    // Facebook Login Button
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
//    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
