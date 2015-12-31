//
//  MyView.m
//  draw
//
//  Created by xiaobai on 15/12/29.
//  Copyright © 2015年 xiaobai. All rights reserved.
//

#import "XBScorePlateView.h"

@interface XBScorePlateView()
{
    CGFloat d_speed;//执行动画时候每个的增量
    CGFloat d_altitude;
    CGFloat d_comp;
}

@property (nonatomic,strong)  UILabel*lbeCompreValue;//综合分数的标签

@property (nonatomic,strong) UILabel *compreValue;//综合分数的具体数值

@property (nonatomic,strong) UILabel * comment;//评价

@property (nonatomic,assign) CGFloat cur_speedV;//当前的值

@property (nonatomic,assign) CGFloat cur_altitudeV;//当前的态度；

@property (nonatomic,assign) CGFloat cur_compV;//当前的综合分数
@property (nonatomic,assign) NSTimer * timer;

@end

@implementation XBScorePlateView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.precision= 50;//这里设置默认值;
        self.fullValues =5;
        self.altitudeValues=3.0;
        self.speedValues=4.0;
        self.backgroundColor = [UIColor clearColor];
        self.startAngle=0.1*M_PI;
        self.endAngle = 0.9*M_PI;
        self.comments =@"真是太不可思议了";
        self.backgroundColor = [UIColor greenColor];
        _cur_compV=0;
        _cur_speedV=0;
        _cur_altitudeV=0;
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    
    //1. 画圆
    
    CGFloat circleMargin = 0; //上下两个半圆的间距
    CGFloat topBottomMargin =20;//这个间距用来显示服务态度和服务速度那样标签内容
    
    CGFloat radius = (self.frame.size.height-circleMargin-2*topBottomMargin)/2;//半径
    //上边圆的圆心
    CGPoint centerTop = CGPointMake(self.frame.size.width/2,self.frame.size.height/2-circleMargin/2);
    [self drawHalfCircle:centerTop andWithRadius:radius isTop:YES];
    //下面圆的圆心
    CGPoint centerBottom = CGPointMake(self.frame.size.width/2, self.frame.size.height/2+circleMargin/2);
    [self drawHalfCircle:centerBottom andWithRadius:radius isTop:NO];
    
    //2. 创建需要的标签,并在合适的位置绘制内容
    UILabel * lbeAltitude = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, topBottomMargin)];
    lbeAltitude.text = @"服务速度";
    lbeAltitude.textColor = [UIColor whiteColor];
    lbeAltitude.textAlignment = NSTextAlignmentCenter;
    lbeAltitude.font = [UIFont systemFontOfSize:12];
    [lbeAltitude drawTextInRect:lbeAltitude.frame];
    
    //服务态度评分
    UILabel * lbeSpeed = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-topBottomMargin, self.frame.size.width, topBottomMargin)];
    lbeSpeed.text = @"服务态度";
    lbeSpeed.textColor = [UIColor whiteColor];
    lbeSpeed.textAlignment = NSTextAlignmentCenter;
    lbeSpeed.font = [UIFont systemFontOfSize:12];
    [lbeSpeed drawTextInRect:lbeSpeed.frame];
    
    //绘制综合评分
    NSString *attitudeScore = [NSString stringWithFormat:@"%.2f/%.2f",_cur_altitudeV,self.fullValues];
    NSMutableAttributedString* attributeString = [[NSMutableAttributedString alloc]initWithString:attitudeScore];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:26] range:NSMakeRange(0, 4)];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(4, 3)];
    self.compreValue = [[UILabel alloc]initWithFrame:CGRectMake(0, radius-topBottomMargin,self.frame.size.width, 2*topBottomMargin)];
    self.compreValue.attributedText = attributeString;
    self.compreValue.textAlignment = NSTextAlignmentCenter;
    self.compreValue.textColor = [UIColor whiteColor];
    self.compreValue.frame = CGRectMake(0, centerTop.y-topBottomMargin+circleMargin/2, self.frame.size.width, topBottomMargin*2);
    [self.compreValue drawTextInRect:self.compreValue.frame];
    
    self.lbeCompreValue = [[UILabel alloc]initWithFrame:CGRectMake(0, centerTop.y-radius*0.5, self.frame.size.width, topBottomMargin*2)];
    self.lbeCompreValue.text =@"综合评分";
    self.lbeCompreValue.textAlignment = NSTextAlignmentCenter;
    self.lbeCompreValue.textColor = [UIColor whiteColor];
    self.lbeCompreValue.font = [UIFont systemFontOfSize:14];
    [self.lbeCompreValue drawTextInRect:self.lbeCompreValue.frame];
    //评价内容
    self.comment = [[UILabel alloc]initWithFrame:CGRectMake(topBottomMargin+circleMargin+radius/2, CGRectGetMaxY(self.compreValue.frame), radius, topBottomMargin*2)];
    self.comment.text =self.comments;
    self.comment.numberOfLines=0;
    self.comment.textAlignment = NSTextAlignmentCenter;
    self.comment.textColor = [UIColor whiteColor];
    self.comment.font = [UIFont systemFontOfSize:14];
    [self.comment drawTextInRect:self.comment.frame];
    
}
/**
 *  画半圆 绘制刻度的时候可以先绘制从圆心的线，最后用一个内圆裁剪的方式，但是如果要求背景随时变化就局限了，特别是父视图背景是渐变的，要么重新定义该类，要么把这个类视图定义为透明，从而透过父视图背景颜色
    透明的背景无法掩盖从圆心出发的线，
 *
 *  @param center 圆心坐标
 *  @param radius 半径
 *  @param top    是不是画上面的圆
 */
