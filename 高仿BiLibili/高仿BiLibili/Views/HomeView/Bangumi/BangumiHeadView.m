//
//  BangumiHeadView.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/16.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "BangumiHeadView.h"
#import "BiLiPageScrollView.h"
#import "BiLiHotView.h"

@interface BangumiHeadView ()

@property (nonatomic,strong) BiLiPageScrollView *pageScrllView;
@property (nonatomic,strong) BiLiHotView *hotView;
@property (nonatomic,strong) DoubleImageViewButton *followButton,*centerButton,*searchButton;
@property (nonatomic,strong) UIView *entranceView;

@end

@implementation BangumiHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self buildPageScrollView];
        [self buildHotView];
        [self buildEntranceView];
    }
    return  self;
}

- (void) buildPageScrollView{
    
    [self setBackgroundColor:BBackgroundColor];
    
    _pageScrllView = [[BiLiPageScrollView alloc] initWithFrameAndConfig:CGRectZero placheholder:[UIImage imageNamed:@"videopic_default"] focusImageViewClick:^(NSInteger index) {
        [_delegate tableHeadView:self focusImageViewClick:index];
    }];
    [self addSubview:_pageScrllView];
}

- (void) buildHotView{
    _hotView = [[BiLiHotView alloc] initWithFrameAndClick:CGRectZero focusIconClick:^(NSInteger index) {
        [_delegate tableHeadView:self iconClick:index];
    }];
    [self addSubview:_hotView];
}


- (void) buildEntranceView{
    
    CGFloat buttonH = 50;
    CGFloat buttonW = (BScreen_Width-46)/3;
    
    _entranceView = [[UIView alloc] init];
    
    _followButton = [[DoubleImageViewButton alloc] initWithFrame:CGRectMake(13, 10, buttonW, buttonH)];
    _followButton.imageView.image = [UIImage imageNamed:@"home_bangumi_tableHead_followIcon_47x44"];
    _followButton.textImageView.image = [UIImage imageNamed:@"home_bangumi_tableHead_followStr_36x16"];
    _followButton.backgroundColor = [UIColor colorWithCustom:255 green:180 blue:0];
    _followButton.tag = 1;
    [_followButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_entranceView addSubview:_followButton];
    
    _centerButton = [[DoubleImageViewButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_followButton.frame) + 10, _followButton.frame.origin.y, buttonW, buttonH)];
    _centerButton.imageView.image = [UIImage imageNamed:@"home_bangumi_tableHead_week2_47x44"];
    _centerButton.textImageView.image = [UIImage imageNamed:@"home_bangumi_tableHead_timeList_47x16_"];
    _centerButton.isWidth = YES;
    _centerButton.backgroundColor = [UIColor colorWithCustom:255 green:111 blue:111];
    _centerButton.tag = 2;
    [_centerButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_entranceView addSubview:_centerButton];
    
    _searchButton = [[DoubleImageViewButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_centerButton.frame) + 10, _centerButton.frame.origin.y, buttonW, buttonH)];
    _searchButton.imageView.image = [UIImage imageNamed:@"home_bangumi_tableHead_indexIcon_47x44"];
    _searchButton.textImageView.image = [UIImage imageNamed:@"home_bangumi_tableHead_indexStr_35x15"];
    _searchButton.backgroundColor = [UIColor colorWithCustom:94 green:190 blue:255];
    _searchButton.tag = 3;
    [_searchButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_entranceView addSubview:_searchButton];
    
    [self addSubview:_entranceView];
    
    
}

- (void) layoutSubviews{
    
    _pageScrllView.frame = CGRectMake(0, 0, BScreen_Width, BScreen_Width * 0.32);
    CGRect hotViewPoint = _hotView.frame;
    hotViewPoint.origin.x = 0;
    hotViewPoint.origin.y = CGRectGetMaxY(_pageScrllView.frame) + 10;
    _hotView.frame = hotViewPoint;
    _entranceView.frame = CGRectMake(0, CGRectGetMaxY(_hotView.frame), BScreen_Width, 60);
    
    CGRect selfViewHeight = self.frame;
    selfViewHeight.size.height = CGRectGetMaxY(_entranceView.frame);
    self.frame = selfViewHeight;
    
}

- (void)setHeadData:(TheatreData *)headData{
    
    _headData = headData;
    NSArray *title = [_headData.banners valueForKey:@"img"];
    [_pageScrllView setData:title];
    NSArray *name = @[@"连载动画",@"完结动画",@"国产动画",@"官方延伸"];
    NSArray *imgs = @[@"hd_home_region_icon_33_60x60",
                    @"hd_home_region_icon_32_60x60",
                    @"hd_home_region_icon_153_60x60",
                    @"hd_home_region_icon_152_60x60"];
    [_hotView setTitileAndIconWithPath:name iconArray:imgs];
    
}

// MARK : - Action

- (void)buttonClick:(UIButton *) button{
    
    if(button.tag == 1){
        [_delegate tableHeadView:self buttonClick: BangumiHeadViewButtonClickTypeFanchase];
    }else if (button.tag == 2){
        [_delegate tableHeadView:self buttonClick: BangumiHeadViewButtonClickTypeServingtable];
    }else {
        [_delegate tableHeadView:self buttonClick: BangumiHeadViewButtonClickTypeIndex];
    }
    
}

@end


@implementation DoubleImageViewButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        _textImageView = [[UIImageView alloc] init];
        [self addSubview:_textImageView];
        _isWidth = false;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        
    }
    return  self;
}

- (void)layoutSubviews{
    
    self.imageView.frame = CGRectMake(10, 5, 45, 40);
    self.textImageView.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame), 17, 36, 16);
    if(_isWidth){
        self.textImageView.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame), 17, 45, 16);
    }
    
}

@end

