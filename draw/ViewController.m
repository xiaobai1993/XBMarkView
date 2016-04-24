//
//  ViewController.m
//  draw
//
//  Created by 王国栋 on 15/12/29.
//  Copyright © 2015年 xiaobai. All rights reserved.
//

#import "ViewController.h"
#import "XBScorePlateView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// rgb颜色转换带透明度（16进制->10进制）
#define UIColorFromRGBA(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:((float)((rgbValue & 0xFF000000) >> 24))/255.0]
@interface ViewController ()
{
    CAGradientLayer *layer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self two];

    // Do any additional setup after loading the view, typically from a nib.
}

//背景没有渐变
-(void)one
{
    XBScorePlateView * myview = [[XBScorePlateView alloc]initWithFrame:CGRectMake(40, 60, 232, 232)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:myview];
    
    self.view.backgroundColor = [UIColor grayColor];

}
//背景渐变的
-(void)two
{
    
    __block UIColor * bottomColor;
   __block UIColor * topColor;
    __block int top;
    __block int bottom;

    layer = [CAGradientLayer new];
    /**
     * 起点和终点表示的坐标系位置，(0,0)表示左上角，(1,1)表示右下角
     */
    layer.startPoint = CGPointMake(0.5, 0);
    layer.endPoint = CGPointMake(0.5, 1);
    layer.frame = self.view.bounds;
    //设置顶端和底部的渐变颜色
    UIColor * ct = UIColorFromRGB(0xFFd64537);
    UIColor * cb = UIColorFromRGB(0xFFf77345);
    layer.colors = @[(__bridge id)ct.CGColor,(__bridge id)cb.CGColor];
    [layer setNeedsDisplay];
    [self.view.layer addSublayer:layer];

    XBScorePlateView * myview = [[XBScorePlateView alloc]initWithFrame:CGRectMake(40, 60, 232, 232)];
    myview.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    myview.block = ^{

        static float frac = 0;
        frac+=0.05;
        top = [self calculateColor:0xFFd64537 andWithObjColor:0xFF67B03C andWithFraction:frac];
        bottom = [self calculateColor:0xFFf77345 andWithObjColor:0xFF8ECB47 andWithFraction:frac];
        
        topColor = UIColorFromRGB(top);
        bottomColor = UIColorFromRGB(bottom);
        
        layer.colors = @[(__bridge id)topColor.CGColor,(__bridge id)bottomColor.CGColor];
        [layer setNeedsDisplay];

    };
    [self.view addSubview:myview];

}

/**
 *  计算颜色的渐变
 *
 *  @param startColor 开始的颜色
 *  @param objColor   目标颜色
 *  @param f          当前的进度 （0-1）
 *
 *  @return 返回当前的颜色的
 */
-(int )calculateColor:(int)startColor andWithObjColor:(int)objColor andWithFraction:(CGFloat ) f
{
    int curColor;
    int redStartColor = (startColor>>16)&0xff;
    int greenStartColor = (startColor>>8)&0xff;
    int blueStartColor = startColor&0xff;
    
    int redObjColor = (objColor>>16)&0xff;
    int greenObjColor = (objColor>>8)&0xff;
    int blueObjColor = objColor&0xff;
    
    curColor = ((int)(greenStartColor+(greenObjColor - greenStartColor)*f)<<8)|(int)(blueStartColor+(blueObjColor-blueStartColor)*f)|
    ((int)(redStartColor+(redObjColor - redStartColor)*f)<<16);
    return curColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
