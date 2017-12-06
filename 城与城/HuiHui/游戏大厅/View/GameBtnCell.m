//
//  GameBtnCell.m
//  HuiHui
//
//  Created by mac on 2017/5/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameBtnCell.h"
#import "GameBtnCellModel.h"
#import "GameBtnCellFrame.h"
#import "LJConst.h"
#import "GameImageModel.h"

@interface GameBtnCell ()

@property (nonatomic, weak) UILabel *gameTitleLab;

@property (nonatomic, weak) UIImageView *image1;

@property (nonatomic, weak) UIImageView *image2;

@property (nonatomic, weak) UIImageView *image3;

@property (nonatomic, weak) UIButton *game1Btn;

@property (nonatomic, weak) UIButton *game2Btn;

@property (nonatomic, weak) UIButton *game3Btn;

@property (nonatomic, weak) UIImageView *image4;

@property (nonatomic, weak) UIImageView *image5;

@property (nonatomic, weak) UIImageView *image6;

@property (nonatomic, weak) UIButton *game4Btn;

@property (nonatomic, weak) UIButton *game5Btn;

@property (nonatomic, weak) UIButton *game6Btn;

@end

@implementation GameBtnCell

+ (instancetype)GameBtnCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"GameBtnCell";
    
    GameBtnCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[GameBtnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
        
        UIImageView *image4 = [[UIImageView alloc] init];
        
        self.image4 = image4;
        
        [self addSubview:image4];
        
        UIButton *game4 = [[UIButton alloc] init];
        
        self.game4Btn = game4;
        
        game4.tag = 3;
        
        [game4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:game4];
        
        UIImageView *image5 = [[UIImageView alloc] init];
        
        self.image5 = image5;
        
        [self addSubview:image5];
        
        UIButton *game5 = [[UIButton alloc] init];
        
        self.game5Btn = game5;
        
        game5.tag = 4;
        
        [game5 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:game5];
        
        UIImageView *image6 = [[UIImageView alloc] init];
        
        self.image6 = image6;
        
        [self addSubview:image6];
        
        UIButton *game6 = [[UIButton alloc] init];
        
        self.game6Btn = game6;
        
        game6.tag = 5;
        
        [game6 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:game6];
        
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
    
    self.image4.frame = self.frameModel.game4F;
    
    self.image5.frame = self.frameModel.game5F;
    
    self.image6.frame = self.frameModel.game6F;
    
    self.game1Btn.frame = self.frameModel.game1F;
    
    self.game2Btn.frame = self.frameModel.game2F;
    
    self.game3Btn.frame = self.frameModel.game3F;
    
    self.game4Btn.frame = self.frameModel.game4F;
    
    self.game5Btn.frame = self.frameModel.game5F;
    
    self.game6Btn.frame = self.frameModel.game6F;
    
}

- (void)setContent {
    
    GameBtnCellModel *model = self.frameModel.gameBtnCellModel;
    
    self.gameTitleLab.text = @"热游推荐";
    
    NSArray *array = model.games;
    
    NSLog(@"===%lu",(unsigned long)array.count);
    
    if (array.count == 1) {
        
        GameImageModel *image1 = array[0];
        
        [self.image1 setImageWithURL:[NSURL URLWithString:image1.GaneIcon] placeholderImage:[UIImage imageNamed:@""]];
        
    }else if (array.count == 2) {
    
        GameImageModel *image1 = array[0];
        
        [self.image1 setImageWithURL:[NSURL URLWithString:image1.GaneIcon] placeholderImage:[UIImage imageNamed:@""]];
        
        GameImageModel *image2 = array[1];
        
        [self.image2 setImageWithURL:[NSURL URLWithString:image2.GaneIcon] placeholderImage:[UIImage imageNamed:@""]];
        
    }else if (array.count == 3) {
        
        GameImageModel *image1 = array[0];
        
        [self.image1 setImageWithURL:[NSURL URLWithString:image1.GaneIcon] placeholderImage:[UIImage imageNamed:@""]];
        
        GameImageModel *image2 = array[1];
        
        [self.image2 setImageWithURL:[NSURL URLWithString:image2.GaneIcon] placeholderImage:[UIImage imageNamed:@""]];
        
        GameImageModel *image3 = array[2];
        
        [self.image3 setImageWithURL:[NSURL URLWithString:image3.GaneIcon] placeholderImage:[UIImage imageNamed:@""]];
        
    }else if (array.count == 4) {
        
        GameImageModel *image1 = array[0];
        
        [self.image1 setImageWithURL:[NSURL URLWithString:image1.GaneIcon] placeholderImage:[UIImage imageNamed:@""]];
        
        GameImageModel *image2 = array[1];
        
        [self.image2 setImageWithURL:[NSURL URLWithString:image2.GaneIcon] placeholderImage:[UIImage imageNamed:@""]];
        
        GameImageModel *image3 = array[2];
        
        [self.image3 setImageWithURL:[NSURL URLWithString:image3.GaneIcon] placeholderImage:[UIImage imageNamed:@""]];
        
        GameImageModel *image4 = array[3];
        
        [self.image4 setImageWithURL:[NSURL URLWithString:image4.GaneIcon] placeholderImage:[UIImage imageNamed:@""]];
        
    }else if (array.count == 5) {
        
        GameImageModel *image1 = array[0];
        
        [self.image1 setImageWithURL:[NSURL URLWithString:image1.GaneIcon] placeholderImage:[UIImage imageNamed:@""]];
        
        GameImageModel *image2 = array[1];
        
        [self.image2 setImageWithURL:[NSURL URLWithString:image2.GaneIcon] placeholderImage:[UIImage imageNamed:@""]];
        
        GameImageModel *image3 = array[2];
        
        [self.image3 setImageWithURL:[NSURL URLWithString:image3.GaneIcon] placeholderImage:[UIImage imageNamed:@""]];
        
        GameImageModel *image4 = array[3];
        
        [self.image4 setImageWithURL:[NSURL URLWithString:image4.GaneIcon] placeholderImage:[UIImage imageNamed:@""]];
        
        GameImageModel *image5 = array[4];
        
        [self.image5 setImageWithURL:[NSURL URLWithString:image5.GaneIcon] placeholderImage:[UIImage imageNamed:@""]];
        
    }else if (array.count == 6) {
        
        GameImageModel *image1 = array[0];
        
        [self.image1 setImageWithURL:[NSURL URLWithString:image1.GaneIcon] placeholderImage:[UIImage imageNamed:@""]];
        
        GameImageModel *image2 = array[1];
        
        [self.image2 setImageWithURL:[NSURL URLWithString:image2.GaneIcon] placeholderImage:[UIImage imageNamed:@""]];
        
        GameImageModel *image3 = array[2];
        
        [self.image3 setImageWithURL:[NSURL URLWithString:image3.GaneIcon] placeholderImage:[UIImage imageNamed:@""]];
        
        GameImageModel *image4 = array[3];
        
        [self.image4 setImageWithURL:[NSURL URLWithString:image4.GaneIcon] placeholderImage:[UIImage imageNamed:@""]];
        
        GameImageModel *image5 = array[4];
        
        [self.image5 setImageWithURL:[NSURL URLWithString:image5.GaneIcon] placeholderImage:[UIImage imageNamed:@""]];
        
        GameImageModel *image6 = array[5];
        
        [self.image6 setImageWithURL:[NSURL URLWithString:image6.GaneIcon] placeholderImage:[UIImage imageNamed:@""]];
        
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
