//
//  SelectSeasonsView.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/19.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "SelectSeasonsView.h"

@interface SelectSeasonsView ()

@property (nonatomic,assign) NSInteger clickTag;
@property (nonatomic,strong) NSArray *data;
@property (nonatomic,copy) void (^iconClick)(NSString * seasonId);
@property (nonatomic,strong) NSString *endSeasonId;
@property (nonatomic,strong) UIScrollView *backScrollView;

@end

@implementation SelectSeasonsView

- (instancetype)initWithFrameAndClick:(CGRect)frame focusIconClick:(void (^)(NSString * seasonId))focusIconClick{
    
    if(self = [super initWithFrame:frame]){
        
        _iconClick = focusIconClick;
        _backScrollView = [[UIScrollView alloc] init];
        _backScrollView.showsHorizontalScrollIndicator = NO;
        _backScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_backScrollView];
        [self setBackgroundColor:BBackgroundColor];
        
    }
    return self;
    
    
}

- (void)setData:(NSArray *)data endTitle:(NSString *)endTitle endSeasonId:(NSString *)endSeasonId {
    _data = data;
    _endSeasonId = endSeasonId;
    [self buildSeasonsSelectView:endTitle];
    
}

- (void)buildSeasonsSelectView:(NSString *)endTitle{
    
    
    CGFloat iconH = 40,iconW = 80,iconX = 0,iconY = 0;
    CGFloat margin = 5;
    NSString *buttontext;
    
    for(int i=1; i<=_data.count + 1; i++){
        
        //计算文本宽度
        if(i <= _data.count){
            Seasons *season = _data[i-1];
            buttontext = season.title;
            CGSize sizeName = [buttontext sizeWithFont:[UIFont systemFontOfSize:15 weight:UIFontWeightUltraLight]constrainedToSize:CGSizeMake(MAXFLOAT, 0.0) lineBreakMode:NSLineBreakByWordWrapping];
            if (sizeName.width + 40 >80){
                iconW = sizeName.width + 40;
            }
        }
        else {
            buttontext = endTitle;
            CGSize sizeName = [buttontext sizeWithFont:[UIFont systemFontOfSize:15 weight:UIFontWeightUltraLight]constrainedToSize:CGSizeMake(MAXFLOAT, 0.0) lineBreakMode:NSLineBreakByWordWrapping];
            if (sizeName.width + 40 >80){
                iconW = sizeName.width + 40;
            }
        }
        
        iconX = ((i-1)) * iconW + ((i-1)) * margin;
        iconY = margin;
        UIButton *icon = [[UIButton alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
        [icon addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [icon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [icon.titleLabel setFont:[UIFont systemFontOfSize:15 weight:UIFontWeightUltraLight]];
        [icon setBackgroundColor:BBackgroundColor];
        
        if(i == 1){
            
        //解决图片拉伸问题 创建一个内容可拉伸，而边角不拉伸的图片，需要两个参数，第一个是不拉伸区域和左边框的宽度，第二个参数是不拉伸区域和上边框的宽度。
            UIImage * buttonBg = [[UIImage imageNamed:@"season_seasonLeft_85x41"]stretchableImageWithLeftCapWidth:20 topCapHeight:0];
            [icon setBackgroundImage:buttonBg forState:UIControlStateNormal];
            [icon setTitle:buttontext forState:UIControlStateNormal];
        }else if(i<=_data.count){
            UIImage * buttonBg = [[UIImage imageNamed:@"season_seasonMiddle_85x41"]stretchableImageWithLeftCapWidth:20 topCapHeight:0];
            [icon setBackgroundImage:buttonBg forState:UIControlStateNormal];
            [icon setTitle:buttontext forState:UIControlStateNormal];
        }else {
            _clickTag = i;
            UIImage * buttonBg = [[UIImage imageNamed:@"season_seasonRight_s_85x41"]stretchableImageWithLeftCapWidth:20 topCapHeight:0];
            [icon setBackgroundImage:buttonBg forState:UIControlStateNormal];
            [icon setTitleColor:BMainColor forState:UIControlStateNormal];
            [icon setTitle:buttontext forState:UIControlStateNormal];
        }
        icon.tag = i;
        [self.backScrollView addSubview:icon];
        
    }
    
    [_backScrollView setFrame:CGRectMake(0, 0, BScreen_Width - 15, 45)];
    [_backScrollView setContentSize:CGSizeMake((iconW + margin) * (_data.count + 1) + 10, self.backScrollView.frame.size.height)];
    if((iconW + margin) * (_data.count + 1) + 10 > (BScreen_Width - 15)){
        CGPoint point = CGPointMake((iconW + margin) * (_data.count + 1) + 10 - BScreen_Width + 15, 0);
        [self.backScrollView setContentOffset:point animated:YES];
    }
    
}

- (void)buttonClick:(UIButton *)btn{
    
    
    if(btn.tag != _clickTag){
        UIButton *unselectButton = [self.backScrollView viewWithTag:_clickTag];
        if(_clickTag == 1){
            UIImage * buttonBg = [[UIImage imageNamed:@"season_seasonLeft_85x41"]stretchableImageWithLeftCapWidth:20 topCapHeight:0];
            [unselectButton setBackgroundImage:buttonBg forState:UIControlStateNormal];
            [unselectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }else if(_clickTag<=_data.count){
            UIImage * buttonBg = [[UIImage imageNamed:@"season_seasonMiddle_85x41"]stretchableImageWithLeftCapWidth:20 topCapHeight:0];
            [unselectButton setBackgroundImage:buttonBg forState:UIControlStateNormal];
            [unselectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }else {
            UIImage * buttonBg = [[UIImage imageNamed:@"season_seasonRight_85x41"]stretchableImageWithLeftCapWidth:20 topCapHeight:0];
            [unselectButton setBackgroundImage:buttonBg forState:UIControlStateNormal];
            [unselectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        _clickTag = btn.tag;
    }
    if(btn.tag == 1){
        UIImage * buttonBg = [[UIImage imageNamed:@"season_seasonLeft_s_85x41"]stretchableImageWithLeftCapWidth:20 topCapHeight:0];
        [btn setBackgroundImage:buttonBg forState:UIControlStateNormal];
        [btn setTitleColor:BMainColor forState:UIControlStateNormal];
    }else if(btn.tag<=_data.count){
        UIImage * buttonBg = [[UIImage imageNamed:@"season_seasonMiddle_s_85x41"]stretchableImageWithLeftCapWidth:20 topCapHeight:0];
        [btn setBackgroundImage:buttonBg forState:UIControlStateNormal];
        [btn setTitleColor:BMainColor forState:UIControlStateNormal];
    }else {
        UIImage * buttonBg = [[UIImage imageNamed:@"season_seasonRight_s_85x41"]stretchableImageWithLeftCapWidth:20 topCapHeight:0];
        [btn setBackgroundImage:buttonBg forState:UIControlStateNormal];
        [btn setTitleColor:BMainColor forState:UIControlStateNormal];
    }
    if(btn.tag != _data.count + 1){
        Seasons *season = _data[btn.tag-1];
        _iconClick(season.season_id);
    }else {
        _iconClick(_endSeasonId);
    }
    
}



@end
