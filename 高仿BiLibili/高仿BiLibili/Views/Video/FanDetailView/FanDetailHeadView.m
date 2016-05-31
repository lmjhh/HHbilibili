//
//  FanDetailHeadView.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/18.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "FanDetailHeadView.h"

@interface FanDetailHeadView ()

@property (nonatomic,strong) FanData *data;
@property (nonatomic,strong) BPData *bpdata;
@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) UIImageView *backgroundImageView,*titleImageView;
@property (nonatomic,strong) UILabel *titleLabel,*updateLabel,*watchLabel,*viewControllerTitle;
@property (nonatomic,strong) UIVisualEffectView *blurView;
@property (nonatomic,strong) VideoInfoButtonView *shareButton,*chaseFanButton,*downLoadButton;
@property (nonatomic,strong) SelectSeasonsView *selectSeasonsView;
@property (nonatomic,strong) SelectVideoView *selectVideoView;
@property (nonatomic,strong) BPView *bpView;


@end

@implementation FanDetailHeadView


- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        
        
        [self buildImageView];
        [self buildLabel];
        [self buildVideoInfoButtonView];
        [self bulidSelectView];
        [self bulidSelectSeasonsView];
        [self buildBPView];
        
    }
    return  self;
}

- (void)setData:(FanData *)data isUpdateSeason:(BOOL)isUpdateSeason{
    
    _data = data;
    
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:_data.cover] ];
    
    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    if(self.blurView == nil){
        self.blurView = [[UIVisualEffectView alloc]initWithEffect:beffect];
        
        self.blurView.frame = CGRectMake(0, 0, BScreen_Width, BScreen_Width*0.47 + 1);
    }
    for(UIView *view in [self.backgroundImageView subviews]){
        [view removeFromSuperview];
    }
    [self.backgroundImageView addSubview:self.blurView];
    
    
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:_data.cover] placeholderImage:[UIImage imageNamed:@"default_img"]];
    [self.titleLabel setText:_data.title];
    
    NSArray *titleArray = [_data.episodes valueForKey:@"index"];
    
    if(_data.is_finish.integerValue<1){
        NSArray *week = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
        if([_data.weekday isEqualToString:@"-1"]){
            [self.updateLabel setText:@"连载中"];
        }else {
            [self.updateLabel setText:[NSString stringWithFormat:@"连载中，每周%@更新",week[_data.weekday.integerValue]]];
        }
        [self.selectVideoView setCountAndIsWatch:titleArray isWatch:nil isFinish:NO];
    }else {
        [self.updateLabel setText:@"已完结"];
        [self.selectVideoView setCountAndIsWatch:titleArray isWatch:[[NSArray alloc] init] isFinish:YES];
    }
    
    [_watchLabel setText:[NSString stringWithFormat:@"播放：%@ 订阅：%@",[_data.play_count calcCount],[_data.favorites calcCount]]];
    
    if(_data.seasons.count > 0 && isUpdateSeason){
        [self.selectSeasonsView setData:_data.seasons endTitle:_data.season_title endSeasonId:_data.season_id];
    }
    
    [self layoutSubviews];
    
}

- (void)setBpdata:(BPData *)bpdata count:(NSString * )count{
    
    _bpdata  = bpdata;
    [self.bpView setData:_bpdata count: count];
    [self layoutSubviews];
    
}

- (void)buildImageView{
    
    self.backgroundImageView = [[UIImageView alloc] init];
    self.backgroundImageView.userInteractionEnabled = NO;
    [self addSubview:self.backgroundImageView];
    
    self.titleImageView = [[UIImageView alloc] init];
    self.titleImageView.userInteractionEnabled = NO;
    [self.titleImageView.layer setMasksToBounds:YES];
    [self.titleImageView.layer setCornerRadius:5];
    self.titleImageView.layer.borderWidth = 2;
    self.titleImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    [self addSubview:self.titleImageView];
    
    
}

