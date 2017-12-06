//
//  SureIDInfoCell.m
//  HuiHui
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "SureIDInfoCell.h"
#import "SureIDInfoFrame.h"
#import "LJConst.h"
#import "AuthenticationModel.h"

@interface SureIDInfoCell ()

@property (nonatomic, weak) UILabel *nameTitleLab;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *numTitleLab;

@property (nonatomic, weak) UILabel *numLab;

@property (nonatomic, weak) UILabel *dateTitleLab;

@property (nonatomic, weak) UILabel *dateLab;

@property (nonatomic, weak) UILabel *lineLab;

@property (nonatomic, weak) UILabel *facetitleLab;

@property (nonatomic, weak) UIImageView *faceImg;

@property (nonatomic, weak) UILabel *backtitleLab;

@property (nonatomic, weak) UIImageView *backImg;

@property (nonatomic, weak) UIView *bgView;

@property (nonatomic, weak) UIButton *sureBtn;

@end

@implementation SureIDInfoCell

+ (instancetype)SureIDInfoCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"SureIDInfoCell";
    
    SureIDInfoCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[SureIDInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *nametitle = [[UILabel alloc] init];
        
        self.nameTitleLab = nametitle;
        
        nametitle.textColor = [UIColor blackColor];
        
        nametitle.font = FSB_ConsumptionOrderStatusFont;
        
        [self addSubview:nametitle];
        
        UILabel *name = [[UILabel alloc] init];
        
        self.nameLab = name;
        
        name.textColor = [UIColor colorWithRed:128/255. green:126/255. blue:126/255. alpha:1.];
        
        name.font = FSB_ConsumptionOrderStatusFont;
        
        [self addSubview:name];
        
        UILabel *numtitle = [[UILabel alloc] init];
        
        self.numTitleLab = numtitle;
        
        numtitle.textColor = [UIColor blackColor];
        
        numtitle.font = FSB_ConsumptionOrderStatusFont;
        
        [self addSubview:numtitle];
        
        UILabel *num = [[UILabel alloc] init];
        
        self.numLab = num;
        
        num.textColor = [UIColor colorWithRed:128/255. green:126/255. blue:126/255. alpha:1.];
        
        num.font = FSB_ConsumptionOrderStatusFont;
        
        [self addSubview:num];
        
        UILabel *datetitle = [[UILabel alloc] init];
        
        self.dateTitleLab = datetitle;
        
        datetitle.textColor = [UIColor blackColor];
        
        datetitle.font = FSB_ConsumptionOrderStatusFont;
        
        [self addSubview:datetitle];
        
        UILabel *date = [[UILabel alloc] init];
        
        self.dateLab = date;
        
        date.textColor = [UIColor colorWithRed:128/255. green:126/255. blue:126/255. alpha:1.];
        
        date.font = FSB_ConsumptionOrderStatusFont;
        
        [self addSubview:date];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line];
        
        UILabel *facetitle = [[UILabel alloc] init];
        
        self.facetitleLab = facetitle;
        
        facetitle.textColor = [UIColor blackColor];
        
        facetitle.textAlignment = NSTextAlignmentCenter;
        
        facetitle.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:facetitle];
        
        UIImageView *face = [[UIImageView alloc] init];
        
        self.faceImg = face;
        
        face.layer.masksToBounds = YES;
        
        face.layer.cornerRadius = 5;
        
        [self addSubview:face];
        
        UILabel *backtitle = [[UILabel alloc] init];
        
        self.backtitleLab = backtitle;
        
        backtitle.textColor = [UIColor blackColor];
        
        backtitle.textAlignment = NSTextAlignmentCenter;
        
        backtitle.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:backtitle];
        
        UIImageView *back = [[UIImageView alloc] init];
        
        self.backImg = back;
        
        back.layer.masksToBounds = YES;
        
        back.layer.cornerRadius = 5;
        
        [self addSubview:back];
        
        UIView *bg = [[UIView alloc] init];
        
        self.bgView = bg;
        
        bg.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:bg];
        
        UIButton *sure = [[UIButton alloc] init];
        
        self.sureBtn = sure;
        
        sure.backgroundColor = FSB_StyleCOLOR;
        
        [sure setTitleColor:[UIColor whiteColor] forState:0];
        
        sure.layer.masksToBounds = YES;
        
        sure.layer.cornerRadius = 5;
        
        [self addSubview:sure];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(SureIDInfoFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.nameTitleLab.frame = self.frameModel.nameTitleF;
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.numTitleLab.frame = self.frameModel.numTitleF;
    
    self.numLab.frame = self.frameModel.numF;
    
    self.dateTitleLab.frame = self.frameModel.dateTitleF;
    
    self.dateLab.frame = self.frameModel.dateF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
    self.facetitleLab.frame = self.frameModel.faceTitleF;
    
    self.faceImg.frame = self.frameModel.faceF;
    
    self.backtitleLab.frame = self.frameModel.backTitleF;
    
    self.backImg.frame = self.frameModel.backF;
    
    self.bgView.frame = self.frameModel.sureBGF;
    
    self.sureBtn.frame = self.frameModel.sureF;
    
}

- (void)setContent {

    AuthenticationModel *model = self.frameModel.authModel;
    
    self.nameTitleLab.text = @"姓名：";
    
    self.numTitleLab.text = @"身份证号码：";
    
    self.dateTitleLab.text = @"有效期限：";
    
    self.nameLab.text = model.name;
    
    self.numLab.text = model.num;
    
    self.dateLab.text = [NSString stringWithFormat:@"%@-%@",model.start_date,model.end_date];
    
    self.facetitleLab.text = @"身份证正面";
    
    self.backtitleLab.text = @"身份证反面";
    
    self.faceImg.image = model.faceImg;
    
    self.backImg.image = model.backImg;
    
    [self.sureBtn setTitle:@"确认上传" forState:0];
    
    [self.sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)sureClick {

    if (self.sureBlock) {
        
        self.sureBlock();
        
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
