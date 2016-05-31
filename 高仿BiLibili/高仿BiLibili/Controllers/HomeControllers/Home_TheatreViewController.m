//
//  Home_TheatreViewController.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/2.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "Home_TheatreViewController.h"
#import "VideoInfoViewController.h"
#import "BangumiNewFanCell.h"
#import "EndFanCell.h"
#import "BangumiHeadView.h"
#import "TheatreData.h"
#import "FanData.h"


@interface Home_TheatreViewController ()<UITableViewDelegate,UITableViewDataSource,BangumiHeadViewDelegate,HomeCellDelegate>

@property (nonatomic,strong) TheatreData *headData;
@property (nonatomic,strong) BangumiHeadView *tableHeadView;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation Home_TheatreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDataFromNetWork];
    [self buildTableView];
    [self buildTableHeadView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) buildTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BScreen_Width, self.view.frame.size.height - 113) style:UITableViewStyleGrouped];
    [_tableView setBackgroundColor:BBackgroundColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"BangumiNewFanCell" bundle:nil] forCellReuseIdentifier:@"BangumiNewFanCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"EndFanCell" bundle:nil] forCellReuseIdentifier:@"EndFanCell"];
    [self.view addSubview:_tableView];
    
}

- (void) buildTableHeadView{
    
    CGFloat headViewHeight = BScreen_Width * 0.32 + 164;
    _tableHeadView = [[BangumiHeadView alloc] initWithFrame:CGRectMake(0, 0, BScreen_Width, headViewHeight)];
    _tableHeadView.delegate = self;
    [_tableView setTableHeaderView:_tableHeadView];
    
    
}

- (void)loadDataFromNetWork{
    
    [[BiLi_NetAPIManager sharedManager] request_TheatreBannerDataAndNewTheatreWithBlock:^(id data, NSError *error) {
        
       [TheatreData mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"banners" : [Banner class],
                     @"ends" : [List class],
                     };
        }];
        
        [LatestUpdate mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : [List class],
                     };
        }];
        
        _headData = [TheatreData mj_objectWithKeyValues:data];
        [_tableHeadView setHeadData:_headData];
        [_tableView reloadData];
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat rowHeight = 0;
    
    if(indexPath.section == 0){
        rowHeight = (((BScreen_Width - 10)/2)*0.63 + 49)*3 + 40;
    }else if(indexPath.section == 1){
        rowHeight = ((BScreen_Width)/3 + 5)* 1.31 + 49 + 50;
    }
    return rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        BangumiNewFanCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"BangumiNewFanCell"];
        cell.delegate = self;
        [cell setData:_headData.latestUpdate];
        return cell;
    }else if(indexPath.section == 1){
        EndFanCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"EndFanCell"];
        cell.delegate = self;
        [cell setData:_headData.ends];
        return cell;
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
        return 0;
    }
    
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 6;
}

// MARK: - 点击事件

-(void)tableHeadView:(BangumiHeadView *)headView focusImageViewClick: (NSInteger) index{
    
    NSLog(@"我点击了%ld",(long)index);
    
}

-(void)tableHeadView:(BangumiHeadView *)headView iconClick: (NSInteger) index{
    
    NSLog(@"我点击了%ld",(long)index);
}

-(void)tableHeadView:(BangumiHeadView *)headView buttonClick: (BangumiHeadViewButtonClickType) buttonClickType{
    
    switch (buttonClickType) {
        case BangumiHeadViewButtonClickTypeFanchase:
            NSLog(@"我点击了追番");
            break;
        case BangumiHeadViewButtonClickTypeServingtable:
            NSLog(@"我点击了放送表");
            break;
        case BangumiHeadViewButtonClickTypeIndex:
            NSLog(@"我点击了索引");
            break;
    }
    
}

- (void)homeCellMoreClick:(UITableViewCell *)cell{
    
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    NSLog(@"我点击了更多");
    
}

- (void)homeCellContentClick:(UITableViewCell *)cell index:(NSInteger)index{

    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    if(indexPath.section == 1){
        List *list = _headData.ends[index];
        VideoInfoViewController *vc = [[VideoInfoViewController alloc] init];
        vc.seasonId = list.season_id;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(indexPath.section == 0){
        List *list = _headData.latestUpdate.list[index];
            
        VideoInfoViewController *vc = [[VideoInfoViewController alloc] init];
        vc.seasonId = list.season_id;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


@end
