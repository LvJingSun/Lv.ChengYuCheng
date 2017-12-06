//
//  CustomAnnotation.h
//  HuiHui
//
//  Created by mac on 13-12-3.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "BMKAnnotation.h"

@interface CustomAnnotation : UIViewController<BMKAnnotation>{
    NSInteger pTag;
    CLLocationCoordinate2D  coordinate;
}

@property (nonatomic)   NSInteger  pTag;
@property (nonatomic,readwrite) CLLocationCoordinate2D      coordinate;

- (id)initWithLocation:(CLLocationCoordinate2D)coord;


@end
