//
//  PlayerSliderView.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/20.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlayerSliderView;

@protocol PlayerSliderViewDelegate<NSObject>
@optional
- (void)playerSliderTouchEnd:(CGFloat)endValue playerSliderView:(PlayerSliderView*)PlayerSliderView;
@end

@interface PlayerSliderView : UIView
@property (nonatomic, weak) id<PlayerSliderViewDelegate> delegate;

- (instancetype)initWithLineWidth:(CGFloat)lineWidth currentTimeColor:(UIColor*)currentTimeColor bufferTimeColor:(UIColor*)bufferTimeColor lineBackGroundColor:(UIColor*)lineBackGroundColor thumbImg:(UIImage*)thumbImg;
- (void)updateCurrentTime:(CGFloat)currentTime;
- (void)updateBufferTime:(CGFloat)bufferTime;
@end
