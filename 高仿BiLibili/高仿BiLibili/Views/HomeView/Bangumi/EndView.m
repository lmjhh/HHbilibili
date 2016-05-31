//
//  EndView.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/17.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "EndView.h"

@interface EndView ()

@property (nonatomic,strong) UIImageView *backgroundImageView;
@property (nonatomic,strong) UILabel *nameLabel,*countLabel;
@property (nonatomic,strong) List *data;

@end

@implementation EndView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        [self buildBackgroundImageView];
        [self buildCountImageView];
        [self buildNameLabel];
        
    }
    return self;
}

- (void)setData:(List *)data{
    
    _data = data;
    [_backgroundImageView sd_setImageWithURL:[NSURL URLWithString:_data.cover ] placeholderImage:BPlachImageBack];
    
    [_countLabel setText:[NSString stringWithFormat:@"%@话全",_data.total_count]];

    [_nameLabel setText:_data.title];
    

    
}

- (void)buildBackgroundImageView{
    
    _backgroundImageView = [[UIImageView alloc] init];
    _backgroundImageView.userInteractionEnabled = NO;
    _backgroundImageView.layer.masksToBounds = YES;
    _backgroundImageView.layer.cornerRadius = 3;
    _backgroundImageView.layer.borderWidth = 0.5;
    _backgroundImageView.layer.borderColor = [UIColor colorWithCustom:206 green:206 blue:206].CGColor;
    [_backgroundImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_backgroundImageView];
    
}

- (void)buildCountImageView{
    
    _countLabel = [[UILabel alloc] init];
    _countLabel.textColor = [UIColor whiteColor];
    _countLabel.userInteractionEnabled = NO;
    _countLabel.font = [UIFont systemFontOfSize:13];
    [_countLabel setTextColor:[UIColor colorWithCustom:175 green:175 blue:175]];
    [_countLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_countLabel];

    
}

- (void)buildNameLabel{
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.userInteractionEnabled = NO;
    [_nameLabel setFont:[UIFont systemFontOfSize:13]];
    [_nameLabel setTextAlignment:NSTextAlignmentCenter];
    [_nameLabel setTextColor:[UIColor blackColor]];
    [_nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_nameLabel];
    
}


- (void)layoutSubviews{
    
    EndView __weak *weakSelf = self;
    
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@5);
        make.right.equalTo(@-5);
        make.height.equalTo(weakSelf.mas_width).multipliedBy(1.31);
    }];

    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backgroundImageView.mas_centerX);
        make.top.equalTo(_backgroundImageView.mas_bottom).offset(5);
        make.width.equalTo(_backgroundImageView.mas_width);
        make.height.equalTo(@16);
    }];
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nameLabel.mas_left);
        make.right.equalTo(_nameLabel.mas_right);
        make.top.equalTo(_nameLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(16);
        
    }];
    
    

    
}



@end
