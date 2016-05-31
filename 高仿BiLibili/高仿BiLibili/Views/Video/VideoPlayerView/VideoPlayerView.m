//
//  VideoPlayerView.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/20.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "VideoPlayerView.h"
#import "PlayerSliderView.h"

@interface VideoPlayerView ()<PlayerSliderViewDelegate>
@property (nonatomic, strong) UIView* headView;
@property (nonatomic, strong) UIView* bottomView;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* timeLabel;
@property (nonatomic, strong) UILabel* allTimeLabel;
@property (nonatomic, strong) PlayerSliderView* slideView;
@property (nonatomic, strong) UIButton* playButton;
@property (nonatomic, strong) UIButton* sendButton;
@property (nonatomic, strong) UIButton* danMuButton;
@property (nonatomic, strong) UIButton* lockButton;
@property (nonatomic, strong) NSDateFormatter* formatter;
@property (nonatomic, assign) NSInteger allTime;
@property (nonatomic, strong) NSString* allFormatterTime;
@property (nonatomic, strong) NSTimer* timer;
@end

@implementation VideoPlayerView

- (instancetype)initWithTitle:(NSString*)title videoTime:(NSInteger)videoTime{
    if (self = [super init]) {
        self.titleLabel.text = title;
        self.fadeTime = 0.5;
        //初始化title
        [self addSubview: self.headView];
        [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(self.mas_height).multipliedBy(0.1);
        }];
        //初始化时间面板
        [self addSubview: self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(self.mas_height).multipliedBy(0.3);
        }];
        
    }
    return self;
}

#pragma mark - 方法

- (void)showPlayer{
    self.hidden = NO;
    [self.timer invalidate];
    [UIView animateWithDuration:self.fadeTime animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        //显示三秒后自动隐藏
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoHiddenPlayer) userInfo:nil repeats:NO];
    }];
}

- (void)autoHiddenPlayer{
    self.returnBlock();
    [self hiddenPlayer];
}

- (void)hiddenPlayer{
    [self.timer invalidate];
    [UIView animateWithDuration:self.fadeTime animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}
- (void)updateCurrentTime:(CGFloat)currentTime bufferTime:(CGFloat)bufferTime allTime:(NSInteger)allTime{
    self.allTime = allTime;
    self.allFormatterTime = [self.formatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:allTime]];
    
    NSDate* date = [NSDate dateWithTimeIntervalSinceReferenceDate:currentTime];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",[self.formatter stringFromDate: date]];
    self.allTimeLabel.text = [NSString stringWithFormat:@"%@",self.allFormatterTime];
    [self.slideView updateCurrentTime: currentTime / self.allTime];
    [self.slideView updateBufferTime: bufferTime / self.allTime];
}

- (void)setWithTitle:(NSString*)title videoTime:(NSInteger)videoTime{
    self.titleLabel.text = title;
    self.allTime = videoTime;
}

- (void)updateValue:(handle) block{
    self.returnBlock = block;
}

#pragma mark - 协议
- (void)playButtonTouchDown{
    self.playButton.selected = !self.playButton.isSelected;
    if([self.delegate respondsToSelector:@selector(playerTouchPlayerButton:)]){
        [self.delegate playerTouchPlayerButton: self];
    }
}

- (void)danMuButtonDown{
    self.danMuButton.selected = !self.danMuButton.isSelected;
    if([self.delegate respondsToSelector:@selector(playerTouchDanMuButton:)]){
        [self.delegate playerTouchDanMuButton: self];
    }
}

- (void)arrowButtonDown{
    if([self.delegate respondsToSelector:@selector(playerTouchBackArrow:)]){
        [self.delegate playerTouchBackArrow: self];
    }
}

#pragma mark - 懒加载

- (UIView *)headView{
    if(_headView == nil) {
        _headView = [[UIView alloc] init];
        _headView.backgroundColor = [UIColor colorWithRed:85/255 green:85/255 blue:85/255 alpha:0.6];
        
        UIButton* arrowButton = [[UIButton alloc] init];
        [arrowButton setBackgroundImage:[UIImage imageNamed:@"hd_idct_back"] forState:UIControlStateNormal];
        [arrowButton addTarget:self action:@selector(arrowButtonDown) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview: arrowButton];
        [arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(20);
            make.centerY.equalTo(_headView);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(20);
        }];
        
        [_headView addSubview: self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(arrowButton.mas_right).mas_offset(10);
            make.centerY.equalTo(arrowButton);
        }];
    }
    return _headView;
}


