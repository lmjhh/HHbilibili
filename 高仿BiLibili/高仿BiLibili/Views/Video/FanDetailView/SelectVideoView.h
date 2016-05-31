//
//  SelectVideoView.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/19.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectVideoView : UIView

- (instancetype) initWithFrameAndClick:(CGRect)frame focusIconClick:(void(^)(NSInteger index))focusIconClick;
- (void)setCountAndIsWatch:(NSArray *)titleArray isWatch:(NSArray *)isWatch isFinish:(BOOL)isFinish;

@end
