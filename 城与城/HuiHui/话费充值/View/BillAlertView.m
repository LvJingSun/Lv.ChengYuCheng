//
//  BillAlertView.m
//  HuiHui
//
//  Created by mac on 2017/5/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "BillAlertView.h"
#import "LJConst.h"
#import "BillOrderModel.h"

//#define viewHeight 329.f

@interface BillAlertView () {

    UIView *_contentView;
    
    CGFloat viewHeight;
    
}

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UIButton *cancleBtn;

@property (nonatomic, weak) UILabel *line1Lab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *orderTitleLab;

@property (nonatomic, weak) UILabel *orderNoLab;

@property (nonatomic, weak) UILabel *line2Lab;

@property (nonatomic, weak) UILabel *infoTitleLab;

@property (nonatomic, weak) UILabel *infoLab;

@property (nonatomic, weak) UILabel *line3Lab;

@property (nonatomic, weak) UILabel *styleTitleLab;

@property (nonatomic, weak) UILabel *styleLab;

@property (nonatomic, weak) UILabel *line4Lab;

@property (nonatomic, weak) UIButton *sureBtn;

@end

@implementation BillAlertView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64);
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        if (_contentView == nil) {
            
            _contentView = [[UIView alloc] init];
            
            CGFloat titleX = _WindowViewWidth * 0.2;
            
            CGFloat titleY = 10;
            
            CGFloat titleW = _WindowViewWidth * 0.6;
            
            CGFloat titleH = 20;
            
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
            
            self.titleLab = title;
            
            title.textAlignment = NSTextAlignmentCenter;
            
            title.textColor = AlertTitleCOLOR;
            
            title.font = AlertTitleFont;
            
            [_contentView addSubview:title];
            
            CGFloat cancleW = titleH;
            
            CGFloat cancleH = cancleW;
            
            CGFloat cancleY = titleY;
            
            CGFloat cancleX = _WindowViewWidth * 0.95 - cancleW;
            
            UIButton *cancle = [[UIButton alloc] initWithFrame:CGRectMake(cancleX, cancleY, cancleW, cancleH)];
            
            self.cancleBtn = cancle;
            
            [_contentView addSubview:cancle];
            
            UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(title.frame) + titleY, _WindowViewWidth, 1)];
            
            self.line1Lab = line1;
            
            line1.backgroundColor = FSB_LineCOLOR;
            
            [_contentView addSubview:line1];
            
            CGFloat countX = _WindowViewWidth * 0.05;
            
            CGFloat countY = CGRectGetMaxY(line1.frame) + 20;
            
            CGFloat countW = _WindowViewWidth * 0.9;
            
            CGFloat countH = 40;
            
            UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(countX, countY, countW, countH)];
            
            self.countLab = count;
            
            count.textColor = AlertCountCOLOR;
            
            count.textAlignment = NSTextAlignmentCenter;
            
            count.font = AlertCountFont;
            
            [_contentView addSubview:count];
            
            CGFloat orderTitleX = _WindowViewWidth * 0.05;
            
            CGFloat orderTitleY = CGRectGetMaxY(count.frame) + 20;
            
            CGFloat orderTitleH = 20;
            
            CGSize titleSize = [self sizeWithText:@"订单号码" font:AlertNoTitleFont maxSize:CGSizeMake(0,orderTitleH)];
            
            CGFloat orderTitleW = titleSize.width;
            
            UILabel *orderTitle = [[UILabel alloc] initWithFrame:CGRectMake(orderTitleX, orderTitleY, orderTitleW, orderTitleH)];
            
            self.orderTitleLab = orderTitle;
            
            orderTitle.textColor = AlertNoTitleCOLOR;
            
            orderTitle.font = AlertNoTitleFont;
            
            [_contentView addSubview:orderTitle];
            
            CGFloat noX = CGRectGetMaxX(orderTitle.frame) + _WindowViewWidth * 0.05;
            
            CGFloat noY = orderTitleY;
            
            CGFloat noW = _WindowViewWidth * 0.95 - noX;
            
            CGFloat noH = orderTitleH;
            
            UILabel *orderNo = [[UILabel alloc] initWithFrame:CGRectMake(noX, noY, noW, noH)];
            
            self.orderNoLab = orderNo;
            
            orderNo.textAlignment = NSTextAlignmentRight;
            
            orderNo.textColor = AlertNoCOLOR;
            
            orderNo.font = AlertNoFont;
            
            [_contentView addSubview:orderNo];
            
            UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(orderTitleX, CGRectGetMaxY(orderTitle.frame) + 10, _WindowViewWidth - orderTitleX, 1)];
            
            self.line2Lab = line2;
            
            line2.backgroundColor = FSB_LineCOLOR;
            
            [_contentView addSubview:line2];
            
            UILabel *infoTitle = [[UILabel alloc] initWithFrame:CGRectMake(orderTitleX, CGRectGetMaxY(line2.frame) + 10, orderTitleW, orderTitleH)];
            
            self.infoTitleLab = infoTitle;
            
            infoTitle.textColor = AlertNoTitleCOLOR;
            
            infoTitle.font = AlertNoTitleFont;
            
            [_contentView addSubview:infoTitle];
            
            UILabel *info = [[UILabel alloc] initWithFrame:CGRectMake(noX, CGRectGetMaxY(line2.frame) + 10, noW, noH)];
            
            self.infoLab = info;
            
            info.textAlignment = NSTextAlignmentRight;
            
            info.textColor = AlertNoCOLOR;
            
            info.font = AlertNoFont;
            
            [_contentView addSubview:info];
            
            UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(orderTitleX, CGRectGetMaxY(info.frame) + 10, _WindowViewWidth - orderTitleX, 1)];
            
            self.line3Lab = line3;
            
            line3.backgroundColor = FSB_LineCOLOR;
            
            [_contentView addSubview:line3];
            
            UILabel *styleTitle = [[UILabel alloc] initWithFrame:CGRectMake(orderTitleX, CGRectGetMaxY(line3.frame) + 10, orderTitleW, orderTitleH)];
            
            self.styleTitleLab = styleTitle;
            
            styleTitle.textColor = AlertNoTitleCOLOR;
            
            styleTitle.font = AlertNoTitleFont;
            
            [_contentView addSubview:styleTitle];
            
            UILabel *style = [[UILabel alloc] initWithFrame:CGRectMake(noX, CGRectGetMaxY(line3.frame) + 10, noW, noH)];
            
            self.styleLab = style;
            
            style.textAlignment = NSTextAlignmentRight;
            
            style.textColor = AlertNoCOLOR;
            
            style.font = AlertNoFont;
            
            [_contentView addSubview:style];
            
            UILabel *line4 = [[UILabel alloc] initWithFrame:CGRectMake(orderTitleX, CGRectGetMaxY(style.frame) + 10, _WindowViewWidth - orderTitleX, 1)];
            
            self.line4Lab = line4;
            
            line4.backgroundColor = FSB_LineCOLOR;
            
            [_contentView addSubview:line4];
            
            UIButton *sure = [[UIButton alloc] initWithFrame:CGRectMake(orderTitleX, CGRectGetMaxY(line4.frame) + 150, _WindowViewWidth - 2 * orderTitleX, 50)];
            
            self.sureBtn = sure;
            
            [sure setBackgroundColor:FSB_StyleCOLOR];
            
            sure.layer.masksToBounds = YES;
            
            sure.layer.cornerRadius = 5;
            
            [sure setTitleColor:[UIColor whiteColor] forState:0];
            
            [sure addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
            
            [_contentView addSubview:sure];
            
            viewHeight = CGRectGetMaxY(sure.frame) + 10;
            
            _contentView.frame = CGRectMake(0, _WindowViewHeight - viewHeight, _WindowViewWidth, viewHeight);
            
            _contentView.backgroundColor = [UIColor whiteColor];
            
            [self addSubview:_contentView];
            
        }
        
    }
    
    return self;
    
}

