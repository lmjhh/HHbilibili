//
//  Live_ColCollectionViewCell.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/13.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "Live_ColCollectionViewCell.h"
#import "DirectView.h"

@interface Live_ColCollectionViewCell ()

@property (nonatomic,strong) DirectView *directView;

@end


@implementation Live_ColCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self buildDirectView];
        
    }
    return self;
    
}

- (void)setData:(Lives *)data{
    
    [self.directView setData:data];
    
}

- (void)buildDirectView{
    
    CGFloat DirectH = (BScreen_Width)/2 * 0.63 + 49;
    CGFloat DirectW = (BScreen_Width)/2;
    CGFloat DirectX =  0;
    CGFloat DirectY =  0;
    self.directView = [[DirectView alloc] initWithFrame:CGRectMake(DirectX, DirectY, DirectW, DirectH)];
    [self.contentView addSubview:self.directView];
    
}

- (void)layoutSubviews{
    
    self.contentView.frame = CGRectMake(0, 0, BScreen_Width/2, self.directView.frame.size.height);
    
}

@end
