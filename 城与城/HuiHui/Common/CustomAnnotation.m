//
//  CustomAnnotation.m
//  HuiHui
//
//  Created by mac on 13-12-3.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "CustomAnnotation.h"

@interface CustomAnnotation ()

@end

@implementation CustomAnnotation

@synthesize pTag;
@synthesize coordinate;

- (id)initWithLocation:(CLLocationCoordinate2D)coord
{
	self = [super init];
    if (self) {
        coordinate = coord;
    }
    
    return self;
}

@end