- (void)sureClick {

    if ([self.delegate respondsToSelector:@selector(BillSureBtnClick)]) {
        
        [self.delegate BillSureBtnClick];
        
    }
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

-(void)setOrderModel:(BillOrderModel *)orderModel {

    _orderModel = orderModel;
    
    [self setContent];
    
}

- (void)setContent {

    self.titleLab.text = @"确认付款";
    
    [self.cancleBtn setImage:[UIImage imageNamed:@"ChargeCancle.png"] forState:0];
    
    [self.cancleBtn addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
    
    self.countLab.text = [NSString stringWithFormat:@"¥%@",self.orderModel.count];
    
    self.orderTitleLab.text = @"订单号码";
    
    self.orderNoLab.text = [NSString stringWithFormat:@"%@",self.orderModel.orderNo];
    
    self.infoTitleLab.text = @"订单信息";
    
    self.infoLab.text = [NSString stringWithFormat:@"%@(%@)",self.orderModel.phone,self.orderModel.location];
    
    self.styleTitleLab.text = @"付款方式";
    
    if ([self.orderModel.IFEnough isEqualToString:@"0"]) {
        
        self.styleLab.text = [NSString stringWithFormat:@"%@(余额不足)",self.orderModel.style];
        
        self.styleLab.textColor = [UIColor lightGrayColor];
        
        self.sureBtn.userInteractionEnabled = NO;
        
    }else if ([self.orderModel.IFEnough isEqualToString:@"1"]) {
    
        self.styleLab.text = [NSString stringWithFormat:@"%@",self.orderModel.style];
        
        self.styleLab.textColor = AlertNoCOLOR;
        
        self.sureBtn.userInteractionEnabled = YES;
        
    }
    
    [self.sureBtn setTitle:@"立即支付" forState:0];
    
}

//展示从底部向上弹出的UIView（包含遮罩）
- (void)showInView:(UIView *)view
{
    if (!view)
    {
        return;
    }
    
    [view addSubview:self];
    [view addSubview:_contentView];
    
    [_contentView setFrame:CGRectMake(0, _WindowViewHeight - 64, _WindowViewWidth, viewHeight)];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 1.0;
        
        [_contentView setFrame:CGRectMake(0, _WindowViewHeight - viewHeight - 64, _WindowViewWidth, viewHeight)];
        
    } completion:nil];
}

//移除从上向底部弹下去的UIView（包含遮罩）
- (void)disMissView
{
    [_contentView setFrame:CGRectMake(0, _WindowViewHeight - viewHeight - 64, _WindowViewWidth, viewHeight)];
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         self.alpha = 0.0;
                         
                         [_contentView setFrame:CGRectMake(0, _WindowViewHeight - 64, _WindowViewWidth, viewHeight)];
                         
                     }
                     completion:^(BOOL finished){
                         
                         [self removeFromSuperview];
                         
                         [_contentView removeFromSuperview];
                         
                     }];
    
}

@end
