# DrawAnimationLine
CABasicAnimation + CAShapeLayer 实现动画画线。

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
        pathShapeView.shapeLayer.lineWidth = LINEWIDE;
        
        //创建动画
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
        animation.fromValue = @0.0;
        animation.toValue = @1.0;
        animation.duration = [[timeArray objectAtIndex:i] floatValue];//kDuration;
        [pathShapeView.shapeLayer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
        [self updatePathsWithPathShapeView:pathShapeView];
