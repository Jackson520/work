//
//  LCYButon.m
//  test
//
//  Created by Jackson on 16/7/30.
//  Copyright © 2016年 Changyun Liu. All rights reserved.
//

#import "LCYButton.h"

#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface LCYButton ()

@property(nonatomic,assign) CGPoint beginPoint;

@property(nonatomic,assign) float  offsetX;

@property(nonatomic,assign) float offsetY;


@end

@implementation LCYButton

-(instancetype)initButtonWithFrame:(CGRect)frame type:(UIButtonType)type ButtonImageName:(NSString *)imageName target:(id)target action:(SEL)action {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = WIDTH / 2;
        self.layer.masksToBounds = YES;
        self.clipsToBounds = YES;
        self.alpha = 1;
        self.backgroundColor = [UIColor clearColor];
        [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    return  self;
}


//触发的方法

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    self.beginPoint = [touch locationInView:self];
    
}


-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint newPoint = [touch locationInView:self];
    
    self.offsetX = newPoint.x - self.beginPoint.x;
    self.offsetY = newPoint.y - self.beginPoint.y;
    self.center = CGPointMake(self.center.x + self.offsetX, self.center.y + self.offsetY);
}



-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint endPoint = [touch locationInView:self];
    self.offsetX = endPoint.x - self.beginPoint.x;
    self.offsetY = endPoint.y - self.beginPoint.y;
    
    //通过下面的方法可以使button拖动到任意位置
//    if (self.center.y + self.offsetY >64 && self.center.y + self.offsetY < [UIScreen mainScreen].bounds.size.height - 44 && self.center.x + self.offsetX > 0 && self.center.x + self.offsetX < [UIScreen mainScreen].bounds.size.width) {
//        [UIView animateWithDuration:0.3 animations:^{
//            self.center = CGPointMake(self.center.x + self.offsetX, self.center.y + self.offsetY);
//        }];
//    }
    
    
        if(self.center.x + endPoint.x <= kScreenW/2) {
            if(self.center.y + endPoint.y <= (kScreenH)/3 ) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.center = CGPointMake(WIDTH / 2, (kScreenH)/6);
                }];
            }else if(self.center.y + endPoint.y >= kScreenH/3 && self.center.y + endPoint.y <= 2 * kScreenH/3 ) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.center = CGPointMake(WIDTH / 2, (kScreenH)/2);
                }];
            }else if(self.center.y + endPoint.y >= 2 * (kScreenH - 64 )/3 ) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.center = CGPointMake(WIDTH / 2, 7 * (kScreenH)/8);
                }];
            }
        }else if(self.center.x + endPoint.x > (kScreenW )/2) {
            if(self.center.y + endPoint.y <= (kScreenH)/3) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.center = CGPointMake(kScreenW - WIDTH / 2, (kScreenH)/6);
                }];
            }else if(self.center.y + endPoint.y >= (kScreenH - 64)/3 && self.center.y + endPoint.y <= 2 *(kScreenH - 64)/3) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.center = CGPointMake(kScreenW - WIDTH / 2, (kScreenH)/2);
                }];
            }else if(self.center.y + endPoint.y >= 2 *(kScreenH - 64)/3 ) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.center = CGPointMake(kScreenW - WIDTH / 2, 7 * (kScreenH)/8);
                }];
            }
        }
}


@end
