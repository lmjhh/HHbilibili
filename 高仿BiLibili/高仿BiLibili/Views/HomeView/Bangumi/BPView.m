//
//  BPView.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/30.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "BPView.h"

@interface BPView ()

@property (nonatomic,strong) BPData * data;
@property (nonatomic,strong) UIImageView *bpImageView;
@property (nonatomic,strong) UIButton *bpButton;
@property (nonatomic,strong) UILabel *bpLabel, *countLabel;
@property (nonatomic,strong) UIView *backView;

@end

@implementation BPView


- (instancetype) initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self buildBackView];
        [self buildImageView];
        [self buildLabel];
        [self buildButton];
        
    }
    
    return self;
    
}

- (void)setData:(BPData *) data count:(NSString * )count{
    
    if(data.mine == NO){
        
        [self.bpLabel setText:@"承包我呗！"];
        
    }
    
    [self.countLabel setText: [NSString stringWithFormat:@"%@人承包了第%@话",data.users,count]];
    
}


- (void)buildBackView{

    
    self.backView = [[UIView alloc] init];
    self.backView.layer.masksToBounds = true;
    self.backView.layer.cornerRadius = 25;
    self.backView.layer.borderWidth = 1;
    self.backView.layer.borderColor = [UIColor colorWithCustom:255 green:196 blue:2].CGColor;
    self.backView.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.backView];
    
    
}

- (void)buildImageView{
    
    self.bpImageView = [[UIImageView alloc] init];
    self.bpImageView.userInteractionEnabled = NO;
    self.bpImageView.image = [UIImage imageNamed:@"22chengbao_51x66"];
    
    [self addSubview:self.bpImageView];
}

- (void)buildLabel{
    
    self.bpLabel = [[UILabel alloc] init];
    self.bpLabel.userInteractionEnabled = NO;
    [self.bpLabel setFont:[UIFont systemFontOfSize:14]];
    [self.bpLabel setTextColor:BMainColor];
    
    [self.backView addSubview:self.bpLabel];
    
    self.countLabel = [[UILabel alloc] init];
    self.countLabel.userInteractionEnabled = NO;
    [self.countLabel setFont:[UIFont systemFontOfSize:12]];
    [self.countLabel setTextColor:BMainColor];
    
    [self.backView addSubview:self.countLabel];
    
    
}

- (void)buildButton{
    
    self.bpButton = [[UIButton alloc] init];
    [self.bpButton setImage:[UIImage imageNamed:@"hd_home_rank_30x30" ] forState:UIControlStateNormal];
    [self.bpButton setTitle:@"承包排行榜" forState:UIControlStateNormal];
    
    [self.backView addSubview:self.bpButton];
    
}

- (void)layoutSubviews{
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@50);
        
    }];
    
    [self.bpImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.mas_left).offset(10);
        make.bottom.equalTo(self.backView.mas_bottom).offset(-10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(60);
        
    }];
    
    [self.bpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.bpImageView.mas_right).offset(10);
        make.height.equalTo(@16);
        make.top.equalTo(self.backView.mas_top).offset(10);
        make.width.equalTo(self.backView.mas_width).multipliedBy(0.45);
        
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.bpLabel.mas_left);
        make.bottom.equalTo(self.bpImageView.mas_bottom).offset(1);
        make.height.equalTo(@16);
        make.width.equalTo(self.bpLabel.mas_width);
        
    }];
    
    [self.bpButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.backView.mas_right).offset(-10);
        make.centerY.equalTo(self.backView.mas_centerY);
        make.height.equalTo(@40);
        make.width.equalTo(@40);
        
    }];
    
    
    
}

@end
