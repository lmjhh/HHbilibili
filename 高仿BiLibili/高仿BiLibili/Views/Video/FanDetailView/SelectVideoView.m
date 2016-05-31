//
//  SelectVideoView.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/19.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "SelectVideoView.h"

@interface SelectVideoView ()

@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) UILabel *titleLabel,*updateLabel;
@property (nonatomic,copy) void (^iconClick)(NSInteger index);

@end

@implementation SelectVideoView


- (instancetype)initWithFrameAndClick:(CGRect)frame focusIconClick:(void (^)(NSInteger index))focusIconClick{
    
    if(self = [super initWithFrame:frame]){
        
        _iconClick = focusIconClick;
        [self buildLabel];
        [self setBackgroundColor:BBackgroundColor];
        
    }
    return self;
    
    
}

- (void)setCountAndIsWatch:(NSArray *) titleArray isWatch:(NSArray *)isWatch isFinish:(BOOL)isFinish{
    
    [self buildButton:titleArray isFinish:isFinish];
    [_titleLabel setText:[NSString stringWithFormat:@"选集（%ld）",titleArray.count]];
    [_updateLabel setText:[NSString stringWithFormat:@"更新 第%ld话",titleArray.count]];
    if(isFinish){
        [_updateLabel setText:[NSString stringWithFormat:@"全%ld话",titleArray.count]];
    }
}

- (void)buildLabel{
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.userInteractionEnabled = NO;
    [_titleLabel setTextColor:[UIColor blackColor]];
    [_titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:_titleLabel];
    
    _updateLabel = [[UILabel alloc] init];
    _updateLabel.userInteractionEnabled = NO;
    [_updateLabel setTextAlignment:NSTextAlignmentRight];
    [_updateLabel setTextColor:[UIColor colorWithCustom:205 green:205 blue:205]];
    [_updateLabel setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:_updateLabel];
    
}

- (void)buildButton:(NSArray *) titleArray isFinish:(BOOL)isFinish{
    
    CGFloat iconH = 40,iconW = 80,iconX = 0,iconY = 0;
    CGFloat margin = (BScreen_Width -350)/3;
    
    for(UIView *view in [self subviews]){
        if([view isKindOfClass:[UIButton class]]){
            [view removeFromSuperview];
        }
    }
    
    for(int i=0; i<titleArray.count; i++){
        iconX = (i % 4) * iconW + (i % 4) * margin;
        iconY = iconH * (i / 4) + 30 + (i / 4) * margin;
        UIButton *icon = [[UIButton alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
        [icon.layer setMasksToBounds:YES];
        [icon.layer setCornerRadius:4];
        [icon.layer setBorderWidth:1];
        [icon.layer setBorderColor:[[UIColor colorWithCustom:205 green:205 blue:205] CGColor]];
        [icon addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [icon.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [icon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [icon setBackgroundColor:[UIColor whiteColor]];
        if(isFinish){
            [icon setTitle:titleArray[titleArray.count - i - 1] forState:UIControlStateNormal];
            icon.tag = titleArray.count - i - 1;
        }else {
            [icon setTitle:titleArray[i] forState:UIControlStateNormal];
            icon.tag = i;
        }
        
        if(i == titleArray.count - 1){
            [icon.layer setBorderColor:BMainColor.CGColor];
            [icon setTitleColor:BMainColor forState:UIControlStateNormal];
        }
        
        [self addSubview:icon];

    }
    
}



- (void)layoutSubviews{
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.height.mas_equalTo(16);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        
    }];
    
    [_updateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@16);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        
    }];
    
}

- (void)buttonClick:(UIButton *)btn{
    
    [btn.layer setBorderColor:BMainColor.CGColor];
    [btn setTitleColor:BMainColor forState:UIControlStateNormal];
    [self clearButton:btn];
    _iconClick(btn.tag);
    
}

- (void)clearButton:(UIButton *)btn{
    
    for(int i=0; i<[self subviews].count; i++){
        if([self.subviews[i] isKindOfClass:[UIButton class]]){
            UIButton *button = self.subviews[i];
            if(button.tag != btn.tag){
                [button.layer setBorderColor:[[UIColor colorWithCustom:205 green:205 blue:205] CGColor]];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
    }
    
}


@end
