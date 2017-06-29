
//
//  NeedDrawView.m
//  DrawAnimationLine
//
//  Created by 连喜 邓 on 14-3-25.
//  Copyright (c) 2014年 连喜 邓. All rights reserved.
//

#import "NeedDrawView.h"
#import "ShapeView.h"

#define CORNERvALUE   7.0f

@interface NeedDrawView ()

@property (nonatomic, strong) NSMutableArray *allPoints;
@property (nonatomic, strong) NSMutableArray *curPoints;
@end

@implementation NeedDrawView

#pragma mark ---------
#pragma mark LifeCycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //清除上一次的画板
    CGContextRef ctn = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctn, rect);
    
    [self drawString:_needDrawString withPoint:_curPoint];
    
    //前面已经显示的条目清空后直接重新划在上面
    if (_chargeIndex) {
        for (int i = 0; i < _chargeIndex; i++) {
            [self drawString:[self.titles objectAtIndex:i] withPoint:[[self.titlePoints objectAtIndex:i] CGPointValue]];
        }
    }
}

#pragma mark ---------
#pragma mark 初始化数据 具体需要啥路径自己调就ok啦
- (void)setData:(NSArray *)array
{
    //假数据
    self.titlePoints = @[[NSValue valueWithCGPoint:CGPointMake(100, 10)],[NSValue valueWithCGPoint:CGPointMake(200, 10)],[NSValue valueWithCGPoint:CGPointMake(300, 10)]];
    
    //关注的行业
    NSMutableArray *points1 = [NSMutableArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(131, 180)],[NSValue valueWithCGPoint:CGPointMake(131, 100)], nil];
    //关注的公司
    NSMutableArray *points2 = [NSMutableArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(182, 180)],[NSValue valueWithCGPoint:CGPointMake(182, 116)],[NSValue valueWithCGPoint:CGPointMake(235, 116)],[NSValue valueWithCGPoint:CGPointMake(235, 86)], nil];
    //关注的新闻
    NSMutableArray *points3 = [NSMutableArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(108, 210)],[NSValue valueWithCGPoint:CGPointMake(45, 210)],[NSValue valueWithCGPoint:CGPointMake(45, 171)], nil];
    //空间
    NSMutableArray *points4 = [NSMutableArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(230, 210)],[NSValue valueWithCGPoint:CGPointMake(325, 210)], nil];
    
    //会议
    NSMutableArray *points5 = [NSMutableArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(152, 285)],[NSValue valueWithCGPoint:CGPointMake(152, 350)],[NSValue valueWithCGPoint:CGPointMake(85, 350)], nil];
    //专栏
    NSMutableArray *points6 = [NSMutableArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(166, 285)],[NSValue valueWithCGPoint:CGPointMake(166, 398)], nil];
    
    NSMutableArray *points7 = [NSMutableArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(180, 285)],[NSValue valueWithCGPoint:CGPointMake(180, 349)],[NSValue valueWithCGPoint:CGPointMake(232, 349)], nil];
    self.allPoints = [NSMutableArray arrayWithObjects:points1,points2,points3,points4,points5,points6,points7, nil];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
   // [self showTitlesAnimationBegin];//显示title动画
    [self showLinesAnimationBegin];//显示线条动画
}

- (void)showLinesAnimationBegin
{
    NSArray *timeArray =[NSArray arrayWithObjects:@"1.3",@"2.0",@"1.5",@"1.5",@"1.5",@"1.2",@"1.5", nil];
    for (int i=0; i<[self.allPoints count]; i++)
    {
        self.curPoints = [self.allPoints objectAtIndex:i];
        //添加path的UIView
        ShapeView  *pathShapeView = [[ShapeView alloc] init];
        pathShapeView.backgroundColor = [UIColor clearColor];
        pathShapeView.opaque = NO;
        pathShapeView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:pathShapeView];
        
        //设置线条的颜色
        UIColor *pathColor = nil;
        pathColor = [UIColor colorWithRed:96.0/255 green:142.0/255 blue:190.0/255 alpha:1.0f];
        pathShapeView.shapeLayer.fillColor = nil;
        pathShapeView.shapeLayer.strokeColor = pathColor.CGColor;
        pathShapeView.shapeLayer.lineWidth = 2.5f;
        
        //创建动画
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
        animation.fromValue = @0.0;
        animation.toValue = @1.0;
        animation.duration = [[timeArray objectAtIndex:i] floatValue];//kDuration;
        [pathShapeView.shapeLayer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
        [self updatePathsWithPathShapeView:pathShapeView];
        
        if (i == [self.allPoints count]-1) {
            _lindex = 0;
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            return;
        }
    }
}

