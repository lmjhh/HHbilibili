//
//  Home_DirectTableViewCell.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/8.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeData.h"
@class Home_DirectTableViewCell;


@protocol HomeCellDelegate <NSObject>

@required
- (void) homeCellContentClick: (UITableViewCell*) cell index:(NSInteger) index;
- (void) homeCellMoreClick: (UITableViewCell*) cell;

@end


@interface Home_DirectTableViewCell : UITableViewCell

@property (nonatomic,strong) Partitions *data;
@property (nonatomic,assign) id<HomeCellDelegate>delegate;

@end
