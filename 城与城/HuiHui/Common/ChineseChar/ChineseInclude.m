//
//  ChineseInclude.m
//  Search
//
//  Created by LYZ on 14-1-24.
//  Copyright (c) 2014年 LYZ. All rights reserved.
//

#import "ChineseInclude.h"

@implementation ChineseInclude
+ (BOOL)isIncludeChineseInString:(NSString*)str {
    //NSLog(@"str is %@", str);
    for (int i=0; i<str.length; i++) {
        unichar ch = [str characterAtIndex:i];
        //NSLog(@"ch is %d", ch);
        if (0x4e00 < ch  && ch < 0x9fff) {
            return true;
        }
    }
    return false;
}
@end