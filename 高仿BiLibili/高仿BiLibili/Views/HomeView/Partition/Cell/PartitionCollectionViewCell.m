//
//  PartitionCollectionViewCell.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/6/17.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "PartitionCollectionViewCell.h"

@interface PartitionCollectionViewCell ()

@property (nonatomic,strong)  UIImageView *backImageView;
@property (nonatomic,strong)  UIImageView *iconImageView;
@property (nonatomic,strong)  UILabel *iconLabel;

@end

@implementation PartitionCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self buildUI];
        
    }
    
    return self;
    
}

- (void)setData:(NSString *) imageName iconName:(NSString *) iconName{
    
    self.iconImageView.image = [UIImage imageNamed:imageName];
    self.iconLabel.text = iconName;
    
}

-(void)buildUI{
    
    self.backImageView = [[UIImageView alloc] init];
    self.backImageView.userInteractionEnabled = NO;
    self.backImageView.image = [UIImage imageNamed:@"home_subregion_border_72x76_"];
    [self.contentView addSubview:self.backImageView];
    
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.userInteractionEnabled = NO;
    [self.backImageView addSubview:self.iconImageView];
    
    self.iconLabel = [[UILabel alloc] init];
    self.iconLabel.userInteractionEnabled = NO;
    self.iconLabel.textColor = [UIColor lightGrayColor];
    self.iconLabel.font = [UIFont systemFontOfSize:13];
    [self.iconLabel setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:self.iconLabel];
    
}

- (void)layoutSubviews{
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@76);
        make.width.equalTo(@72);
        
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.backImageView.mas_centerX);
        make.centerY.equalTo(self.backImageView.mas_centerY).offset(-3);
        make.height.equalTo(@35);
        make.width.equalTo(@35);
        
    }];
    
    [self.iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.backImageView.mas_bottom);
        make.centerX.equalTo(self.backImageView.mas_centerX);
        make.width.equalTo(self.backImageView.mas_width);
        make.height.equalTo(@16);
        
    }];
    
}

@end
