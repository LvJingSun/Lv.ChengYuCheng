//
//  HL_MyInfoHeadView.m
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_MyInfoHeadView.h"
#import "LJConst.h"

@implementation HL_MyInfoHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        CGFloat Width = _WindowViewWidth;
        
        CGFloat Height = Width * 0.44;
        
        UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
        
        bg.image = [UIImage imageNamed:@"HL_MyInfo_BG.png"];
        
        [self addSubview:bg];
        
        CGFloat iconX = _WindowViewWidth * 0.1;
        
        CGFloat iconY = Height * 0.25;
        
        CGFloat iconW = Height * 0.5;
        
        CGFloat iconH = iconW;
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
        
        self.iconImg = icon;
        
        icon.layer.masksToBounds = YES;
        
        icon.layer.cornerRadius = iconW * 0.5;
        
        [self addSubview:icon];
        
        CGFloat nameX = CGRectGetMaxX(icon.frame) + _WindowViewWidth * 0.05;
        
        CGFloat nameY = iconY + 5;
        
        CGFloat nameW = _WindowViewWidth * 0.95 - nameX;
        
        CGFloat nameH = (iconH - 15) * 0.5;
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        
        self.nameLab = name;
        
        name.textColor = [UIColor whiteColor];
        
        name.font = [UIFont systemFontOfSize:18];
        
        [self addSubview:name];
        
        CGFloat bindX = nameX;

        CGFloat bindY = CGRectGetMaxY(name.frame) + 5;

        CGFloat bindH = nameH;
//
//        CGSize size = [self sizeWithText:@"未绑定游戏ID" font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(0, bindH)];
//
//        CGFloat bindW = size.width;
//
//        UIButton *bindBtn = [[UIButton alloc] initWithFrame:CGRectMake(bindX, bindY, bindW, bindH)];
//
//        self.bingBtn = bindBtn;
//
//        bindBtn.hidden = YES;
//
//        [self addSubview:bindBtn];
        
        UILabel *ID = [[UILabel alloc] initWithFrame:CGRectMake(bindX, bindY, nameW, bindH)];
        
        self.IDLab = ID;
        
        ID.textColor = [UIColor orangeColor];
        
        ID.font = [UIFont systemFontOfSize:17];
        
//        ID.hidden = YES;
        
        [self addSubview:ID];
        
//        CGFloat bgX = 0;
//
//        CGFloat bgY = Height * 0.6;
//
//        CGFloat bgW = Width;
//
//        CGFloat bgH = Height * 0.4;
//
//        UIView *zhezhaoView = [[UIView alloc] initWithFrame:CGRectMake(bgX, bgY, bgW, bgH)];
//
//        zhezhaoView.backgroundColor = [UIColor colorWithRed:255/255. green:255/255. blue:255/255. alpha:0.3];
//
//        [self addSubview:zhezhaoView];
//
//        UILabel *lineView = [[UILabel alloc] initWithFrame:CGRectMake((Width - 2) * 0.5, bgY, 2, bgH)];
//
//        lineView.backgroundColor = [UIColor whiteColor];
//
//        [self addSubview:lineView];
//
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bg.frame), Width, SectionHeight)];

        line.backgroundColor = FSB_ViewBGCOLOR;

        [self addSubview:line];
//
//        UILabel *roomcard = [[UILabel alloc] initWithFrame:CGRectMake(Width * 0.05, Height * 0.65, Width * 0.4, Height * 0.15)];
//
//        self.roomcard = roomcard;
//
//        roomcard.textColor = [UIColor whiteColor];
//
//        roomcard.font = [UIFont systemFontOfSize:18];
//
//        roomcard.textAlignment = NSTextAlignmentCenter;
//
//        [self addSubview:roomcard];
//
//        UILabel *title1 = [[UILabel alloc] initWithFrame:CGRectMake(Width * 0.05, Height * 0.8, Width * 0.4, Height * 0.15)];
//
//        title1.textAlignment = NSTextAlignmentCenter;
//
//        title1.textColor = [UIColor whiteColor];
//
//        title1.text = @"房卡";
//
//        title1.font = [UIFont systemFontOfSize:15];
//
//        [self addSubview:title1];
//
//        UILabel *yuanbao = [[UILabel alloc] initWithFrame:CGRectMake(Width * 0.55, Height * 0.65, Width * 0.4, Height * 0.15)];
//
//        self.yuanbao = yuanbao;
//
//        yuanbao.textColor = [UIColor whiteColor];
//
//        yuanbao.font = [UIFont systemFontOfSize:18];
//
//        yuanbao.textAlignment = NSTextAlignmentCenter;
//
//        [self addSubview:yuanbao];
//
//        UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(Width * 0.55, Height * 0.8, Width * 0.4, Height * 0.15)];
//
//        title2.textAlignment = NSTextAlignmentCenter;
//
//        title2.textColor = [UIColor whiteColor];
//
//        title2.text = @"元宝";
//
//        title2.font = [UIFont systemFontOfSize:15];
//
//        [self addSubview:title2];
        
        self.height = CGRectGetMaxY(line.frame);
        
    }
    
    return self;
    
}

//-(void)setType:(NSString *)type {
//
//    _type = type;
//
//    if ([type isEqualToString:@"0"]) {
//
//        //未绑定
//        self.bingBtn.hidden = NO;
//
//        [self.bingBtn setTitle:@"未绑定游戏ID" forState:0];
//
//        [self.bingBtn setTitleColor:[UIColor orangeColor] forState:0];
//
//        self.bingBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//
//    }else if ([type isEqualToString:@"1"]) {
//
//        //已绑定
//        self.IDLab.hidden = NO;
//
//    }
//
//}

//- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
//
//    NSDictionary *attrs = @{NSFontAttributeName : font};
//
//    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
//
//}

@end
