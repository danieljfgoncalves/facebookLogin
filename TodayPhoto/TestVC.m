//
//  CamVCViewController.m
//  TodayPhoto
//
//  Created by Daniel Goncalves on 2015-05-14.
//  Copyright (c) 2015 Daniel J Goncalves. All rights reserved.
//

#import "TestVC.h"
#import <Parse/Parse.h>

@interface TestVC ()

@end

@implementation TestVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.view.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Instanciate the Image Picker (Camera)
//    self.imagePicker = [[UIImagePickerController alloc]init];
//    self.imagePicker.delegate = self;
//    self.imagePicker.allowsEditing = NO;
//        // Callback for Devices without Camera
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    } else {
//        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }
//    self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
//    [self presentViewController:self.imagePicker animated:NO completion:nil];
    
    // Subviews & Styling
    UILabel *userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 320, 44)];
    [self.view addSubview:userNameLabel];
    UIImageView *profilePictureView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 200, 200, 200)];
    [self.view addSubview:profilePictureView];
    UIImageView *capturedImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 450, 200, 200)];
    capturedImageView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:capturedImageView];
    
    // Querying the Parse Cloud
    PFQuery *userQuery = [PFUser query];
    [userQuery selectKeys:@[@"fullname", @"profilePic", @"todaysPic"]];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *queryResults, NSError *error){
        if (!error) {
//            NSLog(@"%@", queryResults);
            
            // Fetch & assign full name to label
            NSString *fullname = [queryResults[0] objectForKey:@"fullname"];
            NSLog(@"%@", fullname);
            userNameLabel.text = fullname;
            
            // Fetch, convert & assign images
                // URL with profile Image
            NSURL *picURL = [NSURL URLWithString:[queryResults[0] objectForKey:@"profilePic"]];
            NSData *picData = [NSData dataWithContentsOfURL:picURL];
            profilePictureView.image = [UIImage imageWithData:picData];
                // PFFile with captured Image
            PFFile *fetchedCapPic = [queryResults[0] objectForKey:@"todaysPic"];
            NSData *capPicData = [fetchedCapPic getData];
            capturedImageView.image = [UIImage imageWithData:capPicData];
            
        } else {
            NSLog(@"Error: %@", error.description);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
