//
//  VideoPlayerView.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/20.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoPlayerView;

@protocol PlayerUIViewDelegate<NSObject>
@optional
- (void)playerTouchBackArrow:(VideoPlayerView*)UIView;
- (void)playerTouchDanMuButton:(VideoPlayerView*)UIView;
- (void)playerTouchPlayerButton:(VideoPlayerView*)UIView;
- (void)playerTouchSlider:(VideoPlayerView*)UIView slideValue:(CGFloat)value;
@end

@interface VideoPlayerView : UIView

typedef void(^handle)();
//淡出时间
@property (nonatomic, assign) CGFloat fadeTime;
@property (nonatomic, weak) id<PlayerUIViewDelegate> delegate;
@property (nonatomic, strong) handle returnBlock;
- (instancetype)initWithTitle:(NSString*)title videoTime:(NSInteger)videoTime;
- (void)setWithTitle:(NSString*)title videoTime:(NSInteger)videoTime;
- (void)showPlayer;
- (void)hiddenPlayer;
/**
 *  用于更新参数
 *
 */
- (void)updateValue:(handle) block;
/**
 *  更新时间
 *  @param time 传递秒数
 */
- (void)updateCurrentTime:(CGFloat)currentTime bufferTime:(CGFloat)bufferTime allTime:(NSInteger)allTime;


@end
