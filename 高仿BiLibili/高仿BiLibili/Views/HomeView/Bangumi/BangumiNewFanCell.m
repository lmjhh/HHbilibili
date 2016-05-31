//
//  BangumiNewFanCell.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/17.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "BangumiNewFanCell.h"
#import "NewFanView.h"

@interface BangumiNewFanCell ()
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleCountLabel;
@property (weak, nonatomic) IBOutlet UIView *titleView;

@end

@implementation BangumiNewFanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_titleLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightUltraLight]];
    [_titleCountLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightUltraLight]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreClick)];
    [_titleView addGestureRecognizer:tap];
    
    [self buildNewFanView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(LatestUpdate *)data{
    
    _data = data;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"今日更新 %@",_data.updateCount]];
    [attrStr addAttribute:NSForegroundColorAttributeName value:BMainColor range:NSMakeRange(5, _data.updateCount.length)];
    [_titleCountLabel setAttributedText:attrStr];

    for(int i = 0;i < self.subviews.count;i++){
        if([self.subviews[i] isKindOfClass:NewFanView.class]){
            NewFanView *newFan = self.subviews[i];
            [newFan setData:_data.list[newFan.tag]];
            
        }
    }
    
}


- (void)buildNewFanView{
    
    for(int i=0;i<6;i++){
        CGFloat NewFanH = (BScreen_Width - 10)/2 * 0.63 + 49;
        CGFloat NewFanW = (BScreen_Width -10)/2;
        CGFloat NewFanX = (i % 2) * NewFanW + 5;
        CGFloat NewFanY = NewFanH * (i / 2) + CGRectGetMaxY(_titleImage.frame) + 5;
        NewFanView  *newFanView = [[NewFanView alloc] initWithFrame:CGRectMake(NewFanX, NewFanY, NewFanW, NewFanH)];
        newFanView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(newFanViewClick:)];
        [newFanView addGestureRecognizer:tap];
        
        [self addSubview:newFanView];
    }
    
    
}

- (void)moreClick{
    
    [_delegate homeCellMoreClick:self];
    
}

- (void)newFanViewClick:(UITapGestureRecognizer *)tap{
    
    [_delegate homeCellContentClick:self index:tap.view.tag];
    
}

@end
