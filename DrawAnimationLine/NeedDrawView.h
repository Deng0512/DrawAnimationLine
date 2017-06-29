//
//  NeedDrawView.h
//  DrawAnimationLine
//
//  Created by 连喜 邓 on 14-3-25.
//  Copyright (c) 2014年 连喜 邓. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShapeView;

@interface NeedDrawView : UIView
{
    NSString *_curString;//当前要画得那个String
    CGPoint   _curPoint;
    NSString *_needDrawString;//需要DrawRect的String
    int       _titleIndex;//title的索引
    int       _chargeIndex;//一条title显示结束index+1;
    int       _lindex;//线条的索引
}
@property (nonatomic,strong,readonly)ShapeView *pathShapeView;
@property(nonatomic, strong) NSArray *titlePoints;
@property(nonatomic, strong) NSArray *titles;
@property(nonatomic, strong) NSTimer *timer;

- (void)setData:(NSArray *)array;
@end
