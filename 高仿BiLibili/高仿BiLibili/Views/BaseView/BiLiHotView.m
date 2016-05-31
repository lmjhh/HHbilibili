//
//  BiLiHotView.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/6.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "BiLiHotView.h"

#define HotViewMargin 10
#define iconW (BScreen_Width - 2 * HotViewMargin) * 0.25
#define iconH 85

@interface BiLiHotView ()

@property (nonatomic,strong) NSArray *titleArray,*iconArray;
@property (nonatomic,assign) NSInteger row;
@property (nonatomic,copy) void (^iconClick)(NSInteger index);

@end

@implementation BiLiHotView

- (instancetype) initWithFrameAndClick:(CGRect)frame focusIconClick:(void(^)(NSInteger index))focusIconClick{
    self = [super initWithFrame:frame];
    _iconClick = focusIconClick;
    [self setBackgroundColor:[UIColor whiteColor]];
    return self;
    
}

- (void)setTitileAndIcon:(NSArray *)titleArray iconArray:(NSArray *)iconArray{
    
    _titleArray = titleArray;
    _iconArray = iconArray;
    
    if(_titleArray.count %4 != 0){
        [self setRow:_titleArray.count/4 + 1];
    }else {
        [self setRow:_titleArray.count/4];
    }
    CGFloat iconX = 0;
    CGFloat iconY = 0;
    
    for(int i=0; i<titleArray.count + 1; i++){
        iconX = (i % 4) * iconW + HotViewMargin;
        iconY = iconH * (i / 4);
        IconImageTextView *icon = nil;
        if(i==titleArray.count){
            icon = [[IconImageTextView alloc] initWithFramAndImage:CGRectMake(iconX, iconY, iconW, iconH) title:@"全部直播" img:[UIImage imageNamed:@"live_partitionEntrance0_40x40"]];
        }else {
            NSString *title = titleArray[i];
            NSString *img = iconArray[i];
            icon = [[IconImageTextView alloc] initWithFramAndPlaceholderImage:CGRectMake(iconX, iconY, iconW, iconH) placeholderImage:[UIImage imageNamed:@"home_icon_defult"] title:title img:img];
        }
        icon.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconClick:)];
        [icon addGestureRecognizer:tap];
        
        [self addSubview:icon];
    }
    
    
    
}

- (void)setTitileAndIconWithPath:(NSArray *)titleArray iconArray:(NSArray *)iconArray{
    
    _titleArray = titleArray;
    _iconArray = iconArray;
    
    if(_titleArray.count %4 != 0){
        [self setRow:_titleArray.count/4 + 1];
    }else {
        [self setRow:_titleArray.count/4];
    }
    CGFloat iconX = 0;
    CGFloat iconY = 0;
    
    for(int i=0; i<titleArray.count; i++){
        iconX = (i % 4) * iconW + HotViewMargin;
        iconY = iconH * (i / 4);
        IconImageTextView *icon = nil;
        icon = [[IconImageTextView alloc] initWithFramAndImage:CGRectMake(iconX, iconY, iconW, iconH) title:titleArray[i] img:[UIImage imageNamed:_iconArray[i]]];
        icon.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconClick:)];
        [icon addGestureRecognizer:tap];
        
        [self addSubview:icon];
    }
    
}


- (void)setRow:(NSInteger)row{
    
    self.frame = CGRectMake(0, 0, BScreen_Width, iconH * row);
    _row = row;
}

- (void)iconClick:(UITapGestureRecognizer *)tap{
    
    if(_iconClick != nil){
        _iconClick(tap.view.tag);
    }
    
}

@end


@interface IconImageTextView ()

@property (nonatomic,copy) NSString *title,*img;
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *textLabel;
@property (nonatomic,copy)UIImage *placeholderImage;

@end

@implementation IconImageTextView

- (instancetype)initWithFramAndPlaceholderImage:(CGRect)frame placeholderImage:(UIImage *)placeholderImage title:(NSString *)title img:(NSString *)img{
    if (self = [super initWithFrame:frame]){
        
        _placeholderImage = placeholderImage;
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = NO;
        [self addSubview:_imageView];
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.userInteractionEnabled = NO;
        [_textLabel setTextColor:[UIColor blackColor]];
        [_textLabel setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightUltraLight]];
        [_textLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_textLabel];
        
        [_imageView sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:_placeholderImage];
        [_textLabel setText:title];
        
    }
    return self;
}

- (instancetype)initWithFramAndImage:(CGRect)frame title:(NSString *)title img:(UIImage *)img{
    if (self = [super initWithFrame:frame]){

        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = NO;
        [self addSubview:_imageView];
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.userInteractionEnabled = NO;
        [_textLabel setTextColor:[UIColor blackColor]];
        [_textLabel setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightUltraLight]];
        [_textLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_textLabel];
        
        [_imageView setImage:img];
        [_textLabel setText:title];
        
    }
    return self;
}

- (void)layoutSubviews{
    
    _imageView.frame = CGRectMake((self.frame.size.width - 40)/2,15, 40, 40);
    
    
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottomMargin.equalTo(_imageView).offset(20);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(self.bounds.size.width);
        make.height.mas_equalTo(20);
        
    }];
}


@end




