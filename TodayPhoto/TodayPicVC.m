//
//  CamVCViewController.m
//  TodayPhoto
//
//  Created by Daniel Goncalves on 2015-05-14.
//  Copyright (c) 2015 Daniel J Goncalves. All rights reserved.
//

#import "TodayPicVC.h"

@interface TodayPicVC ()

@end

@implementation TodayPicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *testLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 320, 44)];
    testLabel.text = @"testing";
    [self.view addSubview:testLabel];
    
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
