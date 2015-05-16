//
//  CamViewController.m
//  TodayPhoto
//
//  Created by Daniel Goncalves on 2015-05-16.
//  Copyright (c) 2015 Daniel J Goncalves. All rights reserved.
//

#import "CamViewController.h"

@interface CamViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation CamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.allowsEditing = NO;
    self.delegate =self;
    // Callback for Devices without Camera
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    self.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.sourceType];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ImagePicker

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
//    NSLog(@"%@", info);
    self.capturedImage = info[@"UIImagePickerControllerOriginalImage"];
    NSLog(@"%@", self.capturedImage);
    self.testVC = [[TestVC alloc]init];
    self.testVC.capturedImage = self.capturedImage;
    [self presentViewController:self.testVC animated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    self.testVC = [[TestVC alloc]init];
    [self presentViewController:self.testVC animated:YES completion:nil];
}

@end
