//
//  HomeViewController.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/1.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "Home_DirectSeedingViewController.h"
#import "HomeTableHeadView.h"
#import "Home_DirectTableViewCell.h"
#import "Live/Live_AllDirectController.h"

@interface Home_DirectSeedingViewController ()<UITableViewDelegate,UITableViewDataSource,HomeTableHeadViewDelegate,HomeCellDelegate>

@property (nonatomic,strong) HomeData *homeData;
@property (nonatomic,strong) HomeTableHeadView *tableHeadView;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation Home_DirectSeedingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildTableView];
    [self buildTableHeadView];
    [self loadDataFromNet];
    
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
    [_tableView registerNib:[UINib nibWithNibName:@"Home_DirectTableViewCell" bundle:nil] forCellReuseIdentifier:@"homeDirectCell"];
    
    [self.view addSubview:_tableView];
    
}

- (void) buildTableHeadView{
    
    CGFloat headViewHeight = BScreen_Width * 0.32 + 240;
    _tableHeadView = [[HomeTableHeadView alloc] initWithFrame:CGRectMake(0, 0, BScreen_Width, headViewHeight)];
    _tableHeadView.delegate = self;
    [_tableView setTableHeaderView:_tableHeadView];
    
    
}

- (void) loadDataFromNet{
    
    [[BiLi_NetAPIManager sharedManager] request_DirectSeedingDataWithBlock:^(id data, NSError *error) {
        _homeData = [[HomeData alloc] init];
        [HomeData mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"banner" : [Banner class],
                     @"entranceIcons" : [EntranceIcons class],
                     @"partitions" : [Partitions class]
                     };
        }];
        [Partitions mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"partition" : [Partition class],
                     @"lives" : [Lives class]
                     };
        }];
        _homeData = [HomeData mj_objectWithKeyValues:data];
        
        [_tableHeadView setHeadData:_homeData];
    }];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _homeData.partitions.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == _homeData.partitions.count){
        return 45;
    }
    
    CGFloat rowHeight = (((BScreen_Width - 10)/2)*0.63 + 49)*2 + 90;
    return  rowHeight;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == _homeData.partitions.count){
        
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        UIButton *allButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, BScreen_Width - 20, 35)];
        [[allButton layer] setMasksToBounds:YES];
        [[allButton layer] setCornerRadius:4];
        [[allButton layer] setBorderWidth:1];
        [[allButton layer] setBorderColor:[UIColor colorWithCustom:235 green:235 blue:235].CGColor];
        
        [allButton setTitle:@"全部直播" forState:UIControlStateNormal];
        [[allButton titleLabel] setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightUltraLight]];
        [allButton setBackgroundColor:[UIColor whiteColor]];
        [allButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [allButton addTarget:self action:@selector(allClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        [cell.contentView setBackgroundColor:BBackgroundColor];
        [_tableView setSeparatorColor:BBackgroundColor];
        [cell.contentView addSubview:allButton];
        return cell;
    }
    
    Home_DirectTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"homeDirectCell"];
    cell.delegate = self;
    [cell setData:_homeData.partitions[indexPath.section]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
    
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

- (void)tableHeadView:(HomeTableHeadView *)headView focusImageViewClick:(NSInteger)index{
    
    NSLog(@"我点击了%ld",(long)index);
    
}

- (void)tableHeadView:(HomeTableHeadView *)headView iconClick:(NSInteger)index{
    
    NSLog(@"我点击了%ld",(long)index);
}

- (void)tableHeadView:(HomeTableHeadView *)headView buttonClick:(HomeTabHeadViewButtonClickType)buttonClickType {
    
    switch (buttonClickType) {
        case HomeTabHeadViewButtonClickTypeFollow:
            NSLog(@"我点击了关注");
            break;
        case HomeTabHeadViewButtonClickTypeCenter:
            NSLog(@"我点击了中心");
            break;
        case HomeTabHeadViewButtonClickTypeSearch:
            NSLog(@"我点击了搜索");
            break;
    }
    
}

- (void)homeCellMoreClick:(Home_DirectTableViewCell *)cell{
    
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    Partitions *partitions = _homeData.partitions[indexPath.section];
    NSLog(@"我点击了%@的更多",partitions.partition.name);
    
}

- (void)homeCellContentClick:(Home_DirectTableViewCell *)cell index:(NSInteger)index{
    
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    Partitions *partitions = _homeData.partitions[indexPath.section];
    Lives *lives = partitions.lives[index];
    NSLog(@"我进入了%@的直播间",lives.owner.mid);
    
}

- (void)allClick{
    
    Live_AllDirectController *vc = [[Live_AllDirectController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
