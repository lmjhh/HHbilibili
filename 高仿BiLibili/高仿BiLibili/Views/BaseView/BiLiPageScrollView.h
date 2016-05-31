//
//  BiLiPageScrollView.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/4.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeData.h"

@interface BiLiPageScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic,strong) NSArray* Data;

- (instancetype) initWithFrameAndConfig:(CGRect)frame placheholder:(UIImage *)placeholder focusImageViewClick:(void(^)(NSInteger index))focusImageViewClick;

@end
