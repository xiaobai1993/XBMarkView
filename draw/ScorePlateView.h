//
//  MyView.h
//  draw
//
//  Created by 王国栋 on 15/12/29.
//  Copyright © 2015年 xiaobai. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *   自定义变量里面以s结尾的表示具体的数值，否则表示的是表示显示具体内容的标签，以lbe的表示对内容的说明
 
     比如comments 表示的具体评价内容，comment 表示评价的具体内容，lbecomment 是一个显示 "评价："的标签
 */

@interface ScorePlateView : UIView

/*速度满意度*/
@property (nonatomic,assign) CGFloat speedValues;

/*态度满意度*/
@property (nonatomic,assign) CGFloat altitudeValues;

/*把半圆分割的份数*/
@property (nonatomic,assign) int precision;
/**
 *  整体评价
 */
@property (nonatomic,strong) NSString * comments;
/**
 *  满分是多少分
 */
@property (nonatomic,assign) CGFloat fullValues;
/**
 *  综合评分
 */
@property (nonatomic,assign) CGFloat compreValues;
/**
 *  开始角度
 */

@property (nonatomic,assign) CGFloat  startAngle;
/**
 *  终止角度
 */
@property (nonatomic,assign) CGFloat  endAngle;

//-(void)startAnimation;
@end
