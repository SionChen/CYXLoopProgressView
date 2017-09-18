//
//  CYXLoopProgressView+BaseConfiguration.h
//  CYXLoopProgressViewDemo
//
//  Created by 超级腕电商 on 2017/9/16.
//  Copyright © 2017年 超级腕电商. All rights reserved.
//

#import "CYXLoopProgressView.h"
#define DEGREES_TO_RADOANS(x) (M_PI * (x) / 180.0) // 将角度转为弧度
@interface CYXLoopProgressView (BaseConfiguration)
// 起始颜色
+ (UIColor *)startColor;

// 中间颜色
+ (UIColor *)centerColor;

// 结束颜色
+ (UIColor *)endColor;

// 背景色
+ (UIColor *)backgroundColor;

// 线宽
+ (CGFloat)lineWidth;

// 起始角度（根据顺时针计算，逆时针则是结束角度）
+ (CGFloat)startAngle;

// 结束角度（根据顺时针计算，逆时针则是起始角度）
+ (CGFloat)endAngle;

// 进度条起始方向（YES为顺时针，NO为逆时针）
+ (STClockWiseType)clockWiseType;
@end
