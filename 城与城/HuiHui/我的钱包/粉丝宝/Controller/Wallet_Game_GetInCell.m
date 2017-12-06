//
//  Wallet_Game_GetInCell.m
//  HuiHui
//
//  Created by mac on 2017/9/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Wallet_Game_GetInCell.h"
#import "GameBtnCellModel.h"
#import "GameBtnCellFrame.h"
#import "LJConst.h"

@interface Wallet_Game_GetInCell ()

@property (nonatomic, weak) UILabel *gameTitleLab;

@property (nonatomic, weak) UIImageView *image1;

@property (nonatomic, weak) UIImageView *image2;

@property (nonatomic, weak) UIImageView *image3;

@property (nonatomic, weak) UIButton *game1Btn;

@property (nonatomic, weak) UIButton *game2Btn;

@property (nonatomic, weak) UIButton *game3Btn;

@end

@implementation Wallet_Game_GetInCell

+ (instancetype)Wallet_Game_GetInCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"Wallet_Game_GetInCell";
    
    Wallet_Game_GetInCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[Wallet_Game_GetInCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *title = [[UILabel alloc] init];
        
        self.gameTitleLab = title;
        
        title.font = GameCenterTitleFont;
        
        title.textColor = GameCenterTitleCOLOR;
        
        title.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:title];
        
        UIImageView *image1 = [[UIImageView alloc] init];
        
        self.image1 = image1;
        
        [self addSubview:image1];
        
        UIButton *game1 = [[UIButton alloc] init];
        
        self.game1Btn = game1;
        
        game1.tag = 0;
        
        [game1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:game1];
        
        UIImageView *image2 = [[UIImageView alloc] init];
        
        self.image2 = image2;
        
        [self addSubview:image2];
        
        UIButton *game2 = [[UIButton alloc] init];
        
        self.game2Btn = game2;
        
        game2.tag = 1;
        
        [game2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:game2];
        
        UIImageView *image3 = [[UIImageView alloc] init];
        
        self.image3 = image3;
        
        [self addSubview:image3];
        
        UIButton *game3 = [[UIButton alloc] init];
        
        self.game3Btn = game3;
        
        game3.tag = 2;
        
        [game3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:game3];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(GameBtnCellFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.gameTitleLab.frame = self.frameModel.titleF;
    
    self.image1.frame = self.frameModel.game1F;
    
    self.image2.frame = self.frameModel.game2F;
    
    self.image3.frame = self.frameModel.game3F;
    
    self.game1Btn.frame = self.frameModel.game1F;
    
    self.game2Btn.frame = self.frameModel.game2F;
    
    self.game3Btn.frame = self.frameModel.game3F;
    
}

- (void)setContent {
    
    GameBtnCellModel *model = self.frameModel.gameBtnCellModel;
    
    self.gameTitleLab.text = @"热游推荐";
    
    NSArray *array = model.games;
    
    if (array.count == 1) {
        
        NSDictionary *dd1 = array[0];
        
        [self.image1 setImageWithURL:[NSURL URLWithString:dd1[@"img"]] placeholderImage:[UIImage imageNamed:@""]];
        
    }else if (array.count == 2) {
        
        NSDictionary *dd1 = array[0];
        
        [self.image1 setImageWithURL:[NSURL URLWithString:dd1[@"img"]] placeholderImage:[UIImage imageNamed:@""]];
        
        NSDictionary *dd2 = array[1];
        
        [self.image2 setImageWithURL:[NSURL URLWithString:dd2[@"img"]] placeholderImage:[UIImage imageNamed:@""]];
        
    }else if (array.count == 3) {
        
        NSDictionary *dd1 = array[0];
        
        [self.image1 setImageWithURL:[NSURL URLWithString:dd1[@"img"]] placeholderImage:[UIImage imageNamed:@""]];
        
        NSDictionary *dd2 = array[1];
        
        [self.image2 setImageWithURL:[NSURL URLWithString:dd2[@"img"]] placeholderImage:[UIImage imageNamed:@""]];
        
        NSDictionary *dd3 = array[2];
        
        [self.image3 setImageWithURL:[NSURL URLWithString:dd3[@"img"]] placeholderImage:[UIImage imageNamed:@""]];
        
    }
    
}

- (void)btnClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(GameBtnClick:)]) {
        
        [self.delegate GameBtnClick:sender];
        
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
