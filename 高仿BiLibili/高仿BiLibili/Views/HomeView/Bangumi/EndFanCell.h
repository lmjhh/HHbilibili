//
//  EndFanCell.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/17.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Home_DirectTableViewCell.h"

@interface EndFanCell : UITableViewCell

@property (nonatomic,strong) NSArray *data;
@property (nonatomic,assign) id<HomeCellDelegate>delegate;

@end
