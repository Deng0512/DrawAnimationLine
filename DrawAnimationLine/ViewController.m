//
//  ViewController.m
//  DrawAnimationLine
//
//  Created by 连喜 邓 on 2017/6/29.
//  Copyright © 2017年 连喜 邓. All rights reserved.
//

#import "ViewController.h"
#import "NeedDrawView.h"
#import "ShapeView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    UIImageView *newsLineImage =[[UIImageView alloc]initWithFrame:CGRectMake(106, 215, 125, 109)];
    newsLineImage.image =[UIImage imageNamed:@"kuangBig1.png"];
    [self.view addSubview:newsLineImage];
    
    UIImageView *companyDetailImage =[[UIImageView alloc]initWithFrame:newsLineImage.frame];
    companyDetailImage.image =[UIImage imageNamed:@"xianBig1.png"];
    [self.view addSubview:companyDetailImage];
    companyDetailImage.alpha =0.1f;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0f];
    companyDetailImage.alpha =1.0f;
    [UIView commitAnimations];
    
    [self performSelector:@selector(addAllLinesAction) withObject:self afterDelay:1.0f];
}

-(void)addAllLinesAction
{
    NeedDrawView *pathBuilderView = [[NeedDrawView alloc] initWithFrame:CGRectMake(0, 35, self.view.frame.size.width, self.view.frame.size.height)];
    pathBuilderView.contentMode =UIViewContentModeScaleAspectFill;
    [self.view addSubview:pathBuilderView];
    
    [pathBuilderView setData:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
