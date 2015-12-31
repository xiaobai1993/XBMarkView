//
//  CountView.m
//  LeXiao
//
//  Created by 王国栋 on 15/12/29.
//  Copyright © 2015年 lexiao. All rights reserved.
//

#import "ScoreView.h"

@implementation ScoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
-(void)setListArr:(NSArray *)listArr
{
    _listArr = listArr;
    
    int row =2 ;//每行2个
    CGFloat itemW = self.frame.size.width/row;
    CGFloat itemH = self.frame.size.height/(listArr.count/row);
    CGFloat itemLeftInset=20;
    CGFloat itemTopInset=20;
    for (int i=0; i<_listArr.count; i++) {

        CGFloat itemX = i%row*itemW;
        CGFloat itemY = i/row*itemH;
        
        UIView * itemView = [[UIView alloc]initWithFrame:CGRectMake(itemX, itemY, itemW, itemH)];
        [self addSubview:itemView];
        
        CGFloat lableW = itemW - 2*itemLeftInset;
        CGFloat labelH = itemH - 2*itemTopInset;
        
        UILabel * itemCount = [[UILabel alloc]initWithFrame:CGRectMake(itemLeftInset, itemTopInset, lableW, labelH)];
        itemCount.textAlignment = NSTextAlignmentCenter;
        itemCount.font = [UIFont systemFontOfSize:18];
        
        [itemView addSubview:itemCount];
        UILabel * itemName = [[UILabel alloc]initWithFrame:CGRectMake(itemLeftInset, CGRectGetMaxY(itemCount.frame), lableW, labelH)];
        itemName.textAlignment = NSTextAlignmentCenter;
        itemName.font = [UIFont systemFontOfSize:12];
        [itemView addSubview:itemName];
        
    }
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
