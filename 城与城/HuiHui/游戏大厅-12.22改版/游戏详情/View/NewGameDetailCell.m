//
//  NewGameDetailCell.m
//  HuiHui
//
//  Created by mac on 2017/12/25.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "NewGameDetailCell.h"
#import "NewGameDetailModel.h"
#import "NewGameDetailFrame.h"
#import "LJConst.h"

@interface NewGameDetailCell () <UIWebViewDelegate>

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UILabel *nametitleLab;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *IDtitleLab;

@property (nonatomic, weak) UILabel *IDLab;

@property (nonatomic, weak) UIButton *bindBtn;

@property (nonatomic, weak) UILabel *bindLineLab;

@property (nonatomic, weak) UILabel *line1Lab;

@property (nonatomic, weak) UILabel *totaltitleLab;

@property (nonatomic, weak) UILabel *line2Lab;

@property (nonatomic, weak) UILabel *counttitleLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UIView *bgView;

@property (nonatomic, weak) UIButton *rechargeBtn;

@property (nonatomic, weak) UIButton *sendBtn;

@property (nonatomic, weak) UILabel *desctitleLab;

@property (nonatomic, weak) UILabel *line3Lab;

@property (nonatomic, weak) UILabel *descLab;

@property (nonatomic, weak) UIWebView *webview;

@property (nonatomic, weak) UIView *getBGView;

@property (nonatomic, weak) UIButton *getBtn;

@end

static CGFloat staticheight = 0;

@implementation NewGameDetailCell

+ (instancetype)NewGameDetailCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"NewGameDetailCell";
    
    NewGameDetailCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[NewGameDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.iconImg = icon;
        
        icon.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:icon];
        
        UILabel *nametitle = [[UILabel alloc] init];
        
        self.nametitleLab = nametitle;
        
        nametitle.textColor = [UIColor darkTextColor];
        
        nametitle.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:nametitle];
        
        UILabel *name = [[UILabel alloc] init];
        
        self.nameLab = name;
        
        name.textColor = [UIColor orangeColor];
        
        name.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:name];
        
        UILabel *IDtitle = [[UILabel alloc] init];
        
        self.IDtitleLab = IDtitle;
        
        IDtitle.textColor = [UIColor darkTextColor];
        
        IDtitle.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:IDtitle];
        
        UILabel *ID = [[UILabel alloc] init];
        
        self.IDLab = ID;
        
        ID.textColor = [UIColor orangeColor];
        
        ID.font = [UIFont systemFontOfSize:16];
        
        ID.hidden = YES;
        
        [self addSubview:ID];
        
        UIButton *bindBtn = [[UIButton alloc] init];

        self.bindBtn = bindBtn;
        
        [bindBtn setTitleColor:[UIColor orangeColor] forState:0];
        
        bindBtn.titleLabel.font = [UIFont systemFontOfSize:16];

        bindBtn.hidden = YES;

        [self addSubview:bindBtn];
        
        UILabel *bindline = [[UILabel alloc] init];
        
        self.bindLineLab = bindline;
        
        bindline.backgroundColor = [UIColor orangeColor];
        
        bindline.hidden = YES;
        
        [self addSubview:bindline];
        
        UILabel *line1 = [[UILabel alloc] init];
        
        self.line1Lab = line1;
        
        line1.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line1];
        
        UILabel *total = [[UILabel alloc] init];
        
        self.totaltitleLab = total;
        
        total.textColor = [UIColor darkTextColor];
        
        total.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:total];
        
        UILabel *line2 = [[UILabel alloc] init];
        
        self.line2Lab = line2;
        
        line2.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line2];
        
        UILabel *counttitle = [[UILabel alloc] init];
        
        self.counttitleLab = counttitle;
        
        counttitle.font = [UIFont systemFontOfSize:14];
        
        counttitle.textColor = [UIColor darkGrayColor];
        
        counttitle.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:counttitle];
        
        UILabel *count = [[UILabel alloc] init];
        
        self.countLab = count;
        
        count.font = [UIFont systemFontOfSize:17];
        
        count.textColor = [UIColor orangeColor];
        
        count.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:count];
        
        UIView *bg = [[UIView alloc] init];
        
        self.bgView = bg;
        
        bg.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:bg];
        
        UIButton *recharge = [[UIButton alloc] init];
        
        self.rechargeBtn = recharge;
        
        [recharge setBackgroundColor:FSB_StyleCOLOR];
        
        [recharge setTitleColor:[UIColor whiteColor] forState:0];
        
        recharge.titleLabel.font = [UIFont systemFontOfSize:15];
        
        recharge.layer.masksToBounds = YES;
        
        recharge.layer.cornerRadius = 5;
        
        [self addSubview:recharge];
        
        UIButton *send = [[UIButton alloc] init];
        
        self.sendBtn = send;
        
        [send setBackgroundColor:[UIColor whiteColor]];
        
        [send setTitleColor:FSB_StyleCOLOR forState:0];
        
        send.titleLabel.font = [UIFont systemFontOfSize:15];
        
        send.layer.masksToBounds = YES;
        
        send.layer.cornerRadius = 5;
        
        [self addSubview:send];
        
        UILabel *desctitle = [[UILabel alloc] init];
        
        self.desctitleLab = desctitle;
        
        desctitle.textColor = [UIColor darkTextColor];
        
        desctitle.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:desctitle];
        
        UILabel *line3 = [[UILabel alloc] init];
        
        self.line3Lab = line3;
        
        line3.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line3];
        
