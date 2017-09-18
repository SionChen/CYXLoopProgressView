//
//  CYXLoopProgressView.m
//  CYXLoopProgressViewDemo
//
//  Created by 超级腕电商 on 2017/9/16.
//  Copyright © 2017年 超级腕电商. All rights reserved.
//

#import "CYXLoopProgressView.h"
#import "CYXLoopProgressView+BaseConfiguration.h"

#define SELF_WIDTH CGRectGetWidth(self.bounds)
#define SELF_HEIGHT CGRectGetHeight(self.bounds)
@interface CYXLoopProgressView ()<CAAnimationDelegate>

@property (strong, nonatomic) CAShapeLayer *colorMaskLayer; // 渐变色遮罩
@property (strong, nonatomic) CAShapeLayer *colorLayer; // 渐变色
@property (strong, nonatomic) CAShapeLayer *blueMaskLayer; // 蓝色背景遮罩

@end

@implementation CYXLoopProgressView


-(instancetype)init{
    if (self =[super init]) {
        self.backgroundColor = [CYXLoopProgressView backgroundColor];
    }
    return self;
}

/**
 初始化layer 在完成frame赋值后调用一下
 */
-(void)initLayers{
    [self setupColorLayer];
    [self setupColorMaskLayer];
    [self setupBlueMaskLayer];
}

/**
 *  设置整个蓝色view的遮罩
 */
- (void)setupBlueMaskLayer {
    
    CAShapeLayer *layer = [self generateMaskLayer];
    self.layer.mask = layer;
    self.blueMaskLayer = layer;
}

/**
 *  设置渐变色，渐变色由左右两个部分组成，左边部分由黄到绿，右边部分由黄到红
 */
- (void)setupColorLayer {
    
    self.colorLayer = [CAShapeLayer layer];
    self.colorLayer.frame = self.bounds;
    [self.layer addSublayer:self.colorLayer];
    
    CAGradientLayer *leftLayer = [CAGradientLayer layer];
    leftLayer.frame = CGRectMake(0, 0, SELF_WIDTH / 2, SELF_HEIGHT);
    // 分段设置渐变色
    leftLayer.locations = @[@0.3, @0.9, @1];
    leftLayer.colors = @[(id)[CYXLoopProgressView centerColor].CGColor, (id)[CYXLoopProgressView startColor].CGColor];
    [self.colorLayer addSublayer:leftLayer];
    
    CAGradientLayer *rightLayer = [CAGradientLayer layer];
    rightLayer.frame = CGRectMake(SELF_WIDTH / 2, 0, SELF_WIDTH / 2, SELF_HEIGHT);
    rightLayer.locations = @[@0.3, @0.9, @1];
    rightLayer.colors = @[(id)[CYXLoopProgressView centerColor].CGColor, (id)[CYXLoopProgressView endColor].CGColor];
    [self.colorLayer addSublayer:rightLayer];
}

/**
 *  设置渐变色的遮罩
 */
- (void)setupColorMaskLayer {
    
    CAShapeLayer *layer = [self generateMaskLayer];
    layer.lineWidth = [CYXLoopProgressView lineWidth] + 0.5; // 渐变遮罩线宽较大，防止蓝色遮罩有边露出来
    self.colorLayer.mask = layer;
    self.colorMaskLayer = layer;
}

/**
 *  生成一个圆环形的遮罩层
 *  因为蓝色遮罩与渐变遮罩的配置都相同，所以封装出来
 *
 *  @return 环形遮罩
 */
- (CAShapeLayer *)generateMaskLayer {
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    
    // 创建一个圆心为父视图中点的圆，半径为父视图宽的2/5，起始角度是从-240°到60°
    
    UIBezierPath *path = nil;
    if ([CYXLoopProgressView clockWiseType]) {
        path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(SELF_WIDTH / 2, SELF_HEIGHT / 2) radius:SELF_WIDTH / 2.5 startAngle:[CYXLoopProgressView startAngle] endAngle:[CYXLoopProgressView endAngle] clockwise:YES];
    } else {
        path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(SELF_WIDTH / 2, SELF_HEIGHT / 2) radius:SELF_WIDTH / 2.5 startAngle:[CYXLoopProgressView endAngle] endAngle:[CYXLoopProgressView startAngle] clockwise:NO];
    }
    
    layer.lineWidth = [CYXLoopProgressView lineWidth];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor; // 填充色为透明（不设置为黑色）
    layer.strokeColor = [UIColor blackColor].CGColor; // 随便设置一个边框颜色
    layer.lineCap = kCALineCapRound; // 设置线为圆角
    self.colorMaskLayer.strokeEnd = 0.0;
    return layer;
}

/**
 通过动画设置进度条

 @param persentage 进度百分比
 */
-(void)setAnimationPersentage:(CGFloat)persentage{
    CGFloat startPersentage = self.persentage;
    [self setPersentage:persentage];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:startPersentage];
    pathAnimation.toValue = [NSNumber numberWithFloat:persentage];
    pathAnimation.autoreverses = NO;
    pathAnimation.delegate = self;
    [self.colorMaskLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}
#pragma mark CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
}

/**
 *  在修改百分比的时候，修改彩色遮罩的大小
 *
 *  @param persentage 百分比
 */
- (void)setPersentage:(CGFloat)persentage {
    
    _persentage = persentage;
    self.colorMaskLayer.strokeEnd = persentage;
}
@end
