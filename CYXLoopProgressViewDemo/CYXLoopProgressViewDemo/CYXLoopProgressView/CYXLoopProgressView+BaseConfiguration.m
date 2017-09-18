//
//  CYXLoopProgressView+BaseConfiguration.m
//  CYXLoopProgressViewDemo
//
//  Created by 超级腕电商 on 2017/9/16.
//  Copyright © 2017年 超级腕电商. All rights reserved.
//

#import "CYXLoopProgressView+BaseConfiguration.h"

@implementation CYXLoopProgressView (BaseConfiguration)
+ (UIColor *)startColor {
    
    return [UIColor greenColor];
}

+ (UIColor *)centerColor {
    
    return [UIColor yellowColor];
}

+ (UIColor *)endColor {
    
    return [UIColor redColor];
}

+ (UIColor *)backgroundColor {
    
    return [UIColor colorWithRed:38.0 / 255.0 green:130.0 / 255.0 blue:213.0 / 255.0 alpha:0.5];
}

+ (CGFloat)lineWidth {
    
    return 20;
}

+ (CGFloat)startAngle {
    
    return DEGREES_TO_RADOANS(-240);
}

+ (CGFloat)endAngle {
    
    return DEGREES_TO_RADOANS(60);
}

+ (STClockWiseType)clockWiseType {
    return STClockWiseNo;
}
@end
