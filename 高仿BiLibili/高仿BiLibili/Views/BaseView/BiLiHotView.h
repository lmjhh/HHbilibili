//
//  BiLiHotView.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/6.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BiLiHotView : UIView

- (instancetype) initWithFrameAndClick:(CGRect)frame focusIconClick:(void(^)(NSInteger index))focusIconClick;
- (void)setTitileAndIcon:(NSArray *)titleArray iconArray:(NSArray *)iconArray;
- (void)setTitileAndIconWithPath:(NSArray *)titleArray iconArray:(NSArray *)iconArray;

@end

@interface IconImageTextView : UIView

- (instancetype)initWithFramAndPlaceholderImage:(CGRect)frame placeholderImage:(UIImage *)placeholderImage title:(NSString *)title img:(NSString *)img;
- (instancetype)initWithFramAndImage:(CGRect)frame title:(NSString *)title img:(UIImage *)img;

@end