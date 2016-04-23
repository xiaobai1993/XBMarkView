//
//  ViewController.m
//  draw
//
//  Created by 王国栋 on 15/12/29.
//  Copyright © 2015年 xiaobai. All rights reserved.
//

#import "ViewController.h"
#import "XBScorePlateView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self one];

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
    XBScorePlateView * myview = [[XBScorePlateView alloc]initWithFrame:CGRectMake(40, 60, 232, 232)];
    self.view.backgroundColor = [UIColor whiteColor];
    

    [self.view addSubview:myview];
    myview.SuperViewChange = YES;



}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
