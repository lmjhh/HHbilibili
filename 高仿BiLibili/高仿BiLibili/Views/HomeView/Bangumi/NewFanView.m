//
//  NewFanView.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/17.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "NewFanView.h"


@interface NewFanView ()

@property (nonatomic,strong) UIImageView *backgroundImageView,*countImageView;
@property (nonatomic,strong) UILabel *nameLabel,*timeLabel,*countLabel;
@property (nonatomic,strong) List *data;

@end


@implementation NewFanView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        [self buildBackgroundImageView];
        [self buildCountImageView];
        [self buildNameLabel];
        [self buildTimeLabel];
        
    }
    return self;
}

- (void)setData:(List *)data{
    
    _data = data;
    [_backgroundImageView sd_setImageWithURL:[NSURL URLWithString:_data.cover ] placeholderImage:BPlachImageBack];
    
    [_countLabel setText:[NSString stringWithFormat:@"%@人在看",_data.watchingCount]];
    if(_data.watchingCount.integerValue > 100){
        [_countImageView setHidden:NO];
    }
    [_nameLabel setText:_data.title];
    
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    
    NSTimeInterval dateInt = [_data.last_time integerValue];
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:dateInt];
    
    if([date isToday]){
        
        [dateFormatter setDateFormat:[NSString stringWithFormat:@"%@HH:mm",[date getToday]]];
        [_timeLabel setTextColor:BMainColor];
        
        
    }else {
        
        [dateFormatter setDateFormat:@"昨天HH:mm"];
        [_timeLabel setTextColor:[UIColor colorWithCustom:175 green:175 blue:175]];
    }
    
    NSString *dateString = [dateFormatter stringFromDate: date];
    
    [_timeLabel setText:[NSString stringWithFormat:@"%@ · 第 %@ 话",dateString,_data.newest_ep_index]];
    
    
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

- (void)buildCountImageView{
    
    _countImageView = [[UIImageView alloc] init];
    _countImageView.userInteractionEnabled = NO;
    [_countImageView setImage:[UIImage imageNamed:@"watching_tag_black_107x34"]];
    _countLabel = [[UILabel alloc] init];
    _countLabel.textColor = [UIColor whiteColor];
    _countLabel.userInteractionEnabled = NO;
    _countLabel.font = [UIFont systemFontOfSize:13];
    [_countLabel setTextAlignment:NSTextAlignmentCenter];
    [_countImageView addSubview:_countLabel];
    [self addSubview:_countImageView];
    
    [_countImageView setHidden:YES];
    
}

- (void)buildNameLabel{
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.userInteractionEnabled = NO;
    [_nameLabel setFont:[UIFont systemFontOfSize:13]];
    [_nameLabel setTextColor:[UIColor blackColor]];
    [_nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_nameLabel];
    
}

- (void)buildTimeLabel{
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.userInteractionEnabled = NO;
    [_timeLabel setFont:[UIFont systemFontOfSize:13]];
    [_timeLabel setTextColor:[UIColor colorWithCustom:175 green:175 blue:175]];;
    [_timeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_timeLabel];
    
}

- (void)layoutSubviews{
    
    NewFanView __weak *weakSelf = self;
    
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@5);
        make.right.equalTo(@-5);
        make.height.equalTo(weakSelf).multipliedBy(0.63);
    }];
    
    [_countImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(_backgroundImageView.mas_right).offset(5);
        make.top.equalTo(_backgroundImageView.mas_top).offset(5);
        make.width.equalTo(_backgroundImageView.mas_width).multipliedBy(0.5);
        make.height.equalTo(@25);
        
    }];
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(_countImageView.mas_centerX);
        make.centerY.equalTo(_countImageView.mas_centerY).offset(-1);
        make.width.equalTo(_countImageView.mas_width).multipliedBy(0.9);
        make.height.equalTo(@16);
        
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_backgroundImageView.mas_left).offset(10);
        make.right.equalTo(_backgroundImageView.mas_right).offset(-5);
        make.top.equalTo(_backgroundImageView.mas_bottom).offset(3);
        make.height.mas_equalTo(16);
        
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nameLabel.mas_left);
        make.top.equalTo(_nameLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(16);
        make.width.equalTo(_nameLabel.mas_width);
        
    }];
    
}


@end
