//
//  Add_ContactFrame.m
//  HuiHui
//
//  Created by mac on 2017/3/31.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Add_ContactFrame.h"
#import "Add_ContactModel.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define NameFont [UIFont systemFontOfSize:19]

@implementation Add_ContactFrame

-(void)setAdd_contact:(Add_ContactModel *)add_contact {

    _add_contact = add_contact;
    
    CGFloat iconX = SCREEN_WIDTH * 0.036;
    
    CGFloat iconY = 10;
    
    CGFloat iconW = 70;
    
    CGFloat iconH = iconW;
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    _height = CGRectGetMaxY(_iconF) + iconY;
    
    CGFloat nameX = CGRectGetMaxX(_iconF) + SCREEN_WIDTH * 0.036;

    CGFloat nameY = iconY;
    
    CGFloat nameH = 45;
    
    CGSize nameSize = [self sizeWithText:[NSString stringWithFormat:@"%@",add_contact.name] font:NameFont maxSize:CGSizeMake(0, nameH)];
    
    CGFloat nameW = nameSize.width;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat addW = 60;
    
    CGFloat addH = 30;
    
    CGFloat addX = SCREEN_WIDTH * 0.964 - addW;
    
    CGFloat addY = (_height - addH) * 0.5;
    
    _addF = CGRectMake(addX, addY, addW, addH);
    
    CGFloat nickX = CGRectGetMaxX(_nameF) + 5;
    
    CGFloat nickY = nameY;
    
    CGFloat nickW = addX - 5 - nickX;
    
    CGFloat nickH = nameH;
    
    _nickF = CGRectMake(nickX, nickY, nickW, nickH);
    
    CGFloat niX = nameX;
    
    CGFloat niY = CGRectGetMaxY(_nameF);
    
    CGFloat niW = addX - niX;
    
    CGFloat niH = 25;
    
    _phoneF = CGRectMake(niX, niY, niW, niH);
    
    CGFloat lineX = nameX;
    
    CGFloat lineY = _height - 1;
    
    CGFloat lineW = SCREEN_WIDTH - lineX;
    
    CGFloat lineH = 1;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