- (UIView *)bottomView {
    if(_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor clearColor];
        
        
        
        UIView *tempView = [UIView new];
        [tempView setBackgroundColor:[UIColor colorWithRed:85/255 green:85/255 blue:85/255 alpha:0.6]];
        [_bottomView addSubview:tempView];
        
        [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.bottom.equalTo(@0);
            make.height.equalTo(_bottomView.mas_height).multipliedBy(0.4);
            
        }];
        
        self.playButton = [[UIButton alloc] init];
        UIImage *buttonNorImg = [[UIImage imageNamed:@"player_pause_c_54x50"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImage *buttonSelImg = [[UIImage imageNamed:@"player_play_c_56x52"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        self.playButton.tintColor = [UIColor whiteColor];
        [self.playButton setBackgroundImage:buttonNorImg forState:UIControlStateNormal];
        [self.playButton setBackgroundImage:buttonSelImg forState:UIControlStateSelected];
        [self.playButton addTarget:self action:@selector(playButtonTouchDown) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview: self.playButton];
        [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(tempView.mas_right).mas_offset(-20);
            make.bottom.equalTo(tempView.mas_top).mas_offset(-10);
            make.width.mas_equalTo(82);
            make.height.mas_equalTo(65);
        }];
        
        self.sendButton = [UIButton new];
        [self.sendButton setImage:[UIImage imageNamed:@"icmpv_add_danmaku_light"]  forState:UIControlStateNormal];
        [tempView addSubview:self.sendButton];
        [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tempView).mas_offset(20);
            make.width.mas_equalTo(23);
            make.height.mas_equalTo(26);
            make.centerY.equalTo(tempView);
        }];
        
        self.danMuButton = [UIButton new];
        [self.danMuButton setImage:[UIImage imageNamed:@"icmpv_toggle_danmaku_hided_light"] forState:UIControlStateNormal];
        [self.danMuButton setImage:[UIImage imageNamed:@"icmpv_toggle_danmaku_showed_light"] forState:UIControlStateSelected];
        [self.danMuButton addTarget:self action:@selector(danMuButtonDown) forControlEvents:UIControlEventTouchUpInside];
        self.danMuButton.titleLabel.font = [UIFont systemFontOfSize: 12];
        [tempView addSubview: self.danMuButton];
        [self.danMuButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.sendButton.mas_right).offset(30);
            make.centerY.equalTo(self.sendButton);
        }];
        
        [tempView addSubview: self.timeLabel];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.danMuButton.mas_right).mas_offset(30);
            make.centerY.equalTo(self.sendButton);
            make.width.equalTo(@50);
        }];
    
        self.lockButton = [UIButton new];
        [self.lockButton setImage:[UIImage imageNamed:@"player_lock_10x13"] forState:UIControlStateNormal];
        
        [tempView addSubview:self.lockButton];
        
        [self.lockButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(tempView.mas_right).mas_offset(-40);
            make.centerY.equalTo(self.sendButton);
        }];
        
        
        [tempView addSubview:self.allTimeLabel];
        
        [self.allTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.lockButton.mas_left).mas_offset(-20);
            make.centerY.equalTo(self.sendButton);
        }];
        

        [_bottomView addSubview: self.slideView];
        
        [self.slideView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.sendButton);
            make.left.equalTo(_timeLabel.mas_right).mas_offset(10);
            make.right.equalTo(_allTimeLabel.mas_left).mas_offset(-10);
            make.height.mas_equalTo(_bottomView.mas_height).multipliedBy(0.4);
        }];
    }
    return _bottomView;
}



- (UILabel *)titleLabel{
    if(_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize: 13];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel{
    if(_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize: 15];
        _timeLabel.text = @"00:00";
        _timeLabel.textColor = [UIColor whiteColor];
    }
    return _timeLabel;
}

- (UILabel *)allTimeLabel{
    if(_allTimeLabel == nil) {
        _allTimeLabel = [[UILabel alloc] init];
        _allTimeLabel.font = [UIFont systemFontOfSize: 15];
        _allTimeLabel.text = @"00:00";
        _allTimeLabel.textColor = [UIColor whiteColor];
    }
    return _allTimeLabel;
    
}

- (NSDateFormatter *)formatter{
    if(_formatter == nil) {
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setDateFormat:@"mm:ss"];
    }
    return _formatter;
}

- (PlayerSliderView *)slideView{
    if(_slideView == nil) {
        _slideView = [[PlayerSliderView alloc] initWithLineWidth:3 currentTimeColor:BMainColor bufferTimeColor:[UIColor colorWithCustom:201 green:103 blue:132] lineBackGroundColor:[UIColor whiteColor] thumbImg:[UIImage imageNamed:@"progress" ]];
        _slideView.delegate = self;
    }
    return _slideView;
}



#pragma mark - PlayerSliderView

- (void)playerSliderTouchEnd:(CGFloat)endValue playerSliderView:(PlayerSliderView *)PlayerSliderView{
    if([self.delegate respondsToSelector:@selector(playerTouchSlider:slideValue:)]){
        [self.delegate playerTouchSlider: self slideValue: endValue];
    }
}



@end