- (void)updatePathsWithPathShapeView:(ShapeView *)pathShapeView
{
    if ([self.curPoints count] >= 2) {
        UIBezierPath *path = [[UIBezierPath alloc] init];
        [path moveToPoint:[[self.curPoints firstObject] CGPointValue]];
        
        //设置路径的颜色和动画
        //起始画圆圈
        //CGPoint point = [[self.curPoints firstObject] CGPointValue];
        //[path appendPath:[UIBezierPath bezierPathWithArcCenter:point radius:CORNERvALUE / 2.0 startAngle:0.0 endAngle:2 * M_PI clockwise:YES]];
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, [self.curPoints count] - 1)];
        [self.curPoints enumerateObjectsAtIndexes:indexSet
                                       options:0
                                    usingBlock:^(NSValue *pointValue, NSUInteger idx, BOOL *stop) {
                                        [path addLineToPoint:[pointValue CGPointValue]];
                                        //终点圆圈
                                        //[path appendPath:[UIBezierPath bezierPathWithArcCenter:[pointValue CGPointValue] radius:CORNERvALUE / 2.0 startAngle:0.0 endAngle:2 * M_PI clockwise:YES]];

                                    }];
        path.usesEvenOddFillRule = YES;
        pathShapeView.shapeLayer.path = path.CGPath;
    }
    else {
        pathShapeView.shapeLayer.path = nil;
    }
}

- (NSArray *)handleArrayAllObjectWithNewlineCharacters:(NSArray *)array
{
    NSMutableArray *titles = [NSMutableArray arrayWithCapacity:[array count]];
    for (int i = 1; i <= [array count]; i++) {
        NSString *titlesString = [array objectAtIndex:i-1];
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:[titlesString length]];
        for (int m = 0; m < [titlesString length]; m++) {
            NSString *charS = [titlesString substringWithRange:NSMakeRange(m, 1)];
            [tempArray addObject:charS];
        }
        NSString *string = [tempArray componentsJoinedByString:@"\n"];
        [titles addObject:string];
    }
    return [titles copy];
}

- (void)showTitlesAnimationBegin
{
    if (_titleIndex == [self.titles count]) {
        _chargeIndex = 0;
        _titleIndex = 0;
        return;
    }
    _curPoint = [[self.titlePoints objectAtIndex:_titleIndex] CGPointValue];
    _curString = [self.titles objectAtIndex:_titleIndex];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateCurrentString) userInfo:nil repeats:YES];
    _titleIndex++;
}

/*
 *改变当前需要显示的那个String
 */
- (void)updateCurrentString
{
    static int m = 1;
    if (m == [_curString length]+1) {
        [self.timer invalidate];
        self.timer = nil;
        m = 1;
        ++_chargeIndex;
        [self showTitlesAnimationBegin];
        return;
    } else {
        _needDrawString  = [_curString substringWithRange:NSMakeRange(0,m)];
        m++;
        [self setNeedsDisplay];
    }
}

- (void)drawString:(NSString *)text withPoint:(CGPoint)point
{
    //设置字体大小
    UIFont *font = [UIFont systemFontOfSize:20];
    UIColor *redColor = [UIColor redColor];
    //设置文本字体属性
    NSDictionary *dic = @{NSFontAttributeName: font,NSForegroundColorAttributeName:redColor};
    [text drawAtPoint:point withAttributes:dic];
}

#pragma mark -----------
#pragma mark CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    _lindex++;
    if (_lindex == [self.allPoints count]) {
        _lindex = 0;
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        return;
    }
    [self showLinesAnimationBegin];
}

@end
