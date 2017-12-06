//
//  RH_HomePersonHeadView.m
//  HuiHui
//
//  Created by mac on 2017/6/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_HomePersonHeadView.h"
#import "RH_HomeBtnView.h"
#import "RedHorseHeader.h"

@implementation RH_HomePersonHeadView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *top = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        
        top.backgroundColor = RH_ViewBGColor;
        
        [self addSubview:top];
        
        CGFloat margin = 30;
        
        CGFloat iconW = 80;
        
        CGFloat iconX = (ScreenWidth * 0.45 - iconW) * 0.5;
        
        CGFloat iconY = CGRectGetMaxY(top.frame) + margin;
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconW)];
        
        self.iconImg = icon;
        
        icon.layer.masksToBounds = YES;
        
        icon.layer.cornerRadius = iconW * 0.5;
        
        icon.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:icon];
        
//        CGSize editSize = [self sizeWithText:@"车辆" font:RH_PersonTitleFont maxSize:CGSizeMake(0,0)];
//        
//        UILabel *editLab = [[UILabel alloc] initWithFrame:CGRectMake(icon.center.x - editSize.width, CGRectGetMaxY(icon.frame) + 10, editSize.width, editSize.height)];
//        
//        self.editLab = editLab;
//        
//        editLab.textColor = RH_PersonTitleColor;
//        
//        editLab.font = RH_PersonTitleFont;
//        
//        editLab.text = @"车辆";
//        
//        [self addSubview:editLab];
        
