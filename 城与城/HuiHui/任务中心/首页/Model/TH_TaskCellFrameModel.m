//
//  TH_TaskCellFrameModel.m
//  HuiHui
//
//  Created by mac on 2017/4/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "TH_TaskCellFrameModel.h"
#import "TH_TaskModel.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define TaskNameFont [UIFont systemFontOfSize:18]
#define TaskNameLabHeight 30.0f

@implementation TH_TaskCellFrameModel

-(void)setTaskmodel:(TH_TaskModel *)taskmodel {

    _taskmodel = taskmodel;
    
    if ([taskmodel.IsFriendsTaskOrMyTask isEqualToString:@"0"]) {
        
        //任务名字的frame
        
        CGSize size = [self sizeWithText:taskmodel.ReMemName font:TaskNameFont maxSize:CGSizeMake(0, 30)];
        
        CGFloat tasknameX = SCREEN_WIDTH * 0.05;
        
        CGFloat tasknameY = 10;
        
        CGFloat tasknameW = size.width;
        
        CGFloat tasknameH = TaskNameLabHeight;
        
        _TaskNameF = CGRectMake(tasknameX, tasknameY, tasknameW, tasknameH);
        
        //如果任务类型为0，则显示添加按钮
        
        CGFloat addW = TaskNameLabHeight;
        
        CGFloat addX = SCREEN_WIDTH * 0.95 - addW;
        
        CGFloat addY = tasknameY;
        
        CGFloat addH = TaskNameLabHeight;
        
        _AddF = CGRectMake(addX, addY, addW, addH);
        
    }else if ([taskmodel.IsFriendsTaskOrMyTask isEqualToString:@"1"]) {
    
        //任务名字的frame
        
        CGSize size = [self sizeWithText:taskmodel.TaskName font:TaskNameFont maxSize:CGSizeMake(0, 30)];
        
        CGFloat tasknameX = SCREEN_WIDTH * 0.05;
        
        CGFloat tasknameY = 10;
        
        CGFloat tasknameW = size.width;
        
        CGFloat tasknameH = TaskNameLabHeight;
        
        _TaskNameF = CGRectMake(tasknameX, tasknameY, tasknameW, tasknameH);
        
        //如果任务类型为1，则显示（好友任务）
        
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
    
    if ([taskmodel.IsFriendsTaskOrMyTask isEqualToString:@"0"]) {
    
        CGFloat personX = SCREEN_WIDTH * 0.05;
        
        CGFloat personY = CGRectGetMaxY(_LineF) + 5;
        
        CGFloat personW = SCREEN_WIDTH * 0.55;
        
        CGFloat personH = 20;
        
        _CompleteF = CGRectMake(personX, personY, personW, personH);
        
        CGFloat statusTitleX = SCREEN_WIDTH * 0.05;
        
        CGFloat statusTitleY = CGRectGetMaxY(_CompleteF) + 5;
        
        CGSize titleSize = [self sizeWithText:@"状态：" font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(0, 20)];
        
        CGFloat statusTitleW = titleSize.width;
        
        CGFloat statusTitleH = 20;
        
        _StatusTitleF = CGRectMake(statusTitleX, statusTitleY, statusTitleW, statusTitleH);
        
        CGFloat statusX = CGRectGetMaxX(_StatusTitleF);
        
        CGFloat statusY = statusTitleY;
        
        CGFloat statusW = SCREEN_WIDTH * 0.2;
        
        CGFloat statusH = 20;
        
        _StatusF = CGRectMake(statusX, statusY, statusW, statusH);
        
    }else if ([taskmodel.IsFriendsTaskOrMyTask isEqualToString:@"1"]) {
    
        CGFloat personX = SCREEN_WIDTH * 0.05;
        
        CGFloat personY = CGRectGetMaxY(_LineF) + 5;
        
        CGFloat personW = SCREEN_WIDTH * 0.55;
        
        CGFloat personH = 20;
        
        _PersonF = CGRectMake(personX, personY, personW, personH);
        
        CGFloat statusTitleX = SCREEN_WIDTH * 0.05;
        
        CGFloat statusTitleY = CGRectGetMaxY(_PersonF) + 5;
        
        CGSize titleSize = [self sizeWithText:@"状态：" font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(0, personH)];
        
        CGFloat statusTitleW = titleSize.width;
        
        CGFloat statusTitleH = personH;
        
        _StatusTitleF = CGRectMake(statusTitleX, statusTitleY, statusTitleW, statusTitleH);
        
        CGFloat statusX = CGRectGetMaxX(_StatusTitleF);
        
        CGFloat statusY = statusTitleY;
        
        CGFloat statusW = SCREEN_WIDTH * 0.2;
        
        CGFloat statusH = personH;
        
        _StatusF = CGRectMake(statusX, statusY, statusW, statusH);
        
        CGFloat countX = CGRectGetMaxX(_PersonF) + 10;
        
        CGFloat countY = personY;
        
        CGFloat countW = SCREEN_WIDTH * 0.95 - countX;
        
        CGFloat countH = 45;
        
        _CountF = CGRectMake(countX, countY, countW, countH);
        
    }
    
    CGFloat timeX = SCREEN_WIDTH * 0.05;
    
    CGFloat timeY = CGRectGetMaxY(_StatusTitleF) + 5;
    
    CGFloat timeW = SCREEN_WIDTH * 0.9;
    
    CGFloat timeH = 20;
    
    _TimeF = CGRectMake(timeX, timeY, timeW, timeH);
    
    _height = CGRectGetMaxY(_TimeF) + 20;
    
    CGFloat bottomX = 0;
    
    CGFloat bottomY = _height - 10;
    
    CGFloat bottomW = SCREEN_WIDTH;
    
    CGFloat bottomH = 10;
    
    _bottomF = CGRectMake(bottomX, bottomY, bottomW, bottomH);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
