//
//  F_BrokenLineView.m
//  BusinessCenter
//
//  Created by mac on 2017/3/14.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "F_BrokenLineView.h"

#define bounceX 10
#define bounceY 40
#define yOneHeight 30

@interface F_BrokenLineView () <CAAnimationDelegate>

@property (nonatomic, weak) UIBezierPath *path;

@property (nonatomic, strong) CAShapeLayer *lineChartLayer;

@end

@implementation F_BrokenLineView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    
    return self;
    
}

-(void)setXArr:(NSArray *)xArr {
    
    _xArr = xArr;
    
    if (xArr.count != 0) {
        
        [self createLabelX];
        
    }

}

- (void)createLabelX{
    
    CGFloat  month = self.xArr.count;
    
    for (NSInteger i = 0; i < month; i++) {
        
        UILabel * LabelMonth = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width - 2*bounceX)/month * i + bounceX, self.frame.size.height - bounceY + bounceY*0.2, (self.frame.size.width - 2*bounceX)/month, bounceY * 0.6)];
        
        LabelMonth.tag = 1000 + i;
        
        LabelMonth.textAlignment = NSTextAlignmentCenter;
        
        LabelMonth.text = [NSString stringWithFormat:@"%@",self.xArr[i]];
        
        LabelMonth.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:LabelMonth];
        
    }
    
}

-(void)setData1Arr:(NSArray *)data1Arr {
    
    _data1Arr = data1Arr;
    
    if (data1Arr.count != 0) {
        
        [self drawBrokenLine];
        
    }

}