//        UILabel *desc = [[UILabel alloc] init];
//
//        self.descLab = desc;
//
//        desc.textColor = [UIColor darkTextColor];
//
//        desc.font = [UIFont systemFontOfSize:15];
//
//        desc.numberOfLines = 0;
//
//        [self addSubview:desc];
        
        UIWebView *webview = [[UIWebView alloc] init];
        
        self.webview = webview;
        
        webview.scrollView.bounces = NO;
        
        webview.delegate = self;
        
        webview.opaque = NO;
        
        webview.backgroundColor = [UIColor clearColor];
        
        [self addSubview:webview];
        
        UIView *getBg = [[UIView alloc] init];
        
        self.getBGView = getBg;
        
        getBg.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:getBg];
        
        UIButton *getBtn = [[UIButton alloc] init];
        
        self.getBtn = getBtn;
        
        [getBtn setTitleColor:[UIColor whiteColor] forState:0];
        
        [getBtn setBackgroundColor:FSB_StyleCOLOR];
        
        getBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        getBtn.layer.masksToBounds = YES;
        
        getBtn.layer.cornerRadius = 8;
        
        [self addSubview:getBtn];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(NewGameDetailFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.iconImg.frame = self.frameModel.iconF;
    
    self.nametitleLab.frame = self.frameModel.nameTitleF;
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.IDtitleLab.frame = self.frameModel.IDTitleF;
    
    self.IDLab.frame = self.frameModel.IDF;
    
    self.bindBtn.frame = self.frameModel.bindF;
    
    self.bindLineLab.frame = self.frameModel.bindLineF;
    
    self.line1Lab.frame = self.frameModel.line1F;
    
    self.totaltitleLab.frame = self.frameModel.totalTitleF;
    
    self.line2Lab.frame = self.frameModel.line2F;
    
    self.counttitleLab.frame = self.frameModel.countTitleF;
    
    self.countLab.frame = self.frameModel.countF;
    
    self.bgView.frame = self.frameModel.bgF;
    
    self.rechargeBtn.frame = self.frameModel.rechargeF;
    
    self.sendBtn.frame = self.frameModel.sendF;
    
    self.desctitleLab.frame = self.frameModel.descTitleF;
    
    self.line3Lab.frame = self.frameModel.line3F;
    
//    self.descLab.frame = self.frameModel.descF;
    
    self.webview.frame = self.frameModel.descF;
    
    self.getBGView.frame = self.frameModel.getInBGF;
    
    self.getBtn.frame = self.frameModel.getInF;
    
}

- (void)setContent {
    
    NewGameDetailModel *model = self.frameModel.model;
    
    [self.iconImg setImageWithURL:[NSURL URLWithString:model.iconUrl]];
    
    self.nametitleLab.text = @"游戏名称:";
    
    if (![self isBlankString:model.gameName]) {
        
        self.nameLab.text = model.gameName;
        
    }
    
    self.IDtitleLab.text = @"游戏ID:";
    
    if (model.isBind) {
        
        self.IDLab.hidden = NO;
        
        self.IDLab.text = model.userID;
        
        self.bindBtn.hidden = YES;
        
        self.bindLineLab.hidden = YES;
        
    }else {
        
        self.IDLab.hidden = YES;
        
        self.bindBtn.hidden = NO;
        
        self.bindLineLab.hidden = NO;
        
        [self.bindBtn setTitle:@"点击绑定" forState:0];
        
        [self.bindBtn addTarget:self action:@selector(bindClick) forControlEvents:UIControlEventTouchUpInside];
        
    }

    self.totaltitleLab.text = @"账户总额";
    
    self.counttitleLab.text = model.type;
    
    if (![self isBlankString:model.total]) {
        
        self.countLab.text = model.total;
        
    }else {
        
        self.countLab.text = @"0";
        
    }
    
    [self.rechargeBtn setTitle:@"充值" forState:0];
    
    [self.rechargeBtn addTarget:self action:@selector(rechargeClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.sendBtn setTitle:@"赠送" forState:0];
    
    [self.sendBtn addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.desctitleLab.text = @"游戏攻略";
    
    NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                       "<head> \n"
                       "<style type=\"text/css\"> \n"
                       "body {font-size:15px;}\n"
                       "</style> \n"
                       "</head> \n"
                       "<body>"
                       "<script type='text/javascript'>"
                       "window.onload = function(){\n"
                       "var $img = document.getElementsByTagName('img');\n"
                       "for(var p in  $img){\n"
                       " $img[p].style.width = '100%%';\n"
                       "$img[p].style.height ='auto'\n"
                       "}\n"
                       "}"
                       "</script>%@"
                       "</body>"
                       "</html>",model.desc];
    
    [self.webview loadHTMLString:htmls baseURL:nil];
    
    [self.getBtn setTitle:@"立即体验" forState:0];
    
    [self.getBtn addTarget:self action:@selector(tiyanClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)tiyanClick {
    
    if (self.tiyanBlock) {
        
        self.tiyanBlock();
        
    }
    
}

- (void)bindClick {
    
    if (self.bindBlock) {
        
        self.bindBlock();
        
    }
    
}

- (void)rechargeClick {
    
    if (self.rechargeBlock) {
        
        self.rechargeBlock();
        
    }
    
}

- (void)sendClick {
    
    if (self.sendBlock) {
        
        self.sendBlock();
        
    }
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    
    if (staticheight != height + 1) {
        
        staticheight = height + 1;
        
        if (staticheight > 0) {
            
            [self.frameModel changeWebViewWith:staticheight + 22];
            
            if (self.reloadBlock) {
                
                self.reloadBlock();
                
            }
            
        }
        
    }
    
}

- (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
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