- (void)buildLabel{
    
    self.viewControllerTitle = [[UILabel alloc] init];
    [self.viewControllerTitle setTextColor:[UIColor whiteColor]];
    [self.viewControllerTitle setFont:[UIFont systemFontOfSize:17]];
    [ self.viewControllerTitle setTextAlignment:NSTextAlignmentCenter];
    [self.viewControllerTitle setText:@"番剧详情"];
    [self addSubview:self.viewControllerTitle];
    
    self.backButton = [[UIButton alloc] init];
    [self.backButton setImage:[[UIImage imageNamed:@"common_back_15x14"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    self.backButton.tintColor = [UIColor whiteColor];
    [self addSubview:self.backButton];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.userInteractionEnabled = NO;
    [self.titleLabel setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightUltraLight]];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:self.titleLabel];
    
    self.updateLabel = [[UILabel alloc] init];
    self.updateLabel.userInteractionEnabled = NO;
    [self.updateLabel setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightUltraLight]];
    [self.updateLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:self.updateLabel];
    
    _watchLabel = [[UILabel alloc] init];
    _watchLabel.userInteractionEnabled = NO;
    [_watchLabel setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightUltraLight]];
    [_watchLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:_watchLabel];
    
}

- (void)buildVideoInfoButtonView{
    
    self.shareButton = [[VideoInfoButtonView alloc] initWithFrameAndImageAndTitle:CGRectMake(100, 100, 100, 100) image:[UIImage imageNamed:@"iphonevideoinfo_share_22x22"] title:@"分 享" tintColor:[UIColor colorWithCustom:52 green:204 blue:130]];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleButtonClick:)];
    self.shareButton.tag = 100;
    [self.shareButton addGestureRecognizer:tap1];
    
    [self addSubview:self.shareButton];
    
    self.chaseFanButton = [[VideoInfoButtonView alloc] initWithFrameAndImageAndTitle:CGRectMake(100, 100, 100, 100) image:[UIImage imageNamed:@"videoinfo_followbangumi_23x21"] title:@"追 番" tintColor:[UIColor colorWithCustom:251 green:114 blue:153]];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleButtonClick:)];
    [self.chaseFanButton addGestureRecognizer:tap2];
     self.chaseFanButton.tag = 101;
    [self addSubview:self.chaseFanButton];
    
    self.downLoadButton = [[VideoInfoButtonView alloc] initWithFrameAndImageAndTitle:CGRectMake(100, 100, 100, 100) image:[UIImage imageNamed:@"iphonevideoinfo_dl_22x22"] title:@"缓 存" tintColor:[UIColor colorWithCustom:159 green:209 blue:250]];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleButtonClick:)];
    [self.downLoadButton addGestureRecognizer:tap3];
     self.downLoadButton.tag = 102;
    [self addSubview:self.downLoadButton];
    
}

- (void)bulidSelectView{
    
    self.selectVideoView = [[SelectVideoView alloc] initWithFrameAndClick:CGRectZero focusIconClick:^(NSInteger index) {
      
        [_delegate fanDetailSelectVideoClick:index];
        
    }];
    [self addSubview:self.selectVideoView];
    
}

- (void)bulidSelectSeasonsView{
    
    self.selectSeasonsView = [[SelectSeasonsView alloc] initWithFrameAndClick:CGRectZero focusIconClick:^(NSString * seasonId) {
        
        [_delegate fanDetailSelectSeasonClick:seasonId];
        
    }];
    [self addSubview:self.selectSeasonsView];
    
}

- (void)buildBPView{
    
    self.bpView = [[BPView alloc] init];
    
    [self addSubview:self.bpView];
    
}


- (void)titleButtonClick:(UIGestureRecognizer *)tap{
    
    switch (tap.view.tag) {
        case 100:
            [_delegate fanDetailTitleButtonClick:VideoInfoButtonViewTypeShare];
            break;
            
        case 101:
            [_delegate fanDetailTitleButtonClick:VideoInfoButtonViewTypeChaseFan];
            break;
            
        case 102:
            [_delegate fanDetailTitleButtonClick:VideoInfoButtonViewTypeDownLoad];
            break;
    }
    
}

