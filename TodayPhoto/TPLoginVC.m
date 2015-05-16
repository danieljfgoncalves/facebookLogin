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
#import "TestVC.h"

@interface TPLoginVC () <FBSDKLoginButtonDelegate>

@end

@implementation TPLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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
                                                                message:@"Please login Again."
                                                               delegate:self
                                                      cancelButtonTitle:@"Please Try Again"
                                                      otherButtonTitles:nil];
            [alertView show];
            
        } else {
            NSLog(@"User logged in through Facebook!");
            
            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me?fields=id,name,picture.height(400)" parameters:nil]
             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 if (!error) {
//                     NSLog(@"fetched user:%@", result);
                     
                     // Retrieve wanted Facebook Data to Parse Cloud
                        // Users Full Name
                     user[@"fullname"] = result[@"name"];
                     
                        // Profile Picture
                     NSDictionary *resultPicture = result[@"picture"];
                     NSDictionary *resultPicData = resultPicture[@"data"];
                     NSURL *resultPicDataUrl = resultPicData[@"url"];
                     user[@"profilePic"] = resultPicDataUrl;
                     
                     [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                         if (succeeded) {
                             // The object has been saved.
                             NSLog(@"Saved to Parse.");
                             
                             // Present next View Controller
                             TestVC *todayPicVC = [[TestVC alloc]init];
                             [self presentViewController:todayPicVC animated:YES completion:nil];
                             
                         } else {
                             // There was a problem, check error.
                             NSLog(@"%@", error.description);
                         }
                     }];
                     
                 }
             }];
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
