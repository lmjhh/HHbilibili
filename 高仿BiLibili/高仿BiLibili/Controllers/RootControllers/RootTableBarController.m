//
//  RootTableBarController.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/1.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "RootTableBarController.h"
#import "BaseNavigationController.h"
#import "Home_DirectSeedingViewController.h"
#import "Home_RecommendViewController.h"
#import "Home_TheatreViewController.h"
#import "Home_PartitionViewController.h"
#import "Attention_RootViewController.h"
#import "Discovery_RootViewController.h"
#import "Mine_RootViewController.h"
#import "RKSwipeBetweenViewControllers.h"
#import "AppDelegate.h"

@interface RootTableBarController ()

@end

@implementation RootTableBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViewControllers];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Private_M

- (void)setupViewControllers{

    UIPageViewController *pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    //首页模块  直播、推荐、番剧、分区 Controller创建
    NSArray *childrenViewControllerTitle = @[@"直播",@"推荐",@"番剧",@"分区"];
    Home_DirectSeedingViewController *home_DirectSeeding = [[Home_DirectSeedingViewController alloc] init];
    Home_RecommendViewController *home_Recommend = [[Home_RecommendViewController alloc] init];
    Home_TheatreViewController *home_Theatre = [[Home_TheatreViewController alloc] init];
    Home_PartitionViewController *home_Partiting = [[Home_PartitionViewController alloc] init];
    
    RKSwipeBetweenViewControllers *nav_Home = [[RKSwipeBetweenViewControllers alloc]initWithRootViewController:pageController];
    
    nav_Home.buttonText = childrenViewControllerTitle;
    [nav_Home.viewControllerArray addObjectsFromArray:@[home_DirectSeeding,home_Recommend,home_Theatre,home_Partiting]];
    
    
    Attention_RootViewController *atten = [[Attention_RootViewController alloc] init];
    UINavigationController *nav_Atten = [[BaseNavigationController alloc] initWithRootViewController:atten];
    
    Discovery_RootViewController *disco = [[Discovery_RootViewController alloc] init];
    UINavigationController *nav_Disco = [[BaseNavigationController alloc] initWithRootViewController:disco];
    
    Mine_RootViewController *mine = [[Mine_RootViewController alloc] init];
    UINavigationController *nav_Mine = [[BaseNavigationController alloc] initWithRootViewController:mine];
    
    NSArray *itemArray = @[nav_Home,nav_Atten,nav_Disco,nav_Mine];
    
    [self setViewControllers:itemArray];
    [self customizeTabBarForController];
    
    
}

- (void)customizeTabBarForController{
    
    NSArray *tabbarItemTitles = @[@"首页",@"关注",@"发现",@"我的"];
    NSArray *tabbarItemImages = @[@"home_home",@"home_attention",@"home_discovery",@"home_mine"];
    
    NSInteger index = 0;
    for(UITabBarItem *item in [self.tabBar items]){

        [item setTitle:[tabbarItemTitles objectAtIndex:index]];
        UIImage *select = [UIImage imageNamed:[NSString stringWithFormat:@"%@_tab_s",[tabbarItemImages objectAtIndex:index]]];
        UIImage *unselect = [UIImage imageNamed:[NSString stringWithFormat:@"%@_tab",[tabbarItemImages objectAtIndex:index]]];
        [item setSelectedImage:select];
        [item setImage:unselect];
        index++;
        
    }
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BScreen_Width, 49)];
    backView.backgroundColor = [UIColor whiteColor];
    [self .tabBar insertSubview:backView atIndex:0];
    self.tabBarController.tabBar.opaque = YES;
    [self.tabBar setTintColor:BMainColor];
}


@end
