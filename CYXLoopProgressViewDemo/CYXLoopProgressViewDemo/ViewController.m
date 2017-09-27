//
//  ViewController.m
//  CYXLoopProgressViewDemo
//
//  Created by 超级腕电商 on 2017/9/16.
//  Copyright © 2017年 超级腕电商. All rights reserved.

#import "ViewController.h"
#import "CYXLoopProgressView.h"

#define screenWidth      [UIScreen mainScreen].bounds.size.width
#define screenHeight     [UIScreen mainScreen].bounds.size.height
@interface ViewController ()

@property (nonatomic,strong) CYXLoopProgressView *loopProgressView;
@property (nonatomic,strong) UISlider *slider;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initViews];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.loopProgressView setAnimationPersentage:0.5];
    });
}
-(void)initViews{
    self.loopProgressView.frame = CGRectMake(30, 100, screenWidth-30*2, screenWidth-30*2);
    [self.loopProgressView initLayers];
    [self.view addSubview:self.loopProgressView];
    
    self.slider.frame = CGRectMake(30, screenHeight-60, screenWidth-30*2, 20);
    [self.view addSubview:self.slider];
}




#pragma mark Actions
-(void)sliderValueChanged:(UISlider *)slider{
    self.loopProgressView.persentage = slider.value;
}

#pragma mark G
-(CYXLoopProgressView*)loopProgressView{
    if(!_loopProgressView){
        _loopProgressView = [[CYXLoopProgressView alloc] init];
        
    }
    return _loopProgressView;
}
-(UISlider*)slider{
    if(!_slider){
        _slider = [[UISlider alloc] init];
        _slider.tintColor = [UIColor blueColor];
        _slider.value = 0.5;
        [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

@end
