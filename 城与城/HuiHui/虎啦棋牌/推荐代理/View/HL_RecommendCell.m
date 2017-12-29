//
//  HL_RecommendCell.m
//  HuiHui
//
//  Created by mac on 2017/12/25.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_RecommendCell.h"
#import "LJConst.h"
#import "HL_RecommendModel.h"
#import "HL_RecommendFrame.h"

@interface HL_RecommendCell ()

@property (nonatomic, weak) UIView *bgView;

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UILabel *line1Lab;

@property (nonatomic, weak) UILabel *contentLab;

@property (nonatomic, weak) UILabel *line2Lab;

@property (nonatomic, weak) UIButton *QQBtn;

@property (nonatomic, weak) UIButton *QZoneBtn;

@property (nonatomic, weak) UIButton *WXBtn;

@property (nonatomic, weak) UIButton *CircleBtn;

@property (nonatomic, weak) UIButton *MessageBtn;

@property (nonatomic, weak) UIButton *CopyBtn;

@end

@implementation HL_RecommendCell

+ (instancetype)HL_RecommendCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"HL_RecommendCell";
    
    HL_RecommendCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[HL_RecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor colorWithRed:154/255. green:207/255. blue:233/255. alpha:1.];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *bg = [[UIView alloc] init];
        
        self.bgView = bg;
        
        bg.backgroundColor = [UIColor whiteColor];
        
        bg.layer.masksToBounds = YES;
        
        bg.layer.cornerRadius = 10;
        
        [self addSubview:bg];
        
        UILabel *title = [[UILabel alloc] init];
        
        self.titleLab = title;
        
        title.textAlignment = NSTextAlignmentCenter;
        
        title.font = [UIFont systemFontOfSize:16];
        
        title.textColor = [UIColor darkTextColor];
        
        [self addSubview:title];
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.iconImg = icon;
        
        [self addSubview:icon];
        
        UILabel *line1 = [[UILabel alloc] init];
        
        self.line1Lab = line1;
        
        line1.backgroundColor = [UIColor darkTextColor];
        
        [self addSubview:line1];
        
        UILabel *line2 = [[UILabel alloc] init];
        
        self.line2Lab = line2;
        
        line2.backgroundColor = [UIColor darkTextColor];
        
        [self addSubview:line2];
        
        UILabel *content = [[UILabel alloc] init];
        
        self.contentLab = content;
        
        content.textAlignment = NSTextAlignmentCenter;
        
        content.font = [UIFont systemFontOfSize:17];
        
        content.textColor = [UIColor darkTextColor];
        
        [self addSubview:content];
        
        UIButton *qq = [[UIButton alloc] init];
        
        self.QQBtn = qq;
        
        [self addSubview:qq];
        
        UIButton *qzone = [[UIButton alloc] init];
        
        self.QZoneBtn = qzone;
        
        [self addSubview:qzone];
        
        UIButton *wx = [[UIButton alloc] init];
        
        self.WXBtn = wx;
        
        [self addSubview:wx];
        
        UIButton *circle = [[UIButton alloc] init];
        
        self.CircleBtn = circle;
        
        [self addSubview:circle];
        
        UIButton *message = [[UIButton alloc] init];
        
        self.MessageBtn = message;
        
        [self addSubview:message];
        
        UIButton *copy = [[UIButton alloc] init];
        
        self.CopyBtn = copy;
        
        [self addSubview:copy];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(HL_RecommendFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.bgView.frame = self.frameModel.bgF;
    
    self.titleLab.frame = self.frameModel.titleF;
    
    self.iconImg.frame = self.frameModel.iconF;
    
    self.line1Lab.frame = self.frameModel.line1F;
    
    self.line2Lab.frame = self.frameModel.line2F;
    
    self.contentLab.frame = self.frameModel.contentF;
    
    self.QQBtn.frame = self.frameModel.QQF;
    
    self.QZoneBtn.frame = self.frameModel.QZoneF;
    
    self.WXBtn.frame = self.frameModel.WXF;
    
    self.CircleBtn.frame = self.frameModel.CircleF;
    
    self.MessageBtn.frame = self.frameModel.MessageF;
    
    self.CopyBtn.frame = self.frameModel.CopyF;
    
}

- (void)setContent {
    
    HL_RecommendModel *model = self.frameModel.model;
    
    self.titleLab.text = @"扫描加入团队";
    
    [self.iconImg setImageWithURL:[NSURL URLWithString:model.urlImg]];
    
    self.contentLab.text = @"分享";
    
    [self.QQBtn setImage:[UIImage imageNamed:@"share_QQ.png"] forState:0];
    
    [self.QQBtn addTarget:self action:@selector(qqClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.QZoneBtn setImage:[UIImage imageNamed:@"share_Qzone.png"] forState:0];
    
    [self.QZoneBtn addTarget:self action:@selector(qzoneClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.WXBtn setImage:[UIImage imageNamed:@"share_WX.png"] forState:0];
    
    [self.WXBtn addTarget:self action:@selector(wxClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.CircleBtn setImage:[UIImage imageNamed:@"share_Circle.png"] forState:0];
    
    [self.CircleBtn addTarget:self action:@selector(circleClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.MessageBtn setImage:[UIImage imageNamed:@"share_Message.png"] forState:0];
    
    [self.MessageBtn addTarget:self action:@selector(messageClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.CopyBtn setImage:[UIImage imageNamed:@"share_Copy.png"] forState:0];
    
    [self.CopyBtn addTarget:self action:@selector(copyClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)qqClick {
    
    if (self.QQBlock) {
        
        self.QQBlock();
        
    }
    
}

- (void)qzoneClick {
    
    if (self.QZoneBlock) {
        
        self.QZoneBlock();
        
    }
    
}

- (void)wxClick {
    
    if (self.WXBlock) {
        
        self.WXBlock();
        
    }
    
}

- (void)circleClick {
    
    if (self.CircleBlock) {
        
        self.CircleBlock();
        
    }
    
}

- (void)messageClick {
    
    if (self.MessageBlock) {
        
        self.MessageBlock();
        
    }
    
}

- (void)copyClick {
    
    if (self.CopyBlock) {
        
        self.CopyBlock();
        
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
