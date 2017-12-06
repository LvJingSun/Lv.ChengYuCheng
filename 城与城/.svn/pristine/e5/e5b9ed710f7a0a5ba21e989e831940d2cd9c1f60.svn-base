//
//  HHImageManager+MJ.m
//  FingerNews
//
//  Created by mj on 13-9-23.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "HHImageManager+MJ.h"

@implementation HHImageManager (MJ)
+ (void)downloadWithURL:(NSURL *)url
{
    // cmp不能为空
    [[self sharedManager] downloadWithURL:url options:HHImageLowPriority|HHImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, HHImageType cacheType, BOOL finished) {
        
    }];
}
@end
