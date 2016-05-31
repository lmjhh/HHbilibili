//
//  VideoInfoButton.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/18.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "VideoInfoButtonView.h"

@interface VideoInfoButtonView ()

@property (nonatomic,strong) UIImageView *btnBackgroundImageView,*btnImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) NSString *title;


@end

@implementation VideoInfoButtonView

- (instancetype)initWithFrameAndImageAndTitle:(CGRect)frame image:(UIImage *)image title:(NSString *)title tintColor:(UIColor *)color{
    
    if(self = [super initWithFrame:frame]){
        
        _btnBackgroundImageView = [[UIImageView alloc] init];
        _btnBackgroundImageView.userInteractionEnabled = NO;
        _btnBackgroundImageView.image = [UIImage imageNamed:@"iphonevideoinfo_button_43x42"];
        _btnBackgroundImageView.tintColor = color;

        [self addSubview:_btnBackgroundImageView];
        
        _btnImageView = [[UIImageView alloc] init];
         _btnImageView.userInteractionEnabled = NO;
        [_btnImageView setTintColor:color];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_btnImageView setImage:image];
        [_btnBackgroundImageView addSubview:_btnImageView];
        
        _titleLabel = [[UILabel alloc] init];
         _titleLabel.userInteractionEnabled = NO;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_titleLabel setText:title];
        [self addSubview:_titleLabel];
        
    }
    return self;
    
}


- (void)layoutSubviews{
    
    [_btnBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self);
        make.top.equalTo(@0);
        make.height.equalTo(@43);
        make.width.equalTo(@42);
        
    }];
    
    [_btnImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(_btnBackgroundImageView);
        make.centerY.equalTo(_btnBackgroundImageView).offset(1);
        make.height.equalTo(@22);
        make.width.equalTo(@22);
        
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(_btnBackgroundImageView);
        make.height.equalTo(@16);
        make.centerX.equalTo(_btnBackgroundImageView);
        make.top.equalTo(_btnBackgroundImageView.mas_bottom).offset(5);
        
    }];
}

@end