- (void)backBtnClick{
    
    [_delegate backButtonClick];
    
}

- (void)layoutSubviews{
    
    CGFloat margin = (BScreen_Width*0.72 - 15 - 45 * 3)/4;
    NSInteger selectSeasonRow = _data.seasons.count > 0 ? 1 : 0;
    NSInteger selectRow = _data.episodes.count / 4;
    if(_data.episodes.count % 4 > 0){
        selectRow = _data.episodes.count / 4 + 1;
    }
    
    
    [self.viewControllerTitle mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(33);
        make.height.equalTo(@16);
        make.width.equalTo(@80);
        
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.viewControllerTitle);
        make.left.equalTo(@20);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
        
    }];
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(self.mas_width).multipliedBy(0.47);
        
    }];
    
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.backgroundImageView.mas_left).offset(15);
        make.bottom.equalTo(self.backgroundImageView.mas_bottom).offset(35);
        make.height.equalTo(self.backgroundImageView.mas_width).multipliedBy(0.37);
        make.width.equalTo(self.backgroundImageView.mas_width).multipliedBy(0.28);
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.titleImageView.mas_right).offset(10);
        make.top.equalTo(self.titleImageView.mas_top).offset(5);
        make.height.equalTo(@16);
        make.width.equalTo(self.backgroundImageView.mas_width).multipliedBy(0.5);
        
    }];
    
    [self.updateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.width.equalTo(self.titleLabel.mas_width);
        make.height.equalTo(self.titleLabel.mas_height);
        
    }];
    
    [_watchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.updateLabel.mas_bottom).offset(5);
        make.width.equalTo(self.titleLabel.mas_width);
        make.height.equalTo(self.titleLabel.mas_height);
        
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.centerY.equalTo(self.backgroundImageView.mas_bottom).offset(10);
        make.left.equalTo(self.titleImageView.mas_right).offset(margin);
        make.width.equalTo(@45);
        make.height.equalTo(@80);
        
    }];
    
    [self.chaseFanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.shareButton.mas_centerY);
        make.left.equalTo(self.shareButton.mas_right).offset(margin);
        make.width.equalTo(@45);
        make.height.equalTo(@80);
        
    }];
    
    [self.downLoadButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.shareButton.mas_centerY);
        make.left.equalTo(self.chaseFanButton.mas_right).offset(margin);
        make.width.equalTo(@45);
        make.height.equalTo(@80);
        
    }];
    
    self.selectSeasonsView.frame = CGRectMake(15, BScreen_Width*0.47 + 35 + 10, BScreen_Width - 30, selectSeasonRow * 45);
    
//    [self.selectSeasonsView mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.top.equalTo(self.titleImageView.mas_bottom).offset(10);
//        make.left.equalTo(self.titleImageView.mas_left);
//        make.width.mas_equalTo(BScreen_Width - 30);
//        make.height.mas_equalTo(selectSeasonRow * 45);
//        
//    }];
    
    self.selectVideoView.frame = CGRectMake(self.selectSeasonsView.frame.origin.x, CGRectGetMaxY(self.selectSeasonsView.frame) + 10, BScreen_Width - 30, selectRow * (40 + (BScreen_Width -350)/3) + (60 - (BScreen_Width -350)/3));
//    
//    [self.selectVideoView mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.top.equalTo(self.selectSeasonsView.mas_bottom).offset(10);
//        make.left.equalTo(self.titleImageView.mas_left);
//        make.width.mas_equalTo(BScreen_Width - 30);
//        make.height.mas_equalTo(selectRow * (40 + (BScreen_Width -350)/3) + (60 - (BScreen_Width -350)/3));
//        
//    }];
    
    if(_bpdata != nil) {
        self.bpView.hidden = false;
        self.bpView.frame = CGRectMake(self.selectSeasonsView.frame.origin.x, CGRectGetMaxY(self.selectVideoView.frame), self.selectVideoView.frame.size.width, 50);
    }else {
        self.bpView.hidden = true;
    }
    
}

@end
