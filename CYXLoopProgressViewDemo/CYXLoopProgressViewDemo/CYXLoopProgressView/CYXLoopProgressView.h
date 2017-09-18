//
//  CYXLoopProgressView.h
//  CYXLoopProgressViewDemo
//
//  Created by 超级腕电商 on 2017/9/16.
//  Copyright © 2017年 超级腕电商. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM (NSInteger, STClockWiseType) {
    STClockWiseYes,//顺时针
    STClockWiseNo//逆时针
};
@interface CYXLoopProgressView : UIView
//无动画设置 进度
@property (assign, nonatomic) CGFloat persentage;

//初始化 layer图层
-(void)initLayers;
//有动画设置 进度
-(void)setAnimationPersentage:(CGFloat)persentage;

@end
