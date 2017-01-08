//
//  UIView+JGExtension.m
//  百思
//
//  Created by JUN on 16/5/16.
//  Copyright © 2016年 JUN. All rights reserved.
//

#import "UIView+JGExtension.h"

@implementation UIView (JGExtension)

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(void)setBottom:(CGFloat)bottom{
    CGRect frame = self.frame;
    CGFloat diff = bottom - (self.frame.origin.y + self.frame.size.height);
    frame.origin.y += diff;
    self.frame = frame;
    
}

-(void)setRight:(CGFloat)right{
    CGRect frame = self.frame;
    CGFloat diff = right - (self.frame.origin.x + self.frame.size.width);
    frame.origin.x += diff;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

-(CGFloat)bottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGSize)size {
    return self.frame.size;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

-(CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (CGFloat)centerX
{
    return self.center.x;
}
@end
