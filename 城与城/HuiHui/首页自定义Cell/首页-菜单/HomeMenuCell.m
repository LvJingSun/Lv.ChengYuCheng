//
//  HomeMenuCell.m
//  HuiHui
//
//  Created by mac on 2017/9/5.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HomeMenuCell.h"
#import "RedHorseHeader.h"
#import "HomeMenuModel.h"
#import "HomeMenuFrame.h"
#import "MenuBtnModel.h"
#import "MenuBtnView.h"
#import <SDWebImage/UIButton+WebCache.h>

@interface HomeMenuCell ()

@property (nonatomic, weak) MenuBtnView *homeBtn1;

@property (nonatomic, weak) MenuBtnView *homeBtn2;

@property (nonatomic, weak) MenuBtnView *homeBtn3;

@property (nonatomic, weak) MenuBtnView *homeBtn4;

@property (nonatomic, weak) MenuBtnView *homeBtn5;

@property (nonatomic, weak) MenuBtnView *homeBtn6;

@property (nonatomic, weak) MenuBtnView *homeBtn7;

@property (nonatomic, weak) MenuBtnView *homeBtn8;

@property (nonatomic, weak) MenuBtnView *homeBtn9;

@property (nonatomic, weak) MenuBtnView *homeBtn10;

@end

@implementation HomeMenuCell

