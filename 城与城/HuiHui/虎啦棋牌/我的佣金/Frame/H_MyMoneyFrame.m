//
//  H_MyMoneyFrame.m
//  HuiHui
//
//  Created by mac on 2017/11/3.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "H_MyMoneyFrame.h"
#import "H_MyMoneyModel.h"
#import "LJConst.h"

@implementation H_MyMoneyFrame

-(void)setModel:(H_MyMoneyModel *)model {
    
    _model = model;
    
    CGFloat Width = _WindowViewWidth * 0.25;
    
    CGFloat nameX = 0;
    
    CGFloat nameY = 0;
    
    CGFloat nameW = Width;
    
    CGFloat nameH = 40;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    _IDF = CGRectMake(CGRectGetMaxX(_nameF), nameY, nameW, nameH);
    
//    CGSize countSize = [self sizeWithText:model.count font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(0, nameH)];
    
    CGFloat countX = CGRectGetMaxX(_IDF);
    
    _countF = CGRectMake(countX, nameY, nameW, nameH);
    
//    CGSize statusSize = [self sizeWithText:@"已提取" font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(0, 25)];
//
//    CGFloat statusX = CGRectGetMaxX(_countF) + 5;
//
//    CGFloat statusY = 7.5;
//
//    CGFloat statusW = statusSize.width;
//
//    CGFloat statusH = 25;
//
//    _statusF = CGRectMake(statusX, statusY, statusW, statusH);
    
    CGFloat sourceX = CGRectGetMaxX(_countF);
    
    _sourceF = CGRectMake(sourceX, nameY, nameW, nameH);
    
    _lineF = CGRectMake(0, CGRectGetMaxY(_nameF), _WindowViewWidth, 1);
    
    _height = CGRectGetMaxY(_lineF);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
