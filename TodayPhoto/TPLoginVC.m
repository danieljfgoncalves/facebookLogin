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
#import "TodayPicVC.h"

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
    
        if (!user) {
            NSLog(@"Uh oh. There was an error logging in.");
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Login Failed"
                                                                message:@"Please "
                                                               delegate:self
                                                      cancelButtonTitle:@"Please Try Again"
                                                      otherButtonTitles:nil];
            [alertView show];
            
        } else {
            NSLog(@"User logged in through Facebook!");
            
            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 if (!error) {
                     NSLog(@"fetched user:%@", result);
                     
                     user[@"fullname"] = result[@"name"];
                     [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                         if (succeeded) {
                             // The object has been saved.
                             NSLog(@"Saved to Parse.");
                         } else {
                             // There was a problem, check error.description
                             NSLog(@"%@", error.description);
                         }
                     }];
                     
                 }
             }];
            
            TodayPicVC *todayPicVC = [[TodayPicVC alloc]init];
            [self presentViewController:todayPicVC animated:YES completion:nil];
        }
        
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