- (void)drawBrokenLine {
    
    [self dravLine];
    
    self.lineChartLayer.lineWidth = 2;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
    pathAnimation.duration = 1;
    
    pathAnimation.repeatCount = 1;
    
    pathAnimation.removedOnCompletion = YES;
    
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    // 设置动画代理，动画结束时添加一个标签，显示折线终点的信息
    pathAnimation.delegate = self;
    
    [self.lineChartLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
}

- (void)dravLine{
    
    UILabel * Xlabel = (UILabel*)[self viewWithTag:1000];
    
    UIBezierPath * path = [[UIBezierPath alloc]init];
    
    path.lineWidth = 1.0;
    
    self.path = path;
    
    UIColor * color = [UIColor colorWithRed:255/255. green:120/255. blue:72/255. alpha:1.];
    
    [color set];
    
    //y轴上等分的长度
    CGFloat yHeight = (self.frame.size.height - bounceY * 2) * 0.2;
    
    //数组里的最大数
    float dataMax = [self dataArrayMax:self.data1Arr];
    
    float dataMin = [self dataArrayMin:self.data1Arr];
    
//    NSLog(@"%d",dataMin);
    
    if (dataMax == 0) {
        
        //y轴等分的值
        int deng = 0;
        
        for (int c = 0; c <= dataMax; c ++) {
            
            deng = c / 5;
            
        }
        
        //第一个点的y轴上的值
        int Y0 = [self.data1Arr[0] intValue];
        
        //数值除以等分的整数部分
        int z;
        
        z = Y0 / deng;
        
        //数值除以等分的小数部分
        double zz;
        
        double yy;
        
        yy = Y0 % deng;
        
        zz = yy / deng;
        
        [path moveToPoint:CGPointMake( Xlabel.center.x, self.frame.size.height - bounceY)];
        
        UILabel * falglabel0 = [[UILabel alloc]initWithFrame:CGRectMake(Xlabel.center.x - 30, self.frame.size.height - bounceY - 30, 60, 15)];
        
        falglabel0.text = [NSString stringWithFormat:@"%@",self.data1Arr[0]];
        
        falglabel0.font = [UIFont systemFontOfSize:13.0];
        
        falglabel0.textAlignment = NSTextAlignmentCenter;
        
        falglabel0.textColor = [UIColor colorWithRed:144/255. green:144/255. blue:144/255. alpha:1.];
        
        [self addSubview:falglabel0];
        
        UILabel *round_0 = [[UILabel alloc] initWithFrame:CGRectMake(Xlabel.center.x - 3, self.frame.size.height - bounceY - 3, 6, 6)];
        
        round_0.backgroundColor = color;
        
        round_0.layer.masksToBounds = YES;
        
        round_0.layer.cornerRadius = 3;
        
        [self addSubview:round_0];
        
        //创建折现点标记
        for (NSInteger i = 1; i< self.xArr.count; i++) {
            
            UILabel * label1 = (UILabel*)[self viewWithTag:1000 + i];
            
            [path addLineToPoint:CGPointMake(label1.center.x, self.frame.size.height - bounceY)];
            
            UILabel *round_D = [[UILabel alloc] initWithFrame:CGRectMake(label1.center.x - 3, self.frame.size.height - bounceY - 3, 6, 6)];
            
            round_D.backgroundColor = color;
            
            round_D.layer.masksToBounds = YES;
            
            round_D.layer.cornerRadius = 3;
            
            [self addSubview:round_D];
            
            UILabel * falglabel = [[UILabel alloc]initWithFrame:CGRectMake(label1.center.x - 30, self.frame.size.height - bounceY - 30, 60, 15)];
            
            falglabel.tag = 3000 + i;
            
            falglabel.text = [NSString stringWithFormat:@"%@",self.data1Arr[i]];
            
            falglabel.font = [UIFont systemFontOfSize:13.0];
            
            falglabel.textAlignment = NSTextAlignmentCenter;
            
            falglabel.textColor = [UIColor colorWithRed:144/255. green:144/255. blue:144/255. alpha:1.];
            
            [self addSubview:falglabel];
            
        }
        
        self.lineChartLayer = [CAShapeLayer layer];
        
        self.lineChartLayer.path = path.CGPath;
        
        self.lineChartLayer.strokeColor = color.CGColor;
        
        self.lineChartLayer.fillColor = [[UIColor clearColor] CGColor];
        
        // 默认设置路径宽度为0，使其在起始状态下不显示
        self.lineChartLayer.lineWidth = 0;
        
        self.lineChartLayer.lineCap = kCALineCapRound;
        
        self.lineChartLayer.lineJoin = kCALineJoinRound;
        
        [self.layer addSublayer:self.lineChartLayer];
        
    }else {
    
        //y轴等分的值
//        int deng = 0;
//        
//        for (int c = 0; c <= dataMax; c ++) {
//            
//            deng = c / 5;
//            
//        }
        
        float deng = (dataMax - dataMin) * 0.2;
        
        //第一个点的y轴上的值
        float Y0 = [self.data1Arr[0] floatValue];
        
        //数值除以等分的整数部分
        float z;
        
        z = (Y0 - dataMin) / deng;
        
        //数值除以等分的小数部分
        double zz;
        
        double yy;
        
        yy = (int)(Y0 - dataMin) % (int)deng;
        
        zz = yy / deng;
        
        [path moveToPoint:CGPointMake( Xlabel.center.x, self.frame.size.height - bounceY - yHeight * zz - yHeight * z)];
        
        UILabel * falglabel0 = [[UILabel alloc]initWithFrame:CGRectMake(Xlabel.center.x - 40, self.frame.size.height - bounceY - yHeight * zz - yHeight * z - 30, 80, 15)];
        
        falglabel0.text = [NSString stringWithFormat:@"%@",self.data1Arr[0]];
        
        falglabel0.font = [UIFont systemFontOfSize:13.0];
        
        falglabel0.textAlignment = NSTextAlignmentCenter;
        
        falglabel0.textColor = [UIColor colorWithRed:144/255. green:144/255. blue:144/255. alpha:1.];
        
        [self addSubview:falglabel0];
        
        UILabel *round_0 = [[UILabel alloc] initWithFrame:CGRectMake(Xlabel.center.x - 3, self.frame.size.height - bounceY - yHeight * zz - yHeight * z - 3, 6, 6)];
        
        round_0.backgroundColor = color;
        
        round_0.layer.masksToBounds = YES;
        
        round_0.layer.cornerRadius = 3;
        
        [self addSubview:round_0];
        
        //创建折现点标记
        for (NSInteger i = 1; i< self.xArr.count; i++) {
            
            UILabel * label1 = (UILabel*)[self viewWithTag:1000 + i];
            
            float d_y = [self.data1Arr[i] floatValue];
            
            yy = (int)(d_y - dataMin) % (int)deng;
            
            zz = yy / deng;
            
            z = (d_y - dataMin) / deng;
            
            [path addLineToPoint:CGPointMake(label1.center.x, self.frame.size.height - bounceY - yHeight * zz - yHeight * z)];
            
            UILabel *round_D = [[UILabel alloc] initWithFrame:CGRectMake(label1.center.x - 3, self.frame.size.height - bounceY - yHeight * zz - yHeight * z - 3, 6, 6)];
            
            round_D.backgroundColor = color;
            
            round_D.layer.masksToBounds = YES;
            
            round_D.layer.cornerRadius = 3;
            
            [self addSubview:round_D];
            
            UILabel * falglabel = [[UILabel alloc]initWithFrame:CGRectMake(label1.center.x - 40, self.frame.size.height - bounceY - yHeight * zz - yHeight * z - 30, 80, 15)];
            
            falglabel.tag = 3000 + i;
            
            falglabel.text = [NSString stringWithFormat:@"%@",self.data1Arr[i]];
            
            falglabel.font = [UIFont systemFontOfSize:13.0];
            
            falglabel.textAlignment = NSTextAlignmentCenter;
            
            falglabel.textColor = [UIColor colorWithRed:144/255. green:144/255. blue:144/255. alpha:1.];
            
            [self addSubview:falglabel];
            
        }

        self.lineChartLayer = [CAShapeLayer layer];
        
        self.lineChartLayer.path = path.CGPath;
        
        self.lineChartLayer.strokeColor = color.CGColor;
        
        self.lineChartLayer.fillColor = [[UIColor clearColor] CGColor];
        
        // 默认设置路径宽度为0，使其在起始状态下不显示
        self.lineChartLayer.lineWidth = 0;
        
        self.lineChartLayer.lineCap = kCALineCapRound;
        
        self.lineChartLayer.lineJoin = kCALineJoinRound;
        
        [self.layer addSublayer:self.lineChartLayer];
        
    }
    
}

- (float)dataArrayMax:(NSArray *)array {
    
    float max_number = 0;
    
    for (int i = 0; i < array.count; i ++) {
        
        float a = [array[i] floatValue];
        
        max_number = a > max_number ? a : max_number;
        
    }
    
    return max_number;
    
}

- (float)dataArrayMin:(NSArray *)array {

    float min_number = INFINITY;
    
    for (int i = 0; i < array.count; i ++) {
        
        float a = [array[i] floatValue];
        
        min_number = a > min_number ? min_number : a;
        
    }
    
    return min_number;
    
}

@end
