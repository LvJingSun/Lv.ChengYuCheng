//
//  HL_NoticeCell.m
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_NoticeCell.h"
#import "LJConst.h"
#import "HL_NoticeModel.h"
#import "HL_NoticeFrame.h"

@interface HL_NoticeCell ()

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UILabel *notice1Lab;

@property (nonatomic, weak) UILabel *notice2Lab;

@property (nonatomic, weak) UILabel *upLineLab;

@property (nonatomic, weak) UILabel *bottomLineLab;

@property (nonatomic, weak) UIImageView *img;

@property (nonatomic, weak) UIButton *notice1Btn;

@property (nonatomic, weak) UIButton *notice2Btn;

@end

@implementation HL_NoticeCell

+ (instancetype)HL_NoticeCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"HL_NoticeCell";
    
    HL_NoticeCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[HL_NoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *upline = [[UILabel alloc] init];
        
        self.upLineLab = upline;
        
        upline.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:upline];
        
        UILabel *title = [[UILabel alloc] init];
        
        self.titleLab = title;
        
        title.textColor = [UIColor orangeColor];
        
        title.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:title];
        
        UILabel *notice1 = [[UILabel alloc] init];
        
        self.notice1Lab = notice1;
        
        notice1.textColor = [UIColor darkTextColor];
        
        notice1.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:notice1];
        
        UIButton *notice1Btn = [[UIButton alloc] init];
        
        self.notice1Btn = notice1Btn;
        
        [self addSubview:notice1Btn];
        
        UILabel *notice2 = [[UILabel alloc] init];
        
        self.notice2Lab = notice2;
        
        notice2.textColor = [UIColor darkTextColor];
        
        notice2.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:notice2];
        
        UIButton *notice2Btn = [[UIButton alloc] init];
        
        self.notice2Btn = notice2Btn;
        
        [self addSubview:notice2Btn];
        
        UIImageView *img = [[UIImageView alloc] init];
        
        self.img = img;
        
        img.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:img];
        
        UILabel *boline = [[UILabel alloc] init];
        
        self.bottomLineLab = boline;
        
        boline.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:boline];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(HL_NoticeFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.upLineLab.frame = self.frameModel.upLineF;
    
    self.titleLab.frame = self.frameModel.titleF;
    
    self.notice1Lab.frame = self.frameModel.notice1F;
    
    self.notice1Btn.frame = self.frameModel.notice1F;
    
    self.notice2Lab.frame = self.frameModel.notice2F;
    
    self.notice2Btn.frame = self.frameModel.notice2F;
    
    self.img.frame = self.frameModel.imgF;
    
    self.bottomLineLab.frame = self.frameModel.bottomLineF;
    
}

- (void)setContent {
    
    HL_NoticeModel *model = self.frameModel.noticeModel;
    
    self.titleLab.text = model.title;
    
    self.notice1Lab.text = model.notice1;
    
    self.notice2Lab.text = model.notice2;
    
    [self.img setImageWithURL:[NSURL URLWithString:model.imgUrl]];
    
    [self.notice1Btn addTarget:self action:@selector(notice1Click) forControlEvents:UIControlEventTouchUpInside];
    
    [self.notice2Btn addTarget:self action:@selector(notice2Click) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)notice1Click {
    
    if (self.notice1Block) {
        
        self.notice1Block();
        
    }
    
}

- (void)notice2Click {
    
    if (self.notice2Block) {
        
        self.notice2Block();
        
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
