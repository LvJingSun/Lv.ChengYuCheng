//
//  H_MyTeamHeadFrame.h
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class H_MyTeamHeadModel;

@interface H_MyTeamHeadFrame : NSObject

@property (nonatomic, assign) CGRect OneF;

@property (nonatomic, assign) CGRect TwoF;

@property (nonatomic, assign) CGRect ThreeF;

@property (nonatomic, assign) CGRect FourF;

@property (nonatomic, assign) CGRect huiyuanmingF;

@property (nonatomic, assign) CGRect jibieF;

@property (nonatomic, assign) CGRect renshuF;

@property (nonatomic, assign) CGRect shouyiF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) H_MyTeamHeadModel *headModel;

@end
