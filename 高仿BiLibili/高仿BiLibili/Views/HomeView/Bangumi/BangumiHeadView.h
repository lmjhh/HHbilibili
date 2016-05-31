//
//  BangumiHeadView.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/16.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TheatreData.h"

@class BangumiHeadView;


typedef NS_ENUM(NSUInteger, BangumiHeadViewButtonClickType) {
    BangumiHeadViewButtonClickTypeFanchase,
    BangumiHeadViewButtonClickTypeServingtable,
    BangumiHeadViewButtonClickTypeIndex,
};


// - MARK: Delegate

@protocol BangumiHeadViewDelegate <NSObject>

@required

-(void)tableHeadView:(BangumiHeadView *)headView focusImageViewClick: (NSInteger) index;
-(void)tableHeadView:(BangumiHeadView *)headView iconClick: (NSInteger) index;
-(void)tableHeadView:(BangumiHeadView *)headView buttonClick: (BangumiHeadViewButtonClickType) buttonClickType;


@end


@interface BangumiHeadView : UIView

@property (nonatomic,strong)  TheatreData *headData;
@property (nonatomic,assign) id<BangumiHeadViewDelegate> delegate;

@end

@interface DoubleImageViewButton : UIButton

@property (nonatomic,strong) UIImageView *textImageView;
@property (nonatomic,assign) Boolean isWidth;

@end