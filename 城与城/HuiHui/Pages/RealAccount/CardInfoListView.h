//
//  CardInfoListView.h
//  baozhifu
//
//  Created by mac on 13-7-23.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardInfoListView : UIView<UIAlertViewDelegate>

@property (assign, nonatomic) NSInteger index;

@property (strong, nonatomic) NSDictionary *bankInfo;

@property (weak, nonatomic) id rootViewController;

@property (weak, nonatomic) IBOutlet UILabel *m_statusLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_successOK;

- (void)setData:(NSDictionary *)bankData;

@end
