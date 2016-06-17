//
//  DirectView.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/8.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeData.h"


@interface DirectView : UIView

- (void)setData:(Lives *)data;
- (Lives *)getData;

@end
