//
//  FivePointerStarVC.m
//  note_oc
//
//  Created by hryan on 16/2/15.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "FivePointerStarVC.h"
#import "MyLayerDelegate.h"

@interface FivePointerStarVC ()

#warning 内存管理问题
@property (assign,nonatomic)  CGMutablePathRef starPath;
@property (nonatomic, strong) CALayer *drawLayer;
@property (nonatomic, strong) CALayer *bgLayer;
@property (nonatomic, strong) MyLayerDelegate *layerDelegate;

@end

@implementation FivePointerStarVC

- (void)dealloc {
    self.bgLayer.delegate = nil;
    CGPathRelease(_starPath);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _layerDelegate = [[MyLayerDelegate alloc]initWithViewController:self];
    
    CGMutablePathRef path = CGPathCreateMutable();
    _starPath  = path;

    CGPathMoveToPoint(_starPath, NULL, 240.0, 280.0);
    
    _drawLayer = [CALayer layer];

    [_drawLayer setFrame:CGRectMake(50, 100, 10, 10)];
    _drawLayer.backgroundColor = [UIColor redColor].CGColor;
    
    _bgLayer = [CALayer layer];
    [_bgLayer setFrame:self.view.layer.frame];
    
    [self.view.layer addSublayer:_bgLayer];
    [self.view.layer addSublayer:_drawLayer];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setFrame:CGRectMake(50 , 100 , 100, 100)];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

- (void)action {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path,NULL,240.0, 280.0);
    CGPathAddLineToPoint(path, NULL, 181.0, 99.0);
    CGPathAddLineToPoint(path, NULL, 335.0, 210.0);
    CGPathAddLineToPoint(path, NULL, 144.0, 210.0);
    CGPathAddLineToPoint(path, NULL, 298.0, 99.0);
    CGPathCloseSubpath(path);

    //创建关键帧动画实例
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //关键帧动画定义为10秒，一共6帧，每一帧是10/（6-1）等与2秒
    [animation setDuration:10.0f];
    [animation setDelegate:self];
    [animation setPath:path];
     CGPathRelease(path);
    [self.drawLayer addAnimation:animation forKey:NULL];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self
                                   selector:@selector(legOne:) userInfo:nil
                                    repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:4.0
                                     target:self selector:@selector(legTwo:) userInfo:nil
                                    repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:6.0 target:self
                                   selector:@selector(legThree:) userInfo:nil repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:8.0 target:self selector:@selector(legFour:) userInfo:nil
                                    repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(legFive:) userInfo:nil
                                    repeats:NO];
//
  
    self.bgLayer.name = @"sss";
    self.bgLayer.delegate = self;
}

- (void)legOne:(id)sender {
    CGPathAddLineToPoint(_starPath, NULL, 181.0, 99.0);
    [self.bgLayer setNeedsDisplay];
}
- (void)legTwo:(id)sender {
    CGPathAddLineToPoint(_starPath, NULL, 335.0, 210.0);
    [self.bgLayer setNeedsDisplay];
}
- (void)legThree:(id)sender {
    CGPathAddLineToPoint(_starPath, NULL, 144.0, 210.0);
    [self.bgLayer setNeedsDisplay];
}
- (void)legFour:(id)sender {
    CGPathAddLineToPoint(_starPath, NULL, 298.0, 99.0);
    [self.bgLayer setNeedsDisplay];
}
- (void)legFive:(id)sender {
    CGPathCloseSubpath(_starPath);
    [self.bgLayer setNeedsDisplay];

}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context {
    
    if(layer == _bgLayer){
        CGColorRef white =[UIColor whiteColor].CGColor;
        CGContextSetStrokeColorWithColor(context, white);
        CGContextBeginPath(context);
        CGContextAddPath(context, _starPath);
        CGContextSetLineWidth(context, 3.0);
        CGContextStrokePath(context);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
