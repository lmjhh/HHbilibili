//
//  VideoModel
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/20.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

@class CIDDataModel;
@class VideoDataModel;

@interface VideoModel : NSObject
@property (nonatomic, strong) NSMutableArray<VideoDataModel*>* durl;
@end

@interface VideoDataModel : NSObject
//视频长度
//@property (nonatomic, assign)NSInteger length;
@property (nonatomic, strong)NSString* url;
@property (nonatomic, strong)NSString* cid;
@property (nonatomic, strong)NSString* title;
@property (nonatomic, strong)NSArray<NSString*>* backup_url;
@end

@interface CIDModel : NSObject
@property (nonatomic, strong) NSArray<CIDDataModel*>* list;
@end

@interface CIDDataModel : NSObject
//@property (nonatomic, strong)NSString* Mp3Url;
//@property (nonatomic, strong)NSNumber* Mp3Click;
//@property (nonatomic, strong)NSNumber* Mp3Length;
//@property (nonatomic, strong)NSNumber* Mp4Click;
//@property (nonatomic, strong)NSString* Mp4Url;
//@property (nonatomic, assign)NSInteger Mp4Length;
//@property (nonatomic, strong)NSNumber* size;
//@property (nonatomic, strong)NSNumber* P;
@property (nonatomic, strong)NSString* AV;
@property (nonatomic, strong)NSString* Title;
@property (nonatomic, strong)NSString* CID;

@end

