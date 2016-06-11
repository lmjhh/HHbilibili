//
//  NSString+Extension.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/19.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "NSDictionary+Extension.h"
#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)

- (NSString *)calcCount{
    
    double count = self.doubleValue;
    if(count > 10000){
        
        return [NSString stringWithFormat:@"%.1lf万",count/10000];
        
    }
    
    return [NSString stringWithFormat:@"%.0lf",count];
    
}

- (NSArray<NSString *>*)subStringsWithRegularExpression:(NSString*)regularExpression{
    NSRegularExpression* regu = [[NSRegularExpression alloc] initWithPattern:regularExpression options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray* objArr = [regu matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    if (objArr.count > 0) {
        NSMutableArray* returnArr = [NSMutableArray array];
        for (NSTextCheckingResult* rs in objArr) {
            [returnArr addObject:[self substringWithRange:rs.range]];
        }
        return [returnArr copy];
    }
    return nil;
}

+ (NSString*)signStringWithDic:(NSDictionary*)dic{
    //将字典键降序排列后转成md5
    return [self signStringWithString: [dic appendGetSortParameterWithBasePath:@""]];
}

+ (NSString*)signStringWithString:(NSString*)str{
    //开始md5转换
    const char *cStr = [[str stringByAppendingString: APPSEC] UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), result );
    
    NSMutableString *hash = [NSMutableString string];
    for(int i=0;i<CC_MD5_DIGEST_LENGTH;i++)
    {
        [hash appendFormat:@"%02X",result[i]];
    }
    return [hash lowercaseString];
}


@end
