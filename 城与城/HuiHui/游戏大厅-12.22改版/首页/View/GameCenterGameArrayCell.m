//
//  GameCenterGameArrayCell.m
//  HuiHui
//
//  Created by mac on 2017/12/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameCenterGameArrayCell.h"
#import "GameCenterGameArrayModel.h"
#import "GameCenterGameArrayFrame.h"
#import "LJConst.h"
#import "GameCenterGameBtnView.h"
#import "GameCenterGameModel.h"

@interface GameCenterGameArrayCell ()

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) GameCenterGameBtnView *game1View;

@property (nonatomic, weak) GameCenterGameBtnView *game2View;

@property (nonatomic, weak) GameCenterGameBtnView *game3View;

@property (nonatomic, weak) GameCenterGameBtnView *game4View;

@property (nonatomic, weak) GameCenterGameBtnView *game5View;

@property (nonatomic, weak) GameCenterGameBtnView *game6View;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation GameCenterGameArrayCell

+ (instancetype)GameCenterGameArrayCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"GameCenterGameArrayCell";
    
    GameCenterGameArrayCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[GameCenterGameArrayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *title = [[UILabel alloc] init];
        
        self.titleLab = title;
        
        title.textColor = [UIColor darkTextColor];
        
        title.font = [UIFont systemFontOfSize:16];
        
        title.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:title];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(GameCenterGameArrayFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.titleLab.frame = self.frameModel.titleF;
    
    if (self.frameModel.arrayModel.gameArray.count == 1) {
        
        GameCenterGameBtnView *game1 = [[GameCenterGameBtnView alloc] initWithFrame:self.frameModel.game1F];
        
        self.game1View = game1;
        
        [self addSubview:game1];
        
    }else if (self.frameModel.arrayModel.gameArray.count == 2) {
        
        GameCenterGameBtnView *game1 = [[GameCenterGameBtnView alloc] initWithFrame:self.frameModel.game1F];
        
        self.game1View = game1;
        
        [self addSubview:game1];
        
        GameCenterGameBtnView *game2 = [[GameCenterGameBtnView alloc] initWithFrame:self.frameModel.game2F];
        
        self.game2View = game2;
        
        [self addSubview:game2];
        
    }else if (self.frameModel.arrayModel.gameArray.count == 3) {
        
        GameCenterGameBtnView *game1 = [[GameCenterGameBtnView alloc] initWithFrame:self.frameModel.game1F];
        
        self.game1View = game1;
        
        [self addSubview:game1];
        
        GameCenterGameBtnView *game2 = [[GameCenterGameBtnView alloc] initWithFrame:self.frameModel.game2F];
        
        self.game2View = game2;
        
        [self addSubview:game2];
        
        GameCenterGameBtnView *game3 = [[GameCenterGameBtnView alloc] initWithFrame:self.frameModel.game3F];
        
        self.game3View = game3;
        
        [self addSubview:game3];
        
    }else if (self.frameModel.arrayModel.gameArray.count == 4) {
        
        GameCenterGameBtnView *game1 = [[GameCenterGameBtnView alloc] initWithFrame:self.frameModel.game1F];
        
        self.game1View = game1;
        
        [self addSubview:game1];
        
        GameCenterGameBtnView *game2 = [[GameCenterGameBtnView alloc] initWithFrame:self.frameModel.game2F];
        
        self.game2View = game2;
        
        [self addSubview:game2];
        
        GameCenterGameBtnView *game3 = [[GameCenterGameBtnView alloc] initWithFrame:self.frameModel.game3F];
        
        self.game3View = game3;
        
        [self addSubview:game3];
        
        GameCenterGameBtnView *game4 = [[GameCenterGameBtnView alloc] initWithFrame:self.frameModel.game4F];
        
        self.game4View = game4;
        
        [self addSubview:game4];
        
    }else if (self.frameModel.arrayModel.gameArray.count == 5) {
        
        GameCenterGameBtnView *game1 = [[GameCenterGameBtnView alloc] initWithFrame:self.frameModel.game1F];
        
        self.game1View = game1;
        
        [self addSubview:game1];
        
        GameCenterGameBtnView *game2 = [[GameCenterGameBtnView alloc] initWithFrame:self.frameModel.game2F];
        
        self.game2View = game2;
        
        [self addSubview:game2];
        
        GameCenterGameBtnView *game3 = [[GameCenterGameBtnView alloc] initWithFrame:self.frameModel.game3F];
        
        self.game3View = game3;
        
        [self addSubview:game3];
        
        GameCenterGameBtnView *game4 = [[GameCenterGameBtnView alloc] initWithFrame:self.frameModel.game4F];
        
        self.game4View = game4;
        
        [self addSubview:game4];
        
        GameCenterGameBtnView *game5 = [[GameCenterGameBtnView alloc] initWithFrame:self.frameModel.game5F];
        
        self.game5View = game5;
        
        [self addSubview:game5];
        
    }else if (self.frameModel.arrayModel.gameArray.count == 6) {
        
        GameCenterGameBtnView *game1 = [[GameCenterGameBtnView alloc] initWithFrame:self.frameModel.game1F];
        
        self.game1View = game1;
        
        [self addSubview:game1];
        
        GameCenterGameBtnView *game2 = [[GameCenterGameBtnView alloc] initWithFrame:self.frameModel.game2F];
        
        self.game2View = game2;
        
        [self addSubview:game2];
        
        GameCenterGameBtnView *game3 = [[GameCenterGameBtnView alloc] initWithFrame:self.frameModel.game3F];
        
        self.game3View = game3;
        
        [self addSubview:game3];
        
        GameCenterGameBtnView *game4 = [[GameCenterGameBtnView alloc] initWithFrame:self.frameModel.game4F];
        
        self.game4View = game4;
        
        [self addSubview:game4];
        
        GameCenterGameBtnView *game5 = [[GameCenterGameBtnView alloc] initWithFrame:self.frameModel.game5F];
        
        self.game5View = game5;
        
        [self addSubview:game5];
        
        GameCenterGameBtnView *game6 = [[GameCenterGameBtnView alloc] initWithFrame:self.frameModel.game6F];
        
        self.game6View = game6;
        
        [self addSubview:game6];
        
    }
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    self.titleLab.text = @"热门游戏";
    
    if (self.frameModel.arrayModel.gameArray.count == 1) {
        
        GameCenterGameModel *model1 = self.frameModel.arrayModel.gameArray[0];
        
        [self.game1View.iconImg setImageWithURL:[NSURL URLWithString:model1.iconUrl]];
        
        self.game1View.titleLab.text = model1.gameName;
        
        [self.game1View.clickBtn addTarget:self action:@selector(game1Click) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (self.frameModel.arrayModel.gameArray.count == 2) {
        
        GameCenterGameModel *model1 = self.frameModel.arrayModel.gameArray[0];
        
        [self.game1View.iconImg setImageWithURL:[NSURL URLWithString:model1.iconUrl]];
        
        self.game1View.titleLab.text = model1.gameName;
        
        GameCenterGameModel *model2 = self.frameModel.arrayModel.gameArray[1];
        
        [self.game2View.iconImg setImageWithURL:[NSURL URLWithString:model2.iconUrl]];
        
        self.game2View.titleLab.text = model2.gameName;
        
        [self.game1View.clickBtn addTarget:self action:@selector(game1Click) forControlEvents:UIControlEventTouchUpInside];
        
        [self.game2View.clickBtn addTarget:self action:@selector(game2Click) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (self.frameModel.arrayModel.gameArray.count == 3) {
        
        GameCenterGameModel *model1 = self.frameModel.arrayModel.gameArray[0];
        
        [self.game1View.iconImg setImageWithURL:[NSURL URLWithString:model1.iconUrl]];
        
        self.game1View.titleLab.text = model1.gameName;
        
        GameCenterGameModel *model2 = self.frameModel.arrayModel.gameArray[1];
        
        [self.game2View.iconImg setImageWithURL:[NSURL URLWithString:model2.iconUrl]];
        
        self.game2View.titleLab.text = model2.gameName;
        
        GameCenterGameModel *model3 = self.frameModel.arrayModel.gameArray[2];
        
        [self.game3View.iconImg setImageWithURL:[NSURL URLWithString:model3.iconUrl]];
        
        self.game3View.titleLab.text = model3.gameName;
        
        [self.game1View.clickBtn addTarget:self action:@selector(game1Click) forControlEvents:UIControlEventTouchUpInside];
        
        [self.game2View.clickBtn addTarget:self action:@selector(game2Click) forControlEvents:UIControlEventTouchUpInside];
        
        [self.game3View.clickBtn addTarget:self action:@selector(game3Click) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (self.frameModel.arrayModel.gameArray.count == 4) {
        
        GameCenterGameModel *model1 = self.frameModel.arrayModel.gameArray[0];
        
        [self.game1View.iconImg setImageWithURL:[NSURL URLWithString:model1.iconUrl]];
        
        self.game1View.titleLab.text = model1.gameName;
        
        GameCenterGameModel *model2 = self.frameModel.arrayModel.gameArray[1];
        
        [self.game2View.iconImg setImageWithURL:[NSURL URLWithString:model2.iconUrl]];
        
        self.game2View.titleLab.text = model2.gameName;
        
        GameCenterGameModel *model3 = self.frameModel.arrayModel.gameArray[2];
        
        [self.game3View.iconImg setImageWithURL:[NSURL URLWithString:model3.iconUrl]];
        
        self.game3View.titleLab.text = model3.gameName;
        
        GameCenterGameModel *model4 = self.frameModel.arrayModel.gameArray[3];
        
        [self.game4View.iconImg setImageWithURL:[NSURL URLWithString:model4.iconUrl]];
        
        self.game4View.titleLab.text = model4.gameName;
        
        [self.game1View.clickBtn addTarget:self action:@selector(game1Click) forControlEvents:UIControlEventTouchUpInside];
        
        [self.game2View.clickBtn addTarget:self action:@selector(game2Click) forControlEvents:UIControlEventTouchUpInside];
        
        [self.game3View.clickBtn addTarget:self action:@selector(game3Click) forControlEvents:UIControlEventTouchUpInside];
        
        [self.game4View.clickBtn addTarget:self action:@selector(game4Click) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (self.frameModel.arrayModel.gameArray.count == 5) {
        
        GameCenterGameModel *model1 = self.frameModel.arrayModel.gameArray[0];
        
        [self.game1View.iconImg setImageWithURL:[NSURL URLWithString:model1.iconUrl]];
        
        self.game1View.titleLab.text = model1.gameName;
        
        GameCenterGameModel *model2 = self.frameModel.arrayModel.gameArray[1];
        
        [self.game2View.iconImg setImageWithURL:[NSURL URLWithString:model2.iconUrl]];
        
        self.game2View.titleLab.text = model2.gameName;
        
        GameCenterGameModel *model3 = self.frameModel.arrayModel.gameArray[2];
        
        [self.game3View.iconImg setImageWithURL:[NSURL URLWithString:model3.iconUrl]];
        
        self.game3View.titleLab.text = model3.gameName;
        
        GameCenterGameModel *model4 = self.frameModel.arrayModel.gameArray[3];
        
        [self.game4View.iconImg setImageWithURL:[NSURL URLWithString:model4.iconUrl]];
        
        self.game4View.titleLab.text = model4.gameName;
        
        GameCenterGameModel *model5 = self.frameModel.arrayModel.gameArray[4];
        
        [self.game5View.iconImg setImageWithURL:[NSURL URLWithString:model5.iconUrl]];
        
        self.game5View.titleLab.text = model5.gameName;
        
        [self.game1View.clickBtn addTarget:self action:@selector(game1Click) forControlEvents:UIControlEventTouchUpInside];
        
        [self.game2View.clickBtn addTarget:self action:@selector(game2Click) forControlEvents:UIControlEventTouchUpInside];
        
        [self.game3View.clickBtn addTarget:self action:@selector(game3Click) forControlEvents:UIControlEventTouchUpInside];
        
        [self.game4View.clickBtn addTarget:self action:@selector(game4Click) forControlEvents:UIControlEventTouchUpInside];
        
        [self.game5View.clickBtn addTarget:self action:@selector(game5Click) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (self.frameModel.arrayModel.gameArray.count == 6) {
        
        GameCenterGameModel *model1 = self.frameModel.arrayModel.gameArray[0];
        
        [self.game1View.iconImg setImageWithURL:[NSURL URLWithString:model1.iconUrl]];
        
        self.game1View.titleLab.text = model1.gameName;
        
        GameCenterGameModel *model2 = self.frameModel.arrayModel.gameArray[1];
        
        [self.game2View.iconImg setImageWithURL:[NSURL URLWithString:model2.iconUrl]];
        
        self.game2View.titleLab.text = model2.gameName;
        
        GameCenterGameModel *model3 = self.frameModel.arrayModel.gameArray[2];
        
        [self.game3View.iconImg setImageWithURL:[NSURL URLWithString:model3.iconUrl]];
        
        self.game3View.titleLab.text = model3.gameName;
        
        GameCenterGameModel *model4 = self.frameModel.arrayModel.gameArray[3];
        
        [self.game4View.iconImg setImageWithURL:[NSURL URLWithString:model4.iconUrl]];
        
        self.game4View.titleLab.text = model4.gameName;
        
        GameCenterGameModel *model5 = self.frameModel.arrayModel.gameArray[4];
        
        [self.game5View.iconImg setImageWithURL:[NSURL URLWithString:model5.iconUrl]];
        
        self.game5View.titleLab.text = model5.gameName;
        
        GameCenterGameModel *model6 = self.frameModel.arrayModel.gameArray[5];
        
        [self.game6View.iconImg setImageWithURL:[NSURL URLWithString:model6.iconUrl]];
        
        self.game6View.titleLab.text = model6.gameName;
        
        [self.game1View.clickBtn addTarget:self action:@selector(game1Click) forControlEvents:UIControlEventTouchUpInside];
        
        [self.game2View.clickBtn addTarget:self action:@selector(game2Click) forControlEvents:UIControlEventTouchUpInside];
        
        [self.game3View.clickBtn addTarget:self action:@selector(game3Click) forControlEvents:UIControlEventTouchUpInside];
        
        [self.game4View.clickBtn addTarget:self action:@selector(game4Click) forControlEvents:UIControlEventTouchUpInside];
        
        [self.game5View.clickBtn addTarget:self action:@selector(game5Click) forControlEvents:UIControlEventTouchUpInside];
        
        [self.game6View.clickBtn addTarget:self action:@selector(game6Click) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}

- (void)game1Click {
    
    if (self.game1Block) {
        
        self.game1Block();
        
    }
    
}

- (void)game2Click {
    
    if (self.game2Block) {
        
        self.game2Block();
        
    }
    
}

- (void)game3Click {
    
    if (self.game3Block) {
        
        self.game3Block();
        
    }
    
}

- (void)game4Click {
    
    if (self.game4Block) {
        
        self.game4Block();
        
    }
    
}

- (void)game5Click {
    
    if (self.game5Block) {
        
        self.game5Block();
        
    }
    
}

- (void)game6Click {
    
    if (self.game6Block) {
        
        self.game6Block();
        
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
