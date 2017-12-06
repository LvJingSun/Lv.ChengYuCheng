//
//  HomePushCell.m
//  HuiHui
//
//  Created by mac on 2017/9/5.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HomePushCell.h"
#import "RedHorseHeader.h"
#import "HomePushModel.h"
#import "HomePushFrame.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HomePushCell ()

@property (nonatomic, weak) UIView *lineView;

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *timeLab;

@property (nonatomic, weak) UILabel *resultLab;

@property (nonatomic, weak) UILabel *descLab;

@property (nonatomic, weak) UIImageView *contentImg;

@property (nonatomic, weak) UILabel *line;

@property (nonatomic, weak) UIButton *moreBtn;

@property (nonatomic, weak) UIButton *clickBtn;

@end

@implementation HomePushCell

+ (instancetype)HomePushCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"HomePushCell";
    
    HomePushCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[HomePushCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *lineview = [[UIView alloc] init];
        
        self.lineView = lineview;
        
        lineview.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        
        [self addSubview:lineview];
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.iconImg = icon;
        
        [self addSubview:icon];
        
        UILabel *rh_title = [[UILabel alloc] init];
        
        self.nameLab = rh_title;
        
        rh_title.textColor = Home_TitleTextColor;
        
        rh_title.font = Home_TitleTextFont;
        
        [self addSubview:rh_title];
        
        UILabel *time = [[UILabel alloc] init];
        
        self.timeLab = time;
        
        time.textColor = Home_TimeTextColor;
        
        time.font = Home_TimeTextFont;
        
        [self addSubview:time];
        
        UILabel *count1 = [[UILabel alloc] init];
        
        self.resultLab = count1;
        
        count1.textColor = [UIColor blackColor];
        
        count1.font = [UIFont systemFontOfSize:22];
        
        [self addSubview:count1];
        
        UILabel *count2 = [[UILabel alloc] init];
        
        self.descLab = count2;
        
        count2.textColor = Home_BuTieTextColor;
        
        count2.font = Home_BuTieTextFont;
        
        [self addSubview:count2];
        
        UIImageView *content = [[UIImageView alloc] init];
        
        self.contentImg = content;
        
        [self addSubview:content];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.line = line;
        
        line.backgroundColor = [UIColor colorWithRed:245/255. green:245/255. blue:245/255. alpha:1.];
        
        [self addSubview:line];
        
        UIButton *more = [[UIButton alloc] init];
        
        self.moreBtn = more;
        
        [more setTitleColor:Home_MoreTextColor forState:0];
        
        [self addSubview:more];
        
        UIButton *btn = [[UIButton alloc] init];
        
        self.clickBtn = btn;
        
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
    }
    
    return self;
    
}

- (void)btnClick {

    if (self.clickBlock) {
        
        self.clickBlock();
        
    }
    
}

-(void)setFrameModel:(HomePushFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    HomePushModel *model = self.frameModel.pushmodel;
    
    self.lineView.frame = self.frameModel.lineviewF;

    self.iconImg.frame = self.frameModel.iconF;
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.timeLab.frame = self.frameModel.timeF;
    
    if ([model.Type isEqualToString:@"4"] || [model.Type isEqualToString:@"5"]) {
    
        self.contentImg.frame = self.frameModel.contentImgF;
        
    }else {
    
        self.resultLab.frame = self.frameModel.resultF;
        
        self.descLab.frame = self.frameModel.descF;
        
    }

    self.line.frame = self.frameModel.lineF;
    
    self.moreBtn.frame = self.frameModel.moreBtnF;
    
    self.clickBtn.frame = self.frameModel.btnF;
    
}

- (void)setContent {

    HomePushModel *model = self.frameModel.pushmodel;
    
    [self.iconImg setImageWithURL:[NSURL URLWithString:model.Icon] placeholderImage:[UIImage imageNamed:@"RH_马.png"]];
    
    self.nameLab.text = model.Title;
    
    self.timeLab.text = model.Time;
    
    if ([model.Type isEqualToString:@"4"] || [model.Type isEqualToString:@"5"]) {
        
        [self.contentImg setImageWithURL:[NSURL URLWithString:model.ContentImg] placeholderImage:[UIImage imageNamed:@"RH_马.png"]];
        
    }else {
    
        self.resultLab.text = model.Result;
        
        self.descLab.text = model.Desc;
        
    }
    
    [self.moreBtn setTitle:@"立即查看" forState:0];
    
    if ([model.Type isEqualToString:@"2"]) {
        
        if ([model.ClassifyType isEqualToString:@"1"]) {
            
            [self.moreBtn setTitle:@"马上车生活" forState:0];
            
        }
        
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
