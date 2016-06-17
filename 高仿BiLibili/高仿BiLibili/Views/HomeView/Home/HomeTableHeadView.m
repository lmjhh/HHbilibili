//
//  HomeTableHeadView.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/6.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "HomeTableHeadView.h"
#import "BiLiPageScrollView.h"
#import "BiLiHotView.h"

@interface HomeTableHeadView ()

@property (nonatomic,strong) BiLiPageScrollView *pageScrllView;
@property (nonatomic,strong) BiLiHotView *hotView;
@property (nonatomic,strong) UIButton *followButton,*centerButton,*searchButton;
@property (nonatomic,strong) UIView *entranceView;


@end



@implementation HomeTableHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
    
    CGFloat buttonH = 40;
    CGFloat buttonW = (BScreen_Width-46)/3;
    
    _entranceView = [[UIView alloc] init];
    
    _followButton = [[UIButton alloc] initWithFrame:CGRectMake(13, 10, buttonW, buttonH)];
    [_followButton setImage:[UIImage imageNamed:@"live_entranceFollow_110x40_"] forState:UIControlStateNormal];
    _followButton.tag = 1;
    [_followButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_entranceView addSubview:_followButton];
    
    _centerButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_followButton.frame) + 10, _followButton.frame.origin.y, buttonW, buttonH)];
    [_centerButton setImage:[UIImage imageNamed:@"live_entranceCenter_110x40_"] forState:UIControlStateNormal];
    _centerButton.tag = 2;
    [_centerButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_entranceView addSubview:_centerButton];
    
    _searchButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_centerButton.frame) + 10, _centerButton.frame.origin.y, buttonW, buttonH)];
    [_searchButton setImage:[UIImage imageNamed:@"live_entranceSearch_110x40_"] forState:UIControlStateNormal];
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

- (void)setHeadData:(HomeData *)headData{
    
    _headData = headData;
    NSArray *title = [_headData.banner valueForKey:@"img"];
    [_pageScrllView setData:title];
    NSArray *name = [_headData.entranceIcons valueForKey:@"name"];
    NSMutableArray *imgs = [[NSMutableArray alloc] init];
    for(int i=0;i<_headData.entranceIcons.count;i++){
        EntranceIcons *item = headData.entranceIcons[i];
        Entrance_icon *it = item.entrance_icon;
        NSString *iconURL = it.src;
        [imgs addObject:iconURL];
    }
    [_hotView setTitileAndIcon:name iconArray:imgs];

}

// MARK : - Action

- (void)buttonClick:(UIButton *) button{
    
    if(button.tag == 1){
        [_delegate tableHeadView:self buttonClick: HomeTabHeadViewButtonClickTypeFollow];
    }else if (button.tag == 2){
        [_delegate tableHeadView:self buttonClick: HomeTabHeadViewButtonClickTypeCenter];
    }else {
        [_delegate tableHeadView:self buttonClick: HomeTabHeadViewButtonClickTypeSearch];
    }
    
}

@end


