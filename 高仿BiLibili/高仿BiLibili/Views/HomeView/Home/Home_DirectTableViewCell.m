//
//  Home_DirectTableViewCell.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/8.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "Home_DirectTableViewCell.h"
#import "DirectView.h"
#import "BiLiRefreshButton.h"


NSInteger refreshIndex = 1;


@interface Home_DirectTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (nonatomic,strong) BiLiRefreshButton *refreshButton;
@property (weak, nonatomic) IBOutlet UIView *TitleView;

@end

@implementation Home_DirectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_titleLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightUltraLight]];
    [_countLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightUltraLight]];
    [_moreButton.layer setMasksToBounds:YES];
    [_moreButton.layer setCornerRadius:6];
    [_moreButton.layer setBorderWidth:1];
    [_moreButton.layer setBorderColor: [UIColor colorWithCustom:235 green:235 blue:235].CGColor];
    [_moreButton.titleLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightUltraLight]];
    [_moreButton addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreClick)];
    [_TitleView addGestureRecognizer:tap];
    
    [self buildDirectView];
    [self buildRefreshButton];
    
}

- (void)setData:(Partitions *)data{
    _data = data;
    [_titleLabel setText:data.partition.name];
    [_titleImageVIew sd_setImageWithURL:[NSURL URLWithString:data.partition.sub_icon.src] placeholderImage:BPlachIcon];
    [_countLabel setText:@"进去看看"];
    if(data.partition.count > 0){
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"当前%ld个直播，进去看看",(long)data.partition.count]];
        NSString *count = [NSString stringWithFormat:@"%ld",(long)data.partition.count];
        [attrStr addAttribute:NSForegroundColorAttributeName value:BMainColor range:NSMakeRange(2, count.length)];
        [_countLabel setAttributedText:attrStr];
    }
    for(int i = 0;i < self.subviews.count;i++){
        if([self.subviews[i] isKindOfClass:DirectView.class]){
            DirectView *direct = self.subviews[i];
            [direct setData:_data.lives[direct.tag]];
        }
    }
    
}

- (void)buildDirectView{
    
    for(int i=0;i<4;i++){
        CGFloat DirectH = (BScreen_Width - 10)/2 * 0.63 + 49;
        CGFloat DirectW = (BScreen_Width -10)/2;
        CGFloat DirectX = (i % 2) * DirectW + 5;
        CGFloat DirectY = DirectH * (i / 2) + CGRectGetMaxY(_titleImageVIew.frame) + 5;
        DirectView *directView = [[DirectView alloc] initWithFrame:CGRectMake(DirectX, DirectY, DirectW, DirectH)];
        directView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(directViewClick:)];
        [directView addGestureRecognizer:tap];
        
        [self addSubview:directView];
    }
    
    
}


// MARK: - Action

- (void)buildRefreshButton{
    
    
    CGFloat buttonY = ((BScreen_Width - 10)/2 * 0.63 + 49) * 2 + CGRectGetMaxY(_TitleView.frame) + 6 ;
    
    _refreshButton = [[BiLiRefreshButton alloc] initWithFrame:CGRectMake((BScreen_Width -10)/2, buttonY, (BScreen_Width -10)/2, 40)];
    
    [_refreshButton addTarget:self action:@selector(refreshClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_refreshButton];
    
}


- (void)directViewClick:(UITapGestureRecognizer *)tap{
    
    DirectView *diect = (DirectView*)tap.view;
    
    NSInteger index = (refreshIndex - 1) * 4 + diect.tag;
    if(index > _data.lives.count) {
        index -= 4;
    }
    [_delegate homeCellContentClick:self index:index];
    
    
}

- (void)refreshClick{
    [_refreshButton startRefresh];
    [_refreshButton setUserInteractionEnabled:NO];
    if(refreshIndex > (_data.lives.count / 4) - 1 ){
        refreshIndex = 0;
    };
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,1.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        for(int i = 0;i < self.subviews.count;i++){
            if([self.subviews[i] isKindOfClass:DirectView.class]){
                DirectView *direct = self.subviews[i];
                
                NSInteger dataIndex = refreshIndex * 4 + direct.tag;
                if(dataIndex > _data.lives.count) {
                    dataIndex -= 4;
                }
                
                [direct setData:_data.lives[dataIndex]];
            }
        }
        refreshIndex++;
        
        [_refreshButton setUserInteractionEnabled:YES];
        [_refreshButton endRefresh];
    });
}

- (void)moreClick{
    
    [_delegate homeCellMoreClick:self];
    
}

@end
