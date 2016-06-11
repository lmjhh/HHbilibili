//
//  FanDetailHeadView.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/18.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FanData.h"
#import "BPData.h"
#import "FanIntroductionView.h"
#import "VideoInfoButtonView.h"
#import "SelectVideoView.h"
#import "SelectSeasonsView.h"
#import "BPView.h"

typedef NS_ENUM(NSInteger,VideoInfoButtonViewType){
    
    VideoInfoButtonViewTypeShare,
    VideoInfoButtonViewTypeChaseFan,
    VideoInfoButtonViewTypeDownLoad
    
};


@protocol FanDetailDelegate <NSObject>

@required
- (void)fanDetailTitleButtonClick:(VideoInfoButtonViewType )type;
- (void)fanDetailSelectVideoClick:(NSInteger )index;
- (void)backButtonClick;
@optional
- (void)fanDetailSelectSeasonClick:(NSString *)seasonId;

@end


@interface FanDetailHeadView : UIView

@property (nonatomic,strong)id<FanDetailDelegate> delegate;
- (void)setData:(FanData *)data isUpdateSeason:(BOOL)isUpdateSeason;
- (void)setBpdata:(BPData *)bpdata count:(NSString * )count;


@end