+ (instancetype)HomeMenuCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"HomeMenuCell";
    
    HomeMenuCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[HomeMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(HomeMenuFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    MenuBtnView *btn1 = [[MenuBtnView alloc] initWithFrame:self.frameModel.view1F];
    
    self.homeBtn1 = btn1;
    
    [self addSubview:btn1];
    
    MenuBtnView *btn2 = [[MenuBtnView alloc] initWithFrame:self.frameModel.view2F];
    
    self.homeBtn2 = btn2;
    
    [self addSubview:btn2];
    
    MenuBtnView *btn3 = [[MenuBtnView alloc] initWithFrame:self.frameModel.view3F];
    
    self.homeBtn3 = btn3;
    
    [self addSubview:btn3];
    
    MenuBtnView *btn4 = [[MenuBtnView alloc] initWithFrame:self.frameModel.view4F];
    
    self.homeBtn4 = btn4;
    
    [self addSubview:btn4];
    
    MenuBtnView *btn5 = [[MenuBtnView alloc] initWithFrame:self.frameModel.view5F];
    
    self.homeBtn5 = btn5;
    
    [self addSubview:btn5];
    
    MenuBtnView *btn6 = [[MenuBtnView alloc] initWithFrame:self.frameModel.view6F];
    
    self.homeBtn6 = btn6;
    
    [self addSubview:btn6];
    
    MenuBtnView *btn7 = [[MenuBtnView alloc] initWithFrame:self.frameModel.view7F];
    
    self.homeBtn7 = btn7;
    
    [self addSubview:btn7];
    
    MenuBtnView *btn8 = [[MenuBtnView alloc] initWithFrame:self.frameModel.view8F];
    
    self.homeBtn8 = btn8;
    
    [self addSubview:btn8];
    
    MenuBtnView *btn9 = [[MenuBtnView alloc] initWithFrame:self.frameModel.view9F];
    
    self.homeBtn9 = btn9;
    
    [self addSubview:btn9];
    
    MenuBtnView *btn10 = [[MenuBtnView alloc] initWithFrame:self.frameModel.view10F];
    
    self.homeBtn10 = btn10;
    
    [self addSubview:btn10];
    
}

- (void)setContent {

    HomeMenuModel *model = self.frameModel.menumodel;
    
    NSArray *arr = model.btnArray;
    
    [self.homeBtn1.btn setImageWithURL:[NSURL URLWithString:((MenuBtnModel *)arr[0]).PhotoUrl] forState:0 placeholderImage:[UIImage imageNamed:@"RH_按钮.png"]];
    
    self.homeBtn1.label.text = ((MenuBtnModel *)arr[0]).Title;
    
    [self.homeBtn1.btn addTarget:self action:@selector(meishiClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.homeBtn2.btn setImageWithURL:[NSURL URLWithString:((MenuBtnModel *)arr[1]).PhotoUrl] forState:0 placeholderImage:[UIImage imageNamed:@"RH_按钮.png"]];
    
    self.homeBtn2.label.text = ((MenuBtnModel *)arr[1]).Title;
    
    [self.homeBtn2.btn addTarget:self action:@selector(lirenClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.homeBtn3.btn setImageWithURL:[NSURL URLWithString:((MenuBtnModel *)arr[2]).PhotoUrl] forState:0 placeholderImage:[UIImage imageNamed:@"RH_按钮.png"]];
    
    self.homeBtn3.label.text = ((MenuBtnModel *)arr[2]).Title;
    
    [self.homeBtn3.btn addTarget:self action:@selector(KTVClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.homeBtn4.btn setImageWithURL:[NSURL URLWithString:((MenuBtnModel *)arr[3]).PhotoUrl] forState:0 placeholderImage:[UIImage imageNamed:@"RH_按钮.png"]];
    
    self.homeBtn4.label.text = ((MenuBtnModel *)arr[3]).Title;
    
    [self.homeBtn4.btn addTarget:self action:@selector(yangchebaoClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.homeBtn5.btn setImageWithURL:[NSURL URLWithString:((MenuBtnModel *)arr[4]).PhotoUrl] forState:0 placeholderImage:[UIImage imageNamed:@"RH_按钮.png"]];
    
    self.homeBtn5.label.text = ((MenuBtnModel *)arr[4]).Title;
    
    [self.homeBtn5.btn addTarget:self action:@selector(youxiClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.homeBtn6.btn setImageWithURL:[NSURL URLWithString:((MenuBtnModel *)arr[5]).PhotoUrl] forState:0 placeholderImage:[UIImage imageNamed:@"RH_按钮.png"]];
    
    self.homeBtn6.label.text = ((MenuBtnModel *)arr[5]).Title;
    
    [self.homeBtn6.btn addTarget:self action:@selector(chepiaoClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.homeBtn7.btn setImageWithURL:[NSURL URLWithString:((MenuBtnModel *)arr[6]).PhotoUrl] forState:0 placeholderImage:[UIImage imageNamed:@"RH_按钮.png"]];
    
    self.homeBtn7.label.text = ((MenuBtnModel *)arr[6]).Title;
    
    [self.homeBtn7.btn addTarget:self action:@selector(jipiaoClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.homeBtn8.btn setImageWithURL:[NSURL URLWithString:((MenuBtnModel *)arr[7]).PhotoUrl] forState:0 placeholderImage:[UIImage imageNamed:@"RH_按钮.png"]];
    
    self.homeBtn8.label.text = ((MenuBtnModel *)arr[7]).Title;
    
    [self.homeBtn8.btn addTarget:self action:@selector(jiudianClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.homeBtn9.btn setImageWithURL:[NSURL URLWithString:((MenuBtnModel *)arr[8]).PhotoUrl] forState:0 placeholderImage:[UIImage imageNamed:@"RH_按钮.png"]];
    
    self.homeBtn9.label.text = ((MenuBtnModel *)arr[8]).Title;
    
    [self.homeBtn9.btn addTarget:self action:@selector(jingdianClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.homeBtn10.btn setImageWithURL:[NSURL URLWithString:((MenuBtnModel *)arr[9]).PhotoUrl] forState:0 placeholderImage:[UIImage imageNamed:@"RH_按钮.png"]];
    
    self.homeBtn10.label.text = ((MenuBtnModel *)arr[9]).Title;
    
    [self.homeBtn10.btn addTarget:self action:@selector(gengduoClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)meishiClick {

    if (self.meishiBlock) {
        
        self.meishiBlock();
        
    }
    
}

- (void)lirenClick {
    
    if (self.lirenBlock) {
        
        self.lirenBlock();
        
    }
    
}

- (void)KTVClick {
    
    if (self.KTVBlock) {
        
        self.KTVBlock();
        
    }
    
}

- (void)yangchebaoClick {
    
    if (self.yangchebaoBlock) {
        
        self.yangchebaoBlock();
        
    }
    
}

- (void)youxiClick {
    
    if (self.youxiBlock) {
        
        self.youxiBlock();
        
    }
    
}

- (void)chepiaoClick {
    
    if (self.chepiaoBlock) {
        
        self.chepiaoBlock();
        
    }
    
}

- (void)jipiaoClick {
    
    if (self.jipiaoBlock) {
        
        self.jipiaoBlock();
        
    }
    
}

- (void)jiudianClick {
    
    if (self.jiudianBlock) {
        
        self.jiudianBlock();
        
    }
    
}

- (void)jingdianClick {
    
    if (self.jingdianBlock) {
        
        self.jingdianBlock();
        
    }
    
}

- (void)gengduoClick {
    
    if (self.gengduoBlock) {
        
        self.gengduoBlock();
        
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
