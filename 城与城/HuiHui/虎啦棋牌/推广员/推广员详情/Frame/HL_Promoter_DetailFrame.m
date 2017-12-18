//
//  HL_Promoter_DetailFrame.m
//  HuiHui
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_Promoter_DetailFrame.h"
#import "LJConst.h"
#import "HL_Promoter_DetailModel.h"

@implementation HL_Promoter_DetailFrame

-(void)setModel:(HL_Promoter_DetailModel *)model {
    
    _model = model;
    
    CGFloat titleX = _WindowViewWidth * 0.05;
    
    CGFloat titleY = 10;
    
    CGFloat titleW = _WindowViewWidth * 0.45;
    
    CGFloat titleH = 25;
    
    CGFloat contentX = _WindowViewWidth * 0.5;
    
    CGFloat contentY = titleY;
    
    CGFloat contentW = _WindowViewWidth * 0.45;
    
    CGFloat contentH = titleH;
    
    if ([model.type isEqualToString:@"1"]) {
        
        _titleF = CGRectMake(titleX, titleY, titleW, titleH);
        
        _content1F = CGRectMake(contentX, contentY, contentW, contentH);
        
        CGFloat lineX = 0;
        
        CGFloat lineY = CGRectGetMaxY(_titleF) + titleY;
        
        CGFloat lineW = _WindowViewWidth;
        
        CGFloat lineH = 1;

        _lineF = CGRectMake(lineX, lineY, lineW, lineH);
        
        _height = CGRectGetMaxY(_lineF);
        
    }else if ([model.type isEqualToString:@"2"]) {
        
        _titleF = CGRectMake(titleX, titleY, titleW, titleH);
        
        CGSize content1Size = [self sizeWithText:model.content1 font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(0, contentH)];
        
        CGFloat content1W = content1Size.width;
        
        CGSize content2Size = [self sizeWithText:model.content2 font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(0, contentH)];
        
        CGFloat content2W = content2Size.width;
        
        CGFloat content2X = _WindowViewWidth * 0.95 - content2W;
        
        CGFloat content1X = content2X - content1W - 10;
        
        _content1F = CGRectMake(content1X, contentY, content1W, contentH);
        
        _content2F = CGRectMake(content2X, contentY, content2W, contentH);
        
        CGFloat lineX = 0;
        
        CGFloat lineY = CGRectGetMaxY(_titleF) + titleY;
        
        CGFloat lineW = _WindowViewWidth;
        
        CGFloat lineH = 1;
        
        _lineF = CGRectMake(lineX, lineY, lineW, lineH);
        
        _height = CGRectGetMaxY(_lineF);
        
    }else if ([model.type isEqualToString:@"3"]) {
        
        _titleF = CGRectMake(titleX, titleY, titleW, titleH);
        
        _content1F = CGRectMake(contentX, contentY, contentW, contentH);
        
        CGFloat lineX = 0;
        
        CGFloat lineY = CGRectGetMaxY(_titleF) + titleY;
        
        CGFloat lineW = _WindowViewWidth;
        
        CGFloat lineH = 1;
        
        _lineF = CGRectMake(lineX, lineY, lineW, lineH);
        
        _height = CGRectGetMaxY(_lineF);
        
    }else if ([model.type isEqualToString:@"4"]) {

        _titleF = CGRectMake(titleX, titleY, titleW, titleH);
        
        CGFloat lineX = 0;
        
        CGFloat lineY = CGRectGetMaxY(_titleF) + titleY;
        
        CGFloat lineW = _WindowViewWidth;
        
        CGFloat lineH = 1;
        
        _lineF = CGRectMake(lineX, lineY, lineW, lineH);
        
        _height = CGRectGetMaxY(_lineF);
        
    }else if ([model.type isEqualToString:@"5"]) {
        
        CGFloat bgX = 0;
        
        CGFloat bgY = 0;
        
        CGFloat bgW = _WindowViewWidth;
        
        CGFloat bgH = 50;
        
        _deleteBGF = CGRectMake(bgX, bgY, bgW, bgH);
        
        CGFloat deleteX = 0;
        
        CGFloat deleteY = CGRectGetMaxY(_deleteBGF);
        
        CGFloat deleteW = _WindowViewWidth;
        
        CGFloat deleteH = 50;
        
        _deleteF = CGRectMake(deleteX, deleteY, deleteW, deleteH);
        
        _height = CGRectGetMaxY(_deleteF);
        
    }
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
