//
//  EndFanCell.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/17.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "EndFanCell.h"
#import "EndView.h"

@interface EndFanCell ()
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleCountLabel;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (strong,nonatomic) UIScrollView *scrollView;

@end


@implementation EndFanCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_titleLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightUltraLight]];
    [_titleCountLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightUltraLight]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreClick)];
    [_titleView addGestureRecognizer:tap];
    
    [self buildScrollView];
    [self buildEndViewView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setData:(NSArray *)data{
    
    _data = data;
    for(int i = 0;i < self.scrollView.subviews.count;i++){
        if([self.scrollView.subviews[i] isKindOfClass:EndView.class]){
            EndView *endView = self.scrollView.subviews[i];

            [endView setData:_data[endView.tag]];
            
        }
    }
    
    
    
}

- (void)buildScrollView{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleView.frame), BScreen_Width , (BScreen_Width/3 + 5)*1.31 + 49)];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [self addSubview:_scrollView];
    
    
}
- (void)buildEndViewView{
    
    for(int i=0;i<6;i++){
        CGFloat EndViewW = (BScreen_Width/3 + 5);
        CGFloat EndViewH = EndViewW*1.31 + 49;
        CGFloat EndViewX = (i % 6) * EndViewW + 5;
        CGFloat EndViewY = 0;
        EndView  *endView = [[EndView alloc] initWithFrame:CGRectMake(EndViewX, EndViewY, EndViewW, EndViewH)];
        endView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endViewViewClick:)];
        [endView addGestureRecognizer:tap];
        
        [_scrollView addSubview:endView];
    }
    
    [_scrollView setContentSize:CGSizeMake(6 * (BScreen_Width/3 + 5) + 10, (BScreen_Width/3 + 5)*1.31 + 49)];
    
    
}

- (void)moreClick{
    
    [_delegate homeCellMoreClick:self];
    
}

- (void)endViewViewClick:(UITapGestureRecognizer *)tap{
    
    [_delegate homeCellContentClick:self index:tap.view.tag];
    
}


@end
