//
//  AuthenticationCell.m
//  HuiHui
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "AuthenticationCell.h"
#import "LJConst.h"
#import "AuthenticationModel.h"
#import "AuthenticationFrame.h"

@interface AuthenticationCell ()

@property (nonatomic, weak) UILabel *faceTitleLab;

@property (nonatomic, weak) UIButton *faceImgBtn;

@property (nonatomic, weak) UILabel *backTitleLab;

@property (nonatomic, weak) UIButton *backImgBtn;

@property (nonatomic, weak) UIButton *sureBtn;

@end

@implementation AuthenticationCell

+ (instancetype)AuthenticationCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"AuthenticationCell";
    
    AuthenticationCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[AuthenticationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *facetitle = [[UILabel alloc] init];
        
        self.faceTitleLab = facetitle;
        
        facetitle.textAlignment = NSTextAlignmentCenter;
        
        facetitle.textColor = [UIColor blackColor];
        
        facetitle.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:facetitle];
        
        UIButton *faceImg = [[UIButton alloc] init];
        
        self.faceImgBtn = faceImg;
        
        faceImg.layer.masksToBounds = YES;
        
        faceImg.layer.cornerRadius = 4;
        
        [self addSubview:faceImg];
        
        UILabel *backtitle = [[UILabel alloc] init];
        
        self.backTitleLab = backtitle;
        
        backtitle.textAlignment = NSTextAlignmentCenter;
        
        backtitle.textColor = [UIColor blackColor];
        
        backtitle.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:backtitle];
        
        UIButton *backImg = [[UIButton alloc] init];
        
        self.backImgBtn = backImg;
        
        backImg.layer.masksToBounds = YES;
        
        backImg.layer.cornerRadius = 4;
        
        [self addSubview:backImg];
        
        UIButton *sure = [[UIButton alloc] init];
        
        self.sureBtn = sure;
        
        sure.backgroundColor = FSB_StyleCOLOR;
        
        [sure setTitleColor:[UIColor whiteColor] forState:0];
        
        sure.layer.masksToBounds = YES;
        
        sure.layer.cornerRadius = 4;
        
        [self addSubview:sure];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(AuthenticationFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.faceTitleLab.frame = self.frameModel.faceTitleF;
    
    self.faceImgBtn.frame = self.frameModel.faceImgF;
    
    self.backTitleLab.frame = self.frameModel.backTitleF;
    
    self.backImgBtn.frame = self.frameModel.backImgF;
    
    self.sureBtn.frame = self.frameModel.sureF;
    
}

- (void)setContent {

    AuthenticationModel *model = self.frameModel.authenModel;
    
    self.faceTitleLab.text = @"请选择身份证正面照片";
    
    if (model.faceImg == nil) {
        
        [self.faceImgBtn setImage:[UIImage imageNamed:@"身份上传 2.png"] forState:0];
        
    }else {
    
        [self.faceImgBtn setImage:model.faceImg forState:0];
        
    }
    
    [self.faceImgBtn addTarget:self action:@selector(faceImgClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.backTitleLab.text = @"请选择身份证反面照片";
    
    if (model.backImg == nil) {
        
        [self.backImgBtn setImage:[UIImage imageNamed:@"身份上传 2.png"] forState:0];
        
    }else {
        
        [self.backImgBtn setImage:model.backImg forState:0];
        
    }
    
    [self.backImgBtn addTarget:self action:@selector(backImgClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.sureBtn setTitle:@"确认" forState:0];
    
    [self.sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)faceImgClick {

    if (self.faceImgBlock) {
        
        self.faceImgBlock();
        
    }
    
}

- (void)backImgClick {

    if (self.backImgBlock) {
        
        self.backImgBlock();
        
    }
    
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
