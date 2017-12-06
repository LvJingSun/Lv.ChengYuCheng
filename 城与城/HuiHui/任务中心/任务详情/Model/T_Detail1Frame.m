//
//  T_Detail1Frame.m
//  HuiHui
//
//  Created by mac on 2017/3/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_Detail1Frame.h"
//#import "T_Task.h"
#import "TH_TaskModel.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define TaskNameFont [UIFont systemFontOfSize:22]
#define TaskNameLabHeight 40.0f

@implementation T_Detail1Frame

-(void)setTh_taskmodel:(TH_TaskModel *)th_taskmodel {

    _th_taskmodel = th_taskmodel;
    
    if ([th_taskmodel.IsFriendsTaskOrMyTask isEqualToString:@"0"]) {
        
        //任务名字的frame
        
        CGSize size = [self sizeWithText:th_taskmodel.ReMemName font:TaskNameFont maxSize:CGSizeMake(0, TaskNameLabHeight)];
        
        CGFloat tasknameX = SCREEN_WIDTH * 0.05;
        
        CGFloat tasknameY = 10;
        
        CGFloat tasknameW = size.width;
        
        CGFloat tasknameH = TaskNameLabHeight;
        
        _TaskNameF = CGRectMake(tasknameX, tasknameY, tasknameW, tasknameH);
        
    }else if ([th_taskmodel.IsFriendsTaskOrMyTask isEqualToString:@"1"]) {
    
        //任务名字的frame
        
        CGSize size = [self sizeWithText:th_taskmodel.TaskName font:TaskNameFont maxSize:CGSizeMake(0, TaskNameLabHeight)];
        
        CGFloat tasknameX = SCREEN_WIDTH * 0.05;
        
        CGFloat tasknameY = 10;
        
        CGFloat tasknameW = size.width;
        
        CGFloat tasknameH = TaskNameLabHeight;
        
        _TaskNameF = CGRectMake(tasknameX, tasknameY, tasknameW, tasknameH);
        
        //如果任务类型为0，则显示（好友任务）
        
        CGFloat typeX = CGRectGetMaxX(_TaskNameF) + 10;
        
        CGFloat typeY = tasknameY;
        
        CGFloat typeW = SCREEN_WIDTH * 0.95 - TaskNameLabHeight - 10 - typeX;
        
        CGFloat typeH = TaskNameLabHeight;
        
        _TaskTypeF = CGRectMake(typeX, typeY, typeW, typeH);
        
    }
    
    CGFloat lineX = SCREEN_WIDTH * 0.05;
    
    CGFloat lineY = CGRectGetMaxY(_TaskNameF) + 5;
    
    CGFloat lineW = SCREEN_WIDTH * 0.9;
    
    CGFloat lineH = 1;
    
    _LineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    CGFloat personX = SCREEN_WIDTH * 0.05;
    
    CGFloat personY = CGRectGetMaxY(_LineF) + 5;
    
    CGFloat personW = SCREEN_WIDTH * 0.55;
    
    CGFloat personH = 30;
    
    _PersonF = CGRectMake(personX, personY, personW, personH);
    
    CGFloat statusTitleX = SCREEN_WIDTH * 0.05;
    
    CGFloat statusTitleY = CGRectGetMaxY(_PersonF) + 5;
    
    CGSize titleSize = [self sizeWithText:@"状态：" font:[UIFont systemFontOfSize:18] maxSize:CGSizeMake(0, personH)];
    
    CGFloat statusTitleW = titleSize.width;
    
    CGFloat statusTitleH = personH;
    
    _StatusTitleF = CGRectMake(statusTitleX, statusTitleY, statusTitleW, statusTitleH);
    
    CGFloat statusX = CGRectGetMaxX(_StatusTitleF);
    
    CGFloat statusY = statusTitleY;
    
    CGFloat statusW = SCREEN_WIDTH * 0.2;
    
    CGFloat statusH = personH;
    
    _StatusF = CGRectMake(statusX, statusY, statusW, statusH);
    
    CGFloat timeX = SCREEN_WIDTH * 0.05;
    
    CGFloat timeY = CGRectGetMaxY(_StatusTitleF) + 5;
    
    CGFloat timeW = SCREEN_WIDTH * 0.55;
    
    CGFloat timeH = 30;
    
    _TimeF = CGRectMake(timeX, timeY, timeW, timeH);
    
    CGFloat countX = CGRectGetMaxX(_PersonF) + 20;
    
    CGFloat countY = personY + 10;
    
    CGFloat countW = SCREEN_WIDTH * 0.95 - countX;
    
    CGFloat countH = 60;
    
    _CountF = CGRectMake(countX, countY, countW, countH);
    
    _height = CGRectGetMaxY(_TimeF) + 10;
    
    CGFloat bottomX = 0;
    
    CGFloat bottomY = _height - 1;
    
    CGFloat bottomW = SCREEN_WIDTH;
    
    CGFloat bottomH = 1;
    
    _Line2F = CGRectMake(bottomX, bottomY, bottomW, bottomH);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
