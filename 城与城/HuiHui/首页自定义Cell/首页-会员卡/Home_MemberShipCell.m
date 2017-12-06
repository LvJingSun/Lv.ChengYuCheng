//
//  Home_MemberShipCell.m
//  HuiHui
//
//  Created by mac on 2017/8/9.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Home_MemberShipCell.h"
#import "Home_MemberShipModel.h"
#import "Home_MemberShipFrame.h"
#import "RedHorseHeader.h"

@interface Home_MemberShipCell ()

@property (nonatomic, weak) UIButton *memberShipBtn;

@property (nonatomic, weak) UIButton *dianDanBtn;

@end

@implementation Home_MemberShipCell

+ (instancetype)Home_MemberShipCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"Home_MemberShipCell";
    
    Home_MemberShipCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[Home_MemberShipCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIButton *member = [[UIButton alloc] init];
        
        self.memberShipBtn = member;
        
        [self addSubview:member];
        
        UIButton *diandan = [[UIButton alloc] init];
        
        self.dianDanBtn = diandan;
        
        [self addSubview:diandan];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(Home_MemberShipFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.memberShipBtn.frame = self.frameModel.memberF;
    
    self.dianDanBtn.frame = self.frameModel.diandanF;
    
}

- (void)setContent {

    Home_MemberShipModel *model = self.frameModel.cellModel;
    
    [self.memberShipBtn setImage:[UIImage imageNamed:model.membershipImg] forState:0];
    
    [self.memberShipBtn addTarget:self action:@selector(memberClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.dianDanBtn setImage:[UIImage imageNamed:model.diandanImg] forState:0];
    
    [self.dianDanBtn addTarget:self action:@selector(diandanClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)memberClick {

    if (self.memberShipBlock) {
        
        self.memberShipBlock();
        
    }
    
}

- (void)diandanClick {

    if (self.dianDanBlock) {
        
        self.dianDanBlock();
        
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
