//
//  CamVCViewController.m
//  TodayPhoto
//
//  Created by Daniel Goncalves on 2015-05-14.
//  Copyright (c) 2015 Daniel J Goncalves. All rights reserved.
//

#import "TodayPicVC.h"
#import <Parse/Parse.h>

@interface TodayPicVC ()

@end

@implementation TodayPicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Subviews & Styling
    self.view.backgroundColor = [UIColor lightGrayColor];
    UILabel *userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 320, 44)];
    [self.view addSubview:userNameLabel];
    UIImageView *profilePictureView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 200, 200, 200)];
    [self.view addSubview:profilePictureView];
    // Querying the Parse Cloud
    PFQuery *userQuery = [PFUser query];
    [userQuery selectKeys:@[@"fullname", @"profilePic"]];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *queryResults, NSError *error){
        if (!error) {
//            NSLog(@"%@", queryResults);
            
            // Fetch & assign full name to label
            NSString *fullname = [queryResults[0] objectForKey:@"fullname"];
            NSLog(@"%@", fullname);
            userNameLabel.text = fullname;
            
            // Fetch, convert & assign image
            NSURL *picURL = [NSURL URLWithString:[queryResults[0] objectForKey:@"profilePic"]];
            NSData *picData = [NSData dataWithContentsOfURL:picURL];
            profilePictureView.image = [UIImage imageWithData:picData];
            
        } else {
            NSLog(@"Error: %@", error.description);
        }
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
