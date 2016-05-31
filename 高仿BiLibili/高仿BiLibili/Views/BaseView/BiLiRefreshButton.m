//
//  BILiRefreshButton.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/9.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "BiLiRefreshButton.h"

@implementation BiLiRefreshButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self.titleLabel setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightUltraLight]];
        [self.titleLabel setTextAlignment:NSTextAlignmentRight];
        
        [self.imageView setImage:[UIImage imageNamed:@"home_refresh_20x20"]];
        NSInteger count = arc4random() % 100;
        [self setTitle:[NSString stringWithFormat:@"%d条动态，点击刷新！",count] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    }
    
    return self;
    
}

- (void)startRefresh{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.delegate = self;
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI - 0.00001 , 0, 0, 1.0)];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = INT_MAX;
    [self.imageView.layer addAnimation:animation forKey:@"animation"];
}

- (void)endRefresh{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.delegate = self;
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0, 1.0)];
    animation.duration = 0.25;
    animation.cumulative = NO;
    animation.repeatCount = 0;
    NSInteger count = arc4random() % 100;
    [self setTitle:[NSString stringWithFormat:@"%ld条动态，点击刷新！",(long)count] forState:UIControlStateNormal];
    [self.imageView.layer addAnimation:animation forKey:@"animation"];
}

- (void)layoutSubviews{
    
    
    self.imageView.frame = CGRectMake(self.frame.size.width - 20, 10, 20, 20);
    self.titleLabel.frame = CGRectMake(0, 12, self.frame.size.width - 20, 16);
    
}


@end
