//
//  T_ReleaseHeadView.m
//  HuiHui
//
//  Created by mac on 2017/3/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_ReleaseHeadView.h"

#define BlueTextCOLOR [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0]
#define TEXTCOLOR [UIColor colorWithRed:102/255.f green:102/255.f blue:102/255.f alpha:1.0]
#define T_HANGCOLOR [UIColor colorWithRed:255/255. green:100/255. blue:0/255. alpha:1.]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation T_ReleaseHeadView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, 20, SCREEN_WIDTH * 0.55, 30)];
        
        self.titleLab = title;
        
        title.text = @"今日需发布任务金额";
        
        title.textColor = TEXTCOLOR;
        
        title.font = [UIFont systemFontOfSize:18];
        
        [self addSubview:title];
        
        CGSize size = [self sizeWithText:@"元" font:[UIFont systemFontOfSize:18] maxSize:CGSizeMake(0, 30)];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.95 - size.width, 20, size.width, 30)];
        
        lab.textColor = TEXTCOLOR;
        
        lab.text = @"元";
        
        lab.font = [UIFont systemFontOfSize:18];
        
        [self addSubview:lab];
        
        UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(title.frame) + 5, 20, SCREEN_WIDTH * 0.95 - size.width - 5 - CGRectGetMaxX(title.frame) - 5, 30)];
        
        self.countLab = count;
        
        count.textColor = BlueTextCOLOR;
        
        count.textAlignment = NSTextAlignmentRight;
        
        count.font = [UIFont systemFontOfSize:20];
        
        count.text = @"0.00";
        
        [self addSubview:count];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, CGRectGetMaxY(title.frame) + 20, SCREEN_WIDTH * 0.9, 1)];
        
        line.backgroundColor = T_HANGCOLOR;
        
        [self addSubview:line];
        
        self.height = CGRectGetMaxY(line.frame);
        
    }
    
    return self;
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
