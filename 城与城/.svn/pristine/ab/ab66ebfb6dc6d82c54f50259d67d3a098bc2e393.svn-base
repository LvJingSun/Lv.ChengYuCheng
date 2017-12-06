//
//  ImageCache.m
//  baozhifu
//
//  Created by mac on 13-8-24.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "ImageCache.h"
//#import "AppHttpClient.h"

static NSMutableDictionary *cache;

@implementation ImageCache

-(id)init {
    if (self = [super init]) {
        if (cache == nil) {
            cache = [[NSMutableDictionary alloc] init];
        }
    }
    return self;
}

- (void)addImage:(UIImage *)image andUrl:(NSString *)url {
    [cache setObject:image forKey:url];
}

- (UIImage *)getImage:(NSString *)url {
    UIImage *image = [cache objectForKey:url];
    
    return image;
}

@end
