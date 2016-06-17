//
//  HomeTableHeadView.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/6.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomeData.h"
@class HomeTableHeadView;


typedef NS_ENUM(NSUInteger, HomeTabHeadViewButtonClickType) {
    HomeTabHeadViewButtonClickTypeFollow,
    HomeTabHeadViewButtonClickTypeCenter,
    HomeTabHeadViewButtonClickTypeSearch,
};




// - MARK: Delegate

@protocol HomeTableHeadViewDelegate <NSObject>

@required

-(void)tableHeadView:(HomeTableHeadView *)headView focusImageViewClick: (NSInteger) index;
-(void)tableHeadView:(HomeTableHeadView *)headView iconClick: (NSInteger) index;
-(void)tableHeadView:(HomeTableHeadView *)headView buttonClick: (HomeTabHeadViewButtonClickType) buttonClickType;


@end


@interface HomeTableHeadView : UIView

@property (nonatomic,strong) HomeData *headData;
@property (nonatomic,assign) id<HomeTableHeadViewDelegate> delegate;

- (instancetype) initWithFrame:(CGRect)frame;

@end