-(void)drawHalfCircle:(CGPoint) center andWithRadius:(CGFloat)radius isTop:(BOOL) top
{
   
    //画上面圆的边框
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    if (top) {
        CGContextAddArc(ctx, center.x, center.y, radius, -self.startAngle, -self.endAngle, 1);
    }
    else
    {
        CGContextAddArc(ctx, center.x, center.y, radius,self.startAngle,self.endAngle, 0);
    }
    //设置线的宽度
    CGContextSetLineWidth(ctx, 1);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextStrokePath(ctx);
    //绘制上下圆的分割线
    CGContextSetLineWidth(ctx, 2);//设置线宽
    CGFloat borderValue;
    if (top) {
        borderValue=_cur_altitudeV/self.fullValues;//设置边界值
    }
    else
    {
        borderValue =_cur_speedV/self.fullValues;
    }
    //实现动画效果，只能先画刻度，再画具体值
    for (int i=1; i<self.precision; i++)//画刻度
    {
        
        CGContextSetRGBStrokeColor(ctx, 1.0, 1.0, 1.0, 0.5);//设置白色 透明
        CGFloat endX,endY,startX,startY;//刻度的长度是这里 7 -2 =5；
        if (top) {
            startX = center.x -(radius-10)*cos((double)i/self.precision*(self.endAngle-self.startAngle)+self.startAngle);
            startY = center.y - (radius-10)*sin((double)i/self.precision*(self.endAngle-self.startAngle)+self.startAngle);
            endX = center.x - (radius-2)*cos((double)i/self.precision*(self.endAngle-self.startAngle)+self.startAngle);//圆上的点的x坐标
            endY = center.y - (radius-2)*sin((double)i/self.precision*(self.endAngle-self.startAngle)+self.startAngle);//圆上的点的y坐标
        }
        else
        {
            startX = center.x +(radius-10)*cos((double)i/self.precision*(self.endAngle-self.startAngle)+self.startAngle);
            startY = center.y + (radius-10)*sin((double)i/self.precision*(self.endAngle-self.startAngle)+self.startAngle);
            endX = center.x + (radius-2)*cos((double)i/self.precision*(self.endAngle-self.startAngle)+self.startAngle);//圆上的点的x坐标
            endY = center.y + (radius-2)*sin((double)i/self.precision*(self.endAngle-self.startAngle)+self.startAngle);//圆上的点的y坐标
        }
        CGContextMoveToPoint(ctx, startX, startY);
        CGContextAddLineToPoint(ctx, endX, endY);
        CGContextStrokePath(ctx);
    }
    for (int i=1; i<self.precision; i++)
    {
        
        CGFloat curAngle =(double)i/self.precision*(self.endAngle-self.startAngle)+self.startAngle;
        if ((double)i/(double)self.precision<borderValue)
        {
            CGContextSetRGBStrokeColor(ctx, 1.0, 1.0, 1.0, 1);//设置白色 不透明
            CGFloat endX,endY,startX,startY;//刻度的长度是这里 7 -2 =5；
            if (top) {
                startX = center.x -(radius-10)*cos(curAngle);
                startY = center.y - (radius-10)*sin(curAngle);
                endX = center.x - (radius-2)*cos(curAngle);//圆上的点的x坐标
                endY = center.y - (radius-2)*sin(curAngle);//圆上的点的y坐标
            }
            else
            {
                startX = center.x +(radius-10)*cos(curAngle);
                startY = center.y + (radius-10)*sin(curAngle);
                endX = center.x + (radius-2)*cos(curAngle);//圆上的点的x坐标
                endY = center.y + (radius-2)*sin(curAngle);//圆上的点的y坐标
            }
            CGContextMoveToPoint(ctx, startX, startY);
            CGContextAddLineToPoint(ctx, endX, endY);
            CGContextStrokePath(ctx);
        }
    }
}
- (void)didMoveToSuperview
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(update) userInfo:nil repeats:YES];
    d_comp = self.compreValues/20;
    d_speed= self.speedValues/20;
    d_altitude=self.speedValues/20;
}
-(void)update
{
    _cur_altitudeV+=d_altitude;
    _cur_speedV+=d_speed;
    _cur_compV+=d_comp;
    if (_cur_altitudeV>self.altitudeValues) {
        _cur_altitudeV =self.altitudeValues;
    }
    if (_cur_speedV > self.speedValues) {
        _cur_speedV=self.speedValues;
    }
    if (_cur_compV>self.compreValues) {
        _cur_compV=self.compreValues;
    }
    if ( _cur_compV==self.compreValues&&_cur_speedV==self.speedValues&&_cur_altitudeV ==self.altitudeValues) {
        
        [self.timer invalidate];
        self.timer = nil;
    }
    //self.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    [self setNeedsDisplay];

}

@end
