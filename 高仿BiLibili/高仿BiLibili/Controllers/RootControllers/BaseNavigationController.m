//
//  BaseNavigationController.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/1.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@property (nonatomic,strong) UIButton *backButton;

@end


@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBar setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:@"navigationbar_background"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self interactivePopGestureRecognizer].delegate = nil;
    
    
    
}

- (UIButton *)setBackButton{
    if(!_backButton){
        
        _backButton = [[UIButton alloc] init];
        [_backButton setImage:[UIImage imageNamed:@"common_back_15x14"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        _backButton.frame = CGRectMake(0, 0, 40, 40);
    
        
    }
    
    return _backButton;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    viewController.navigationItem.hidesBackButton = YES;
    if([self childViewControllers].count > 0){
        
        [UINavigationBar appearance].backItem.hidesBackButton = NO;
        viewController.hidesBottomBarWhenPushed = YES;
        
        
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self setBackButton]];
        
    }
    [super pushViewController:viewController animated:animated];
    
}

- (void)backBtnClick{
    
    [self popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
