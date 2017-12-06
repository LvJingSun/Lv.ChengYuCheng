//
//  T_CommissionFrame.m
//  HuiHui
//
//  Created by mac on 2017/3/28.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_CommissionFrame.h"
#import "T_NewTask.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation T_CommissionFrame

-(void)setTaskModel:(T_NewTask *)taskModel {

    _taskModel = taskModel;
    
    CGFloat nameX = SCREEN_WIDTH * 0.1;
    
    CGFloat nameY = 20;
    
    CGFloat nameW = SCREEN_WIDTH * 0.8;
    
    CGFloat nameH = 40;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGSize size = [self sizeWithText:[NSString stringWithFormat:@"%@",taskModel.TaskDescription] font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(nameW, 0)];
    
    CGFloat descX = nameX;
    
    CGFloat descY = CGRectGetMaxY(_nameF) + 10;
    
    CGFloat descW = nameW;
    
    CGFloat descH = size.height;
    
    _descF = CGRectMake(descX, descY, descW, descH);
    
    CGFloat boX = SCREEN_WIDTH * 0.05;
    
    CGFloat boY = 10;
    
    CGFloat boW = SCREEN_WIDTH * 0.9;
    
    CGFloat boH = CGRectGetMaxY(_descF) + 10;
    
    _borderF = CGRectMake(boX, boY, boW, boH);
    
    CGSize biaotiSize = [self sizeWithText:@"任务佣金:" font:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(0, 30)];
    
    CGFloat biaotiX = SCREEN_WIDTH * 0.05;
    
    CGFloat biaotiY = CGRectGetMaxY(_borderF) + 30;
    
    CGFloat biaotiW = biaotiSize.width;
    
    CGFloat biaotiH = 30;
    
    _biaotiF = CGRectMake(biaotiX, biaotiY, biaotiW, biaotiH);
    
    CGFloat countX = CGRectGetMaxX(_biaotiF) + 10;
    
    CGFloat countY = biaotiY;
    
    CGFloat countW = SCREEN_WIDTH * 0.95 - countX;
    
    CGFloat countH = biaotiH;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat countLineX = countX;
    
    CGFloat countLineY = CGRectGetMaxY(_countF);
    
    CGFloat countLineW = countW;
    
    CGFloat countLineH = 1;
    
    _countLineF = CGRectMake(countLineX, countLineY, countLineW, countLineH);
    
    CGSize starSize = [self sizeWithText:@" * " font:[UIFont systemFontOfSize:18] maxSize:CGSizeMake(0, 20)];
    
    CGFloat starX = biaotiX;
    
    CGFloat starY = CGRectGetMaxY(_countLineF) + 10;
    
    CGFloat starW = starSize.width;
    
    CGFloat starH = 20;
    
    _starF = CGRectMake(starX, starY, starW, starH);
    
    CGFloat sDescX = CGRectGetMaxX(_starF);
    
    CGFloat sDescY = starY;
    
    CGFloat sDescW = SCREEN_WIDTH * 0.95 - sDescX;
    
    CGSize sDescSize = [self sizeWithText:@"每位任务伙伴完成任务后当天可获得的佣金（每日返利金额大于官方规定金额时需发布任务并邀请朋友完成）" font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(sDescW, 0)];
    
    CGFloat sDescH = sDescSize.height;
    
    _starDescF = CGRectMake(sDescX, sDescY, sDescW, sDescH);
    
    _height = CGRectGetMaxY(_starDescF) + 20;
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
