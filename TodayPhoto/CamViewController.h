//
//  CamViewController.h
//  TodayPhoto
//
//  Created by Daniel Goncalves on 2015-05-16.
//  Copyright (c) 2015 Daniel J Goncalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestVC.h"

@interface CamViewController : UIImagePickerController

@property (strong, nonatomic)UIImage *capturedImage;
@property (strong, nonatomic)TestVC *testVC;

@end
