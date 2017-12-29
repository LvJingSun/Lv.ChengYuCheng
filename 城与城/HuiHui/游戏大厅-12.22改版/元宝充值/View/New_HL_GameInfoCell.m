//
//  New_HL_GameInfoCell.m
//  HuiHui
//
//  Created by mac on 2017/12/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "New_HL_GameInfoCell.h"
#import "New_HL_GameInfoModel.h"
#import "New_HL_GameInfoFrame.h"
#import "LJConst.h"

@interface New_HL_GameInfoCell ()

@property (nonatomic, weak) UILabel *line1Lab;

@property (nonatomic, weak) UITextField *IDField;

@property (nonatomic, weak) UILabel *line2Lab;

@property (nonatomic, weak) UITextField *CountField;

@property (nonatomic, weak) UILabel *line3Lab;

@end

@implementation New_HL_GameInfoCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *line1 = [[UILabel alloc] init];
        
        self.line1Lab = line1;
        
        line1.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line1];
        
        UITextField *idfield = [[UITextField alloc] init];
        
        self.IDField = idfield;
        
        idfield.font = [UIFont systemFontOfSize:16];
        
        idfield.textColor = [UIColor darkTextColor];
        
        idfield.userInteractionEnabled = NO;
        
        [self addSubview:idfield];
        
        UILabel *line2 = [[UILabel alloc] init];
        
        self.line2Lab = line2;
        
        line2.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line2];
        
        UITextField *countfield = [[UITextField alloc] init];
        
        self.CountField = countfield;
        
        countfield.font = [UIFont systemFontOfSize:16];
        
        countfield.textColor = [UIColor darkTextColor];
        
        countfield.userInteractionEnabled = NO;
        
        [self addSubview:countfield];
        
        UILabel *line3 = [[UILabel alloc] init];
        
        self.line3Lab = line3;
        
        line3.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line3];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(New_HL_GameInfoFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.line1Lab.frame = self.frameModel.line1F;
    
    self.IDField.frame = self.frameModel.gameIDF;
    
    CGSize size = [self sizeWithText:@"默认货币" font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(0, self.frameModel.gameIDF.size.height)];
    
    UILabel *idtitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width + 20, self.frameModel.gameIDF.size.height)];
    
    idtitle.textColor = [UIColor darkTextColor];
    
    idtitle.font = [UIFont systemFontOfSize:16];
    
    idtitle.textAlignment = NSTextAlignmentLeft;
    
    idtitle.text = @"游戏ID";
    
    self.IDField.leftViewMode = UITextFieldViewModeAlways;
    
    self.IDField.leftView = idtitle;
    
    self.line2Lab.frame = self.frameModel.line2F;
    
    self.CountField.frame = self.frameModel.countF;
    
    UILabel *counttitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width + 20, self.frameModel.countF.size.height)];
    
    counttitle.textColor = [UIColor darkTextColor];
    
    counttitle.font = [UIFont systemFontOfSize:16];
    
    counttitle.textAlignment = NSTextAlignmentLeft;
    
    counttitle.text = @"默认货币";
    
    self.CountField.leftViewMode = UITextFieldViewModeAlways;
    
    self.CountField.leftView = counttitle;
    
    self.line3Lab.frame = self.frameModel.line3F;
    
}

- (void)setContent {
    
    New_HL_GameInfoModel *model = self.frameModel.model;
    
    self.IDField.placeholder = @"请输入游戏ID";
    
    if (![self isBlankString:model.gameID]) {
        
        self.IDField.text = model.gameID;
        
    }
        
    self.CountField.text = model.type;
    
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

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

- (void)hideKeyboard {
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self hideKeyboard];
    
}

@end
