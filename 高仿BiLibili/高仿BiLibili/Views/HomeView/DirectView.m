//
//  DirectView.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/8.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "DirectView.h"

@interface DirectView()

@property (nonatomic,strong) UIImageView *backgroundImageView,*faceImageView;
@property (nonatomic,strong) UILabel *nameLabel,*titleLabel,*countLabel;
@property (nonatomic,strong) Lives *data;

@end

@implementation DirectView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        [self buildBackgroundImageView];
        [self buildFaceImageView];
        [self buildNameLabel];
        [self bulidCountLabel];
        [self buildTitleLabel];
        
    }
    return self;
}

- (void)setData:(Lives *)data{
    
    _data = data;
    [_backgroundImageView sd_setImageWithURL:[NSURL URLWithString:_data.cover.src ] placeholderImage:BPlachImageBack];
    [_faceImageView sd_setImageWithURL:[NSURL URLWithString:_data.owner.face ] placeholderImage:BPlachIcon];
    
    [_nameLabel setText:_data.owner.name];
    [_countLabel setText:_data.online];
    [_titleLabel setText:_data.title];
    
}

- (Lives *)getData{
    
    return _data;
    
}

- (void)buildBackgroundImageView{
    
    _backgroundImageView = [[UIImageView alloc] init];
    _backgroundImageView.userInteractionEnabled = NO;
    _backgroundImageView.layer.masksToBounds = YES;
    _backgroundImageView.layer.cornerRadius = 10;
    _backgroundImageView.layer.borderWidth = 0.5;
    _backgroundImageView.layer.borderColor = [UIColor colorWithCustom:206 green:206 blue:206].CGColor;
    [_backgroundImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_backgroundImageView];
    
}


- (void)buildFaceImageView{
    
    _faceImageView = [[UIImageView alloc] init];
    _faceImageView.userInteractionEnabled = NO;
    _faceImageView.layer.masksToBounds = YES;
    _faceImageView.layer.cornerRadius = 20;
    _faceImageView.layer.borderWidth = 1;
    _faceImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    [_faceImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_faceImageView];
    
}

- (void)buildNameLabel{
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.userInteractionEnabled = NO;
    [_nameLabel setFont:[UIFont systemFontOfSize:13]];
    [_nameLabel setTextColor:[UIColor blackColor]];
    [_nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_nameLabel];
}

- (void)bulidCountLabel{
    
    _countLabel = [[UILabel alloc] init];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.userInteractionEnabled = NO;
    _countLabel.layer.masksToBounds = YES;
    _countLabel.layer.cornerRadius = 5;
    _countLabel.layer.borderWidth = 0.5;
    _countLabel.layer.borderColor = [UIColor colorWithCustom:206 green:206 blue:206].CGColor;
    [_countLabel setBackgroundColor:[UIColor colorWithCustom:231 green:231 blue:231]];
    [_countLabel setFont:[UIFont systemFontOfSize:12]];
    [_countLabel setTextColor:[UIColor blackColor]];
    [_countLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_countLabel];
    
}

- (void)buildTitleLabel{
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.userInteractionEnabled = NO;
    [_titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_titleLabel setTextColor:[UIColor colorWithCustom:175 green:175 blue:175]];
    [_titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_titleLabel];
    
}

- (void)layoutSubviews{
    
    DirectView __weak *weakSelf = self;
    
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(@5);
        make.right.equalTo(@-5);
        make.height.equalTo(weakSelf).multipliedBy(0.63);
    }];
    
    
    [_faceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backgroundImageView.mas_left).offset(5);
        make.height.equalTo(@40);
        make.width.equalTo(@40);
        make.centerY.equalTo(_backgroundImageView.mas_bottom);
    }];
    
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_faceImageView.mas_right).offset(5);
        make.right.equalTo(_backgroundImageView.mas_right).offset(-5);
        make.bottom.equalTo(_faceImageView.mas_bottom).offset(3);
        make.height.mas_equalTo(16);
        
    }];
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_backgroundImageView.mas_left);
        make.right.equalTo(_faceImageView.mas_right);
        make.top.equalTo(_faceImageView.mas_bottom).offset(8);
        make.height.mas_equalTo(16);
        
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(_nameLabel.mas_centerX);
        make.centerY.equalTo(_countLabel.mas_centerY);
        make.height.mas_equalTo(16);
        make.width.equalTo(_nameLabel.mas_width);
        
    }];
    
}


@end
