//
//  VideoInfoViewController.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/18.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "VideoInfoViewController.h"
#import "FanDetailHeadView.h"
#import "CommonModel.h"
#import "VideoPlayViewController.h"
#import "CommonsTableViewCell.h"
#import "YYFPSLabel.h"

#define pagesize @20
#define page @1

@interface VideoInfoViewController ()<FanDetailDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) FanData *headData;
@property (nonatomic,strong) CommonModel *commonData;
@property (nonatomic,strong) BPData *bpData;
@property (nonatomic,strong) FanDetailHeadView *headView;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation VideoInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layoutHeadView:) name:@"layoutHeadView" object:nil];
    self.isPresentView = false;
    
    [self navigationBarSet];
    [self buildTableHeadView];
    [self buildTableView];
    [self loadDataFromNet:self.seasonId isUpdate:YES];

}

- (void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews{
    
    
    
    [super viewDidLayoutSubviews];
    self.view.frame = CGRectMake(0, 0, BScreen_Width, BScreen_Height);
    
    self.navigationController.navigationBar.alpha = 1 - (64 - self.tableView.contentOffset.y)/64;
    if(self.navigationController.navigationBar.alpha >= 1){
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }
    
    self.tableView.tableHeaderView = self.headView;
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    self.navigationController.navigationBar.alpha = 1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navigationBarSet{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.title = @"番剧详情";
    
}


- (void)buildTableHeadView{
    
        
    self.headView = [[FanDetailHeadView alloc] initWithFrame:CGRectZero];
    self.headView.delegate = self;
    
    
    
}

- (void)buildTableView{
    
    self.view.frame = CGRectMake(0, 0, BScreen_Width, BScreen_Height);
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.bounces = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"CommonsTableViewCell" bundle:nil]forCellReuseIdentifier:@"commonCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.headView;
    self.tableView.backgroundColor = BBackgroundColor;
    [self.tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars=NO;
    
    [self.view addSubview:self.tableView];
    
}

- (void)layoutHeadView:(NSNotification*) aNotification{
    
    NSDictionary *heigh = aNotification.userInfo;
    
    NSString *tableHeadViewHeight = [heigh valueForKey:@"height"];
    
    self.headView.frame = CGRectMake(0, 0, BScreen_Width, [tableHeadViewHeight doubleValue]);
    if(!self.isPresentView){
        self.tableView.tableHeaderView = self.headView;
    }
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
        
        self.headData = fandata;
        
        Episode *epi = fandata.episodes.lastObject;
        NSString *bpCount = epi.index;
        NSString *av_id = epi.av_id;
        
        if(fandata.is_finish.integerValue<1){
            
            epi = fandata.episodes.firstObject;
            av_id = epi.av_id;
        }
        
        [_headView setData:_headData isUpdateSeason:isUpdate];
        
        if(![fandata.allow_bp  isEqual: @"0"]){
            
            [[BiLi_NetAPIManager sharedManager] request_VideoBPDataWithBlock:av_id block:^(id data, NSError *error) {
                
                BPData *Data = [BPData mj_objectWithKeyValues:data];
                self.bpData = Data;
                [self.headView setBpdata:self.bpData count:bpCount];
                
            }];
            
        }
        
        [[BiLi_NetAPIManager sharedManager] request_VideoCommonDataWithBlock:@{@"pagesize":pagesize.stringValue, @"page":page.stringValue, @"aid": av_id} block:^(id data, NSError *error) {
            
            CommonModel *comm = [CommonModel mj_objectWithKeyValues:data];
            
            self.commonData = comm;
            [self.tableView reloadData];
            
        }];
        
        
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
    if(![self.headData.allow_bp  isEqual: @"0"]){
        
        [[BiLi_NetAPIManager sharedManager] request_VideoBPDataWithBlock:ep.av_id block:^(id data, NSError *error) {
            
            BPData *Data = [BPData mj_objectWithKeyValues:data];
            self.bpData = Data;
            [self.headView setBpdata:self.bpData count:ep.index];
            
        }];
        
    }
    self.isPresentView = true;
    [self presentViewController:[[VideoPlayViewController alloc] initWithAid:ep.av_id] animated:YES completion:nil];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.commonData.hotList.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReplyDataModel *reModel = self.commonData.hotList[indexPath.row];
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:12]};
    CGSize retSize = [reModel.msg boundingRectWithSize:CGSizeMake(BScreen_Width - 68, 0)
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
                             return retSize.height + 65;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CommonsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"commonCell"];
    [cell setData:self.commonData.hotList[indexPath.row]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.navigationController.navigationBar.alpha = 1 - (64 - scrollView.contentOffset.y)/64;
    if(self.navigationController.navigationBar.alpha >= 1){
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }
    
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
