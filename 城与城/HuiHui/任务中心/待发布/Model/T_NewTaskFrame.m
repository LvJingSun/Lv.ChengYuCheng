//
//  T_NewTaskFrame.m
//  HuiHui
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_NewTaskFrame.h"
#import "T_NewTask.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation T_NewTaskFrame

-(void)setTaskModel:(T_NewTask *)taskModel {

    _taskModel = taskModel;
    
    CGFloat nameX = SCREEN_WIDTH * 0.25;
    
    CGFloat nameY = 20;
    
    CGFloat nameW = SCREEN_WIDTH * 0.7;
    
    CGFloat nameH = 40;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGSize size = [self sizeWithText:[NSString stringWithFormat:@"%@",taskModel.TaskDescription] font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(nameW, 0)];
    
    CGFloat descX = nameX;
    
    CGFloat descY = CGRectGetMaxY(_nameF) + 10;
    
    CGFloat descW = nameW;
    
    CGFloat descH = size.height;
    
    _descF = CGRectMake(descX, descY, descW, descH);
    
    _height = CGRectGetMaxY(_descF) + 20;
    
    CGFloat lineX = SCREEN_WIDTH * 0.05;
    
    CGFloat lineY = _height - 1;
    
    CGFloat lineW = SCREEN_WIDTH * 0.95;
    
    CGFloat lineH = 1;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    CGFloat btnX = SCREEN_WIDTH * 0.05;
    
    CGFloat btnW = 40;
    
    CGFloat btnY = (_height - btnW) * 0.5;

    CGFloat btnH = btnW;
    
    _chooseBtnF = CGRectMake(btnX, btnY, btnW, btnH);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
