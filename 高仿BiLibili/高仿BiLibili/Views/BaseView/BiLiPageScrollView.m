//
//  BiLiPageScrollView.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/4.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#define imageViewMaxCount 3


#import "BiLiPageScrollView.h"

@interface BiLiPageScrollView()

@property(nonatomic,strong) UIScrollView *imageScrollView;
@property(nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,strong) UIImage *placeholderImage;
@property(nonatomic,copy) void (^imageClick)(NSInteger index);

@end

@implementation BiLiPageScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype) initWithFrameAndConfig:(CGRect)frame placheholder:(UIImage *)placeholder focusImageViewClick:(void(^)(NSInteger index))focusImageViewClick{
    
    self = [super initWithFrame:frame];
    if(self){
        _placeholderImage = placeholder;
        _imageClick = focusImageViewClick;
        [self buildbuildImageScrollView];
        [self buildPageControl];
    }
    
    
    return self;
}

- (void) setData:(NSArray *)Data{
    _Data = Data;
    if (!_Data){
        return;
    }
    if (_timer != nil){
        [_timer invalidate];
        _timer = nil;
    }
    _pageControl.numberOfPages = _Data.count;
    _pageControl.currentPage = 0;
    [self updatePageScrollView];
    [self startTimer];
}


- (void) layoutSubviews {
    
    [super layoutSubviews];
    
    [_imageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.equalTo(self);
        
    }];
    [_imageScrollView setContentSize:CGSizeMake(imageViewMaxCount * _imageScrollView.bounds.size.width, 0)];
    
    for(NSInteger i = 0; i<imageViewMaxCount ; i++){
        UIImageView *imageView = _imageScrollView.subviews[i];
        imageView.userInteractionEnabled = YES;
        imageView.frame = CGRectMake(i*_imageScrollView.frame.size.width, 0, _imageScrollView.bounds.size.width, _imageScrollView.bounds.size.height);
    }
    
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
        make.rightMargin.mas_equalTo(0);
        make.bottomMargin.mas_equalTo(0);
    }];
    
    [self updatePageScrollView];
    
}

#pragma mark BuildUI

- (void) buildbuildImageScrollView{
    
    _imageScrollView = [[UIScrollView alloc] init];
    _imageScrollView.bounces = NO;
    _imageScrollView.showsHorizontalScrollIndicator = NO;
    _imageScrollView.showsVerticalScrollIndicator = NO;
    _imageScrollView.pagingEnabled = YES;
    _imageScrollView.delegate = self;
    [self addSubview:_imageScrollView];
    for(int i=0;i<3;i++){
        UIImageView *imageView = [[UIImageView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
        [imageView addGestureRecognizer:tap];
        [_imageScrollView addSubview:imageView];
    }
    
    
}

- (void) buildPageControl{
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.hidesForSinglePage = YES;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = BMainColor;
    [self addSubview:_pageControl];
    
}

#pragma mark 更新内容

- (void) updatePageScrollView{
    for(int i = 0; i < _imageScrollView.subviews.count; i++){
        UIImageView *imageView = _imageScrollView.subviews[i];
        NSInteger index = _pageControl.currentPage;
        
        if(i==0){
            index--;
        } else if(2==i){
            index++;
        }
        
        if( index < 0){
            index = _pageControl.numberOfPages - 1;
        } else if(index >= _pageControl.numberOfPages){
            index = 0;
        }
        imageView.tag = index;
        if(_Data.count > 0){
            NSString *img = [_Data objectAtIndex:index];
            [imageView sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:_placeholderImage];
        }
    }
    
    _imageScrollView.contentOffset = CGPointMake(_imageScrollView.bounds.size.width, 0);
    
}

#pragma mark Timer

- (void) startTimer {
    _timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(next) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void) stopTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void) next {
    [_imageScrollView setContentOffset:CGPointMake(2*_imageScrollView.bounds.size.width, 0) animated:YES];
}


#pragma mark Action

- (void)imageViewClick:(UITapGestureRecognizer *) tap{
    if(_imageClick != nil){
        _imageClick(tap.view.tag);
    }
}

#pragma mark UIScrollViewDelegate

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger page = 0;
    CGFloat minDistance = MAXFLOAT;
    for(NSInteger i=0; i<_imageScrollView.subviews.count; i++){
        UIImageView *imageView = _imageScrollView.subviews[i];
        CGFloat distance = fabs(imageView.frame.origin.x - scrollView.contentOffset.x);
        if (distance < minDistance) {
            minDistance = distance;
            page = imageView.tag;
        }
    }
    _pageControl.currentPage = page;
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self updatePageScrollView];
}

- (void) scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self updatePageScrollView];
}

@end
