//
//  VideoInfoViewController.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/18.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "VideoInfoViewController.h"
#import "FanDetailHeadView.h"
#import "VideoPlayViewController.h"

@interface VideoInfoViewController ()<FanDetailDelegate>

@property (nonatomic,strong) FanData *headData;
@property (nonatomic,strong) BPData *bpData;
@property (nonatomic,strong) FanDetailHeadView *headView;

@end

@implementation VideoInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataFromNet:self.seasonId isUpdate:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)buildTableHeadView{
    
    [self.view addSubview:({
        
          FanDetailHeadView *HeadView = [[FanDetailHeadView alloc] init];
          HeadView.delegate = self;
          NSInteger selectSeasonRow = _headData.seasons.count > 0 ? 1 : 0;
          NSInteger selectRow = _headData.episodes.count / 4;
          if(_headData.episodes.count % 4 > 0){
              selectRow = _headData.episodes.count / 4 + 1;
          }
        NSInteger isAllowBP = [_headData.allow_bp isEqualToString:@"0"] ? 0:50;
          CGFloat tableHeadViewHeight = BScreen_Width*0.47 + 35 +  selectSeasonRow * 45 + selectRow * (40 + (BScreen_Width -350)/3) + (60 - (BScreen_Width -350)/3) + 20 + isAllowBP;
          HeadView.frame = CGRectMake(0, 0, BScreen_Width, tableHeadViewHeight);
        
          HeadView;
        
    })];
    
    
}


- (void)loadDataFromNet: (NSString *)seasonId isUpdate:(BOOL)isUpdate{
    
    [FanData mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"episodes" : [Episode class],
                 @"tags" : [Tag class],
                 @"seasons" : [Seasons class]
                 };
    }];
    
    [BPData mj_setupObjectClassInArray:^NSDictionary *{
       
        return @{
                 @"list": @"list.list"
                 };
        
    }];
    
    [[BiLi_NetAPIManager sharedManager] request_TheatreDetailDataWithBlock:self.seasonId block:^(id data, NSError *error) {
        
        FanData *fandata = [FanData mj_objectWithKeyValues:data];
        
        _headData = fandata;
        
        if(![fandata.allow_bp  isEqual: @"0"]){
            
            Episode *epi = fandata.episodes.lastObject;
            NSString *bpCount = epi.index;
            NSString *av_id = epi.av_id;
            
            if(fandata.is_finish.integerValue<1){
                
                epi = fandata.episodes.firstObject;
                av_id = epi.av_id;
            }
            
            
            [[BiLi_NetAPIManager sharedManager] request_VideoBPDataWithBlock:av_id block:^(id data, NSError *error) {
                
                BPData *Data = [BPData mj_objectWithKeyValues:data];
                self.bpData = Data;
                [self buildTableHeadView];
                [self.headView setBpdata:self.bpData count:bpCount];
                
            }];
            
        }
        [self buildTableHeadView];
        [_headView setData:_headData isUpdateSeason:YES];
        
    }];
}


- (void)backButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)fanDetailTitleButtonClick:(VideoInfoButtonViewType)type{
    
    switch (type) {
        case VideoInfoButtonViewTypeShare:
            NSLog(@"我点击了分享");
            break;
        case VideoInfoButtonViewTypeChaseFan:
            NSLog(@"我点击了追番");
            break;
            
        case VideoInfoButtonViewTypeDownLoad:
            NSLog(@"我点击了缓存");
            break;
    }
    
}

- (void)fanDetailSelectSeasonClick:(NSString *)seasonId{
    
    [self loadDataFromNet:seasonId isUpdate:NO];
    
}

- (void)fanDetailSelectVideoClick:(NSInteger)index{
    
    Episode *ep = _headData.episodes[index];
    [[BiLi_NetAPIManager sharedManager] request_VideoBPDataWithBlock:ep.av_id block:^(id data, NSError *error) {
        
        BPData *Data = [BPData mj_objectWithKeyValues:data];
        self.bpData = Data;
        [self.headView setBpdata:self.bpData count:ep.index];
        
    }];
    [self presentViewController:[[VideoPlayViewController alloc] initWithAid:ep.av_id] animated:YES completion:nil];
    
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