//        UIImageView *editImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(editLab.frame) + 10, CGRectGetMaxY(icon.frame) + 10, editSize.height, editSize.height)];
//        
//        self.editImg = editImg;
//        
//        editImg.image = [UIImage imageNamed:@"RH_edit.png"];
//        
//        [self addSubview:editImg];
        
        UIButton *editBtn = [[UIButton alloc] initWithFrame:CGRectMake(iconX - 10, CGRectGetMaxY(icon.frame) + 10, iconW + 20, 20)];
        
        self.editBtn = editBtn;
        
        [editBtn setTitleColor:[UIColor darkTextColor] forState:0];
        
        [editBtn addTarget:self action:@selector(BtnClcik) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:editBtn];
        
        CGSize modelTitleSize = [self sizeWithText:@"车型：" font:RH_PersonTitleFont maxSize:CGSizeMake(0,0)];
        
        CGFloat modeltitleX = ScreenWidth * 0.45;
        
        CGFloat modeltitleY = CGRectGetMaxY(top.frame) + margin;
        
        CGFloat modeltitleW = modelTitleSize.width;
        
        CGFloat modeltitleH = modelTitleSize.height;
        
        UILabel *modeltitle = [[UILabel alloc] initWithFrame:CGRectMake(modeltitleX, modeltitleY, modeltitleW, modeltitleH)];
        
        self.modelTitleLab = modeltitle;
        
        modeltitle.font = RH_PersonTitleFont;
        
        modeltitle.textColor = RH_PersonTitleColor;
        
        modeltitle.text = @"车型：";
        
        [self addSubview:modeltitle];
        
        UILabel *model = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(modeltitle.frame), modeltitleY, ScreenWidth * 0.964 - CGRectGetMaxX(modeltitle.frame), modeltitleH)];
        
        self.modelLab = model;
        
        model.textColor = RH_PersonContentColor;
        
        model.font = RH_PersonContentFont;
        
        [self addSubview:model];
        
        CGFloat marHeight = (CGRectGetMaxY(editBtn.frame) - iconY - modeltitleH * 4) * 0.33333;
        
        CGSize lichengTitleSize = [self sizeWithText:@"入网时间：" font:RH_PersonTitleFont maxSize:CGSizeMake(0,0)];
        
        UILabel *lichengtitle = [[UILabel alloc] initWithFrame:CGRectMake(modeltitleX, CGRectGetMaxY(modeltitle.frame) + marHeight, lichengTitleSize.width, lichengTitleSize.height)];
        
        self.mileageTitleLab = lichengtitle;
        
        lichengtitle.font = RH_PersonTitleFont;
        
        lichengtitle.textColor = RH_PersonTitleColor;
        
        lichengtitle.text = @"入网时间：";
        
        [self addSubview:lichengtitle];
        
        UILabel *licheng = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lichengtitle.frame), CGRectGetMaxY(modeltitle.frame) + marHeight, ScreenWidth * 0.964 - CGRectGetMaxX(lichengtitle.frame), modeltitleH)];
        
        self.mileageLab = licheng;
        
        licheng.textColor = RH_PersonContentColor;
        
        licheng.font = RH_PersonContentFont;
        
        [self addSubview:licheng];
        
        CGSize timeTitleSize = [self sizeWithText:@"补贴金额：" font:RH_PersonTitleFont maxSize:CGSizeMake(0,0)];
        
        UILabel *timetitle = [[UILabel alloc] initWithFrame:CGRectMake(modeltitleX, CGRectGetMaxY(lichengtitle.frame) + marHeight, timeTitleSize.width, timeTitleSize.height)];
        
        self.timeTitleLab = timetitle;
        
        timetitle.font = RH_PersonTitleFont;
        
        timetitle.textColor = RH_PersonTitleColor;
        
        timetitle.text = @"补贴金额：";
        
        [self addSubview:timetitle];
        
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(timetitle.frame), CGRectGetMaxY(licheng.frame) + marHeight, ScreenWidth * 0.964 - CGRectGetMaxX(timetitle.frame), modeltitleH)];
        
        self.timeLab = time;
        
        time.textColor = RH_PersonContentColor;
        
        time.font = RH_PersonContentFont;
        
        [self addSubview:time];
        
        CGSize countTitleSize = [self sizeWithText:@"红包金额：" font:RH_PersonTitleFont maxSize:CGSizeMake(0,0)];
        
        UILabel *counttitle = [[UILabel alloc] initWithFrame:CGRectMake(modeltitleX, CGRectGetMaxY(timetitle.frame) + marHeight, countTitleSize.width, countTitleSize.height)];
        
        self.countTitleLab = counttitle;
        
        counttitle.font = RH_PersonTitleFont;
        
        counttitle.textColor = RH_PersonTitleColor;
        
        counttitle.text = @"红包金额：";
        
        [self addSubview:counttitle];
        
        UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(counttitle.frame), CGRectGetMaxY(time.frame) + marHeight, ScreenWidth * 0.964 - CGRectGetMaxX(counttitle.frame), modeltitleH)];
        
        self.countLab = count;
        
        count.textColor = RH_PersonContentColor;
        
        count.font = RH_PersonContentFont;
        
        [self addSubview:count];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(editBtn.frame) + margin, ScreenWidth, 15)];
        
        line.backgroundColor = RH_ViewBGColor;
        
        [self addSubview:line];
        
        CGFloat viewW = ScreenWidth * 0.33333;
        
        CGFloat viewH = 99;
        
        RH_HomeBtnView *youfei = [[RH_HomeBtnView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), viewW, viewH)];
        
        self.youfeiView = youfei;
        
        [self addSubview:youfei];
        
        RH_HomeBtnView *luntai = [[RH_HomeBtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(youfei.frame), CGRectGetMaxY(line.frame), viewW, viewH)];
        
        self.luntaiView = luntai;
        
        [self addSubview:luntai];
        
        RH_HomeBtnView *baoyang = [[RH_HomeBtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(luntai.frame), CGRectGetMaxY(line.frame), viewW, viewH)];
        
        self.baoyangView = baoyang;
        
        [self addSubview:baoyang];
        
        RH_HomeBtnView *xiuli = [[RH_HomeBtnView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(youfei.frame), viewW, viewH)];
        
        self.xiuliView = xiuli;
        
        [self addSubview:xiuli];
        
        RH_HomeBtnView *baoxian = [[RH_HomeBtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(youfei.frame), CGRectGetMaxY(luntai.frame), viewW, viewH)];
        
        self.baoxianView = baoxian;
        
        [self addSubview:baoxian];
        
        RH_HomeBtnView *shenghuo = [[RH_HomeBtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(luntai.frame), CGRectGetMaxY(baoyang.frame), viewW, viewH)];
        
        self.shenghuoView = shenghuo;
        
        [self addSubview:shenghuo];
        
        UILabel *bottom = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(shenghuo.frame) + 10, ScreenWidth, 15)];
        
        bottom.backgroundColor = RH_ViewBGColor;
        
        [self addSubview:bottom];
        
        self.height = CGRectGetMaxY(bottom.frame);
        
    }
    
    return self;
    
}

- (void)BtnClcik {

    if (self.EditBlock) {
        
        self.EditBlock();
        
    }
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
