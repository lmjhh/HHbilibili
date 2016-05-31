//
//  Live_AllDirectController.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/12.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "Live_AllDirectController.h"
#import "Live_MostNewViewController.h"
#import "Live_MostPopularViewController.h"
#import "UIParameter.h"
#import "NinaPagerView.h"

@interface Live_AllDirectController ()<NinaPagerViewDelegate>

@end

@implementation Live_AllDirectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildNavigation];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)buildNavigation{
    self.title = @"全部直播";
    self.navigationController.navigationBar.translucent = NO;
    
    NSArray *titleArray =   @[@"最热",@"最新"];
    NSArray *vcsArray = @[
                          @"Live_MostPopularViewController",
                          @"Live_MostNewViewController",
                          ];
    
    NSArray *colorArray = @[
                            BMainColor, //< 选中的标题颜色
                            [UIColor grayColor], //< 未选中的标题颜色
                            BMainColor, //< 下划线颜色
                            [UIColor whiteColor], // 上方菜单栏的背景颜色
                            ];
    NinaPagerView *ninaPagerView = [[NinaPagerView alloc] initWithTitles:titleArray WithVCs:vcsArray WithColorArrays:colorArray];
    ninaPagerView.delegate = self;
    [self.view addSubview:ninaPagerView];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)deallocVCsIfUnnecessary {
    return YES;
}

@end
