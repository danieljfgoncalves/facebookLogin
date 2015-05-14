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
#include <ParseFacebookUtilsV4/PFFacebookUtils.h>

@interface TPLoginVC () <FBSDKLoginButtonDelegate>

@end

@implementation TPLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Test PFObject
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackground];
    
    // Facebook Login Button
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc]init];
    loginButton.delegate = self;
    [self.view addSubview:loginButton];
    // Set Button Position
    loginButton.center = CGPointMake(self.view.center.x, 400.0f);
    
}


- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error
{
    [PFFacebookUtils logInInBackgroundWithAccessToken:result.token block:^(PFUser *user, NSError *error){
    
        
        
    }];
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
