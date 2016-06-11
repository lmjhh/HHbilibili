//
//  FanIntroductionView.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/6/1.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "FanIntroductionView.h"

@interface FanIntroductionView ()

@property (nonatomic,strong) UIView * moreBGView;
@property (nonatomic,strong) UILabel *introductionLabel;
@property (nonatomic,strong) UIScrollView *tagScrollView;

@end

@implementation FanIntroductionView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self bulidBGView];
        [self bulidIntroductionLabel];
        [self bulidScrollView];
        
    }
    return self;
    
}


- (void)setData:(NSString *)introductionContext tags:(NSArray *)tags{
    
    [self.introductionLabel setText:introductionContext];
    
    CGFloat iconH = 30,iconW = 80,iconX = 0,iconY = 0;
    CGFloat margin = 5;
    CGFloat sumDistance = 5;
    
    for(int i=0; i<tags.count;i++){
        
        NSString *buttontext = tags[i];
        CGSize sizeName = [buttontext sizeWithFont:[UIFont systemFontOfSize:15 weight:UIFontWeightUltraLight]constrainedToSize:CGSizeMake(MAXFLOAT, 0.0) lineBreakMode:NSLineBreakByWordWrapping];
        iconW = sizeName.width + 30;
        iconX = sumDistance + ((i-1)) * margin;
        iconY = 0;
        sumDistance += iconW;
        UIButton *icon = [[UIButton alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
        [icon addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [icon setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [icon.titleLabel setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightUltraLight]];
        [icon setBackgroundColor:[UIColor whiteColor]];
        [icon setTitle:buttontext forState:UIControlStateNormal];
        
        icon.layer.masksToBounds = YES;
        icon.layer.cornerRadius = 15;
        icon.layer.borderWidth = 0.5;
        icon.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        [self.tagScrollView addSubview:icon];

        
    }
    
    [self.tagScrollView setContentSize:CGSizeMake(sumDistance + 30, self.tagScrollView.frame.size.height)];
    
    [self layoutSubviews];
    
}

- (void)bulidBGView{
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BScreen_Width, 0.5)];
    [lineView setBackgroundColor:[UIColor colorWithCustomAndAlpha:120 green:120 blue:120 alpha:0.3]];
    [self addSubview:lineView];
    
    self.moreBGView = ({
        
        UIView *backView = [[UIView alloc] init];
        
        
        
        UILabel *backLabel = [[UILabel alloc] init];
        [backLabel setText:@"简介"];
        [backLabel setUserInteractionEnabled:NO];
        [backLabel setTextColor:[UIColor blackColor]];
        [backView addSubview:backLabel];
        [backLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(backView.mas_centerY);
            make.left.equalTo(@15);
            make.height.equalTo(@16);
            make.width.equalTo(@100);
            
        }];
        
        
        
        UIImageView *backImageView = [[UIImageView alloc] init];
        [backImageView setUserInteractionEnabled:NO];
        [backImageView setImage:[UIImage imageNamed:@"common_icon_arrow"]];
        [backView addSubview:backImageView];
        
        [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
          
            make.right.equalTo(@15);
            make.centerY.equalTo(backView.mas_centerY);
            make.width.equalTo(@15);
            make.height.equalTo(@15);
            
        }];
        
        UIGestureRecognizer *tap = [[UIGestureRecognizer alloc]initWithTarget:self action:@selector(moreClick)];
        [backView addGestureRecognizer:tap];
        
        backView;
    });
    
    [self addSubview:self.moreBGView];
    
}


- (void) bulidIntroductionLabel{
    
    self.introductionLabel = [[UILabel alloc] init];
    [self.introductionLabel setText:@"简介"];
    [self.introductionLabel setUserInteractionEnabled:NO];
    [self.introductionLabel setTextColor:[UIColor colorWithCustom:120 green:120 blue:120]];
    [self.introductionLabel setNumberOfLines:5];
    [self.introductionLabel setFont:[UIFont systemFontOfSize:11]];
    [self addSubview:self.introductionLabel];
    
}

- (void) bulidScrollView {
    
    self.tagScrollView = [[UIScrollView alloc] init];
    self.tagScrollView.showsVerticalScrollIndicator = NO;
    self.tagScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.tagScrollView];
    
}

- (void)layoutSubviews{
    
    [self.moreBGView setFrame:CGRectMake(0, 5, self.frame.size.width, 30)];
    CGSize labelSize = [self.introductionLabel boundingRectWithSize:CGSizeMake(self.frame.size.width - 30, 0)];
    [self.introductionLabel setFrame:CGRectMake(15, CGRectGetMaxY(self.moreBGView.frame) + 10, self.frame.size.width - 30, labelSize.height)];
    self.tagScrollView.frame = CGRectMake(15, CGRectGetMaxY(self.introductionLabel.frame) + 10, self.frame.size.width -15, 30);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(self.tagScrollView.frame));
    
    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%lf",CGRectGetMaxY(self.frame) + 10],@"height", nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"layoutHeadView" object:nil userInfo:data];
    
}


- (void)moreClick{

    
}

- (void)buttonClick:(UIButton *)btn{
    
}

@end
