//
//  分区  分区  Home_PartitionViewController.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/2.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "Home_PartitionViewController.h"

@interface Home_PartitionViewController ()

@end

@implementation Home_PartitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 30)];
    l.text = @"Home_PartitionViewController";
    [self.view addSubview:l];
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
