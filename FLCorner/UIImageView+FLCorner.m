//
//  UIImageView+FLCornerTool.m
//  FLCornerTool
//
//  Created by fenglin on 16/5/30.
//  Copyright © 2016年 fenglin. All rights reserved.
//

#import "UIImageView+FLCorner.h"
#import <objc/runtime.h>
#import <objc/runtime.h>

@interface UIImage (FLExtension)

@property (nonatomic,assign) BOOL hasClip;

@end

@implementation UIImage (FLExtension)

- (BOOL)hasClip {
    return [objc_getAssociatedObject(self, @selector(hasClip)) boolValue];
}

- (void)setHasClip:(BOOL)hasClip{
    objc_setAssociatedObject(self, @selector(hasClip), @(hasClip), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@interface UIImageView ()

@property (assign, nonatomic) CGFloat      cornerRadius;
@property (assign, nonatomic) CGFloat      borderWidth;
@property (strong, nonatomic) UIColor      *borderColor;
@property (assign,nonatomic ) UIRectCorner rectCorner;
@property (assign, nonatomic) BOOL         isObervering;
@property (assign, nonatomic) BOOL         isRestting;
@property (assign, nonatomic) UIImage      *originalImage;

@end

@implementation UIImageView (FLCornerTool)

#pragma mark - public methods
- (void)fl_imageViewWithCorner:(CGFloat)borderCorner{
    [self fl_imageViewWithCorner:borderCorner borderWidth:0.f];
}

- (void)fl_imageViewWithCorner:(CGFloat)corner borderWidth:(CGFloat)borderWidth{
    [self fl_imageViewWithCorner:corner borderWidth:borderWidth borderColor:[UIColor blackColor]];
}

- (void)fl_imageViewWithCorner:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    [self fl_imageViewWithCorner:cornerRadius borderWidth:borderWidth borderColor:borderColor rectCorner:UIRectCornerAllCorners];
}

- (void)fl_imageViewWithCorner:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor rectCorner:(UIRectCorner)rectCorner{
    
    self.cornerRadius = cornerRadius;;
    self.borderWidth  = borderWidth;
    self.borderColor  = borderColor;
    self.rectCorner   = rectCorner;
    self.isRestting   = YES;
    
    // 监听"image""contetMode"属性的变化,根据其值的变化做出调整
    if (!self.isObervering) {
        [self addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"contentMode" options:NSKeyValueObservingOptionNew context:nil];
        self.isObervering = YES;
        [self swizzleDeallocMethods];
    }
    // 将系统的layoutSubView更换成自定义方法，即时根据imageview的frame变化做出调整
    [self swizzleLayoutMethods];
    
    if (self.image && self.image.hasClip == NO) {
        self.originalImage = self.image;
        [self reSetImage];
    }
}

#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"image"] ){
        UIImage *newImage = self.image;
        if ([newImage isKindOfClass:[UIImage class]] && newImage.hasClip == NO){
            self.originalImage = self.image;
            [self reSetImage];
        }
    }
    
    if ([keyPath isEqualToString:@"contentMode"]) {
        self.originalImage.hasClip = NO;
        self.image = self.originalImage;
    }
}

#pragma mark - draw methods
- (void)reSetImage{
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 异步绘制，提高效率
    dispatch_async(queue, ^{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
        if (!UIGraphicsGetCurrentContext()) {
            return;
        }
        UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:self.rectCorner cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
        [cornerPath addClip];
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        [self drawBorder:cornerPath];
        UIImage *reSetImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (reSetImage) {
                reSetImage.hasClip = YES;
                self.image = reSetImage;
            }
        });
    });
    
    
    
}

- (void)drawBorder:(UIBezierPath *)path{
    if (self.borderColor && self.borderWidth) {
        [path setLineWidth:self.borderWidth];
        [self.borderColor setStroke];
        [path stroke];
    }
}

#pragma mark - runtime Methods
- (void)swizzleLayoutMethods{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oneMethod = class_getInstanceMethod([self class], @selector(layoutSubviews));
        Method anotherMethod = class_getInstanceMethod([self class], @selector(customLayoutSubviews));
        method_exchangeImplementations(oneMethod, anotherMethod);
    });
}

- (void)swizzleDeallocMethods{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oneMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
        Method anotherMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"customDealloc"));
        method_exchangeImplementations(oneMethod, anotherMethod);
    });
}

- (void)customLayoutSubviews{
    [self customLayoutSubviews];
    if (self.isRestting) {
        self.originalImage.hasClip = NO;
        self.image = self.originalImage;
    }
}

- (void)customDealloc{
    if (self.isObervering) {
        [self removeObserver:self forKeyPath:@"image"];
        [self removeObserver:self forKeyPath:@"contentMode"];
    }
    [self customDealloc];
}

#pragma mark - setters and getters
- (CGFloat)cornerRadius{
    return [objc_getAssociatedObject(self, @selector(cornerRadius)) floatValue];
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    objc_setAssociatedObject(self, @selector(cornerRadius), @(cornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)borderWidth{
    return [objc_getAssociatedObject(self, @selector(borderWidth)) floatValue];
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    objc_setAssociatedObject(self, @selector(borderWidth), @(borderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)borderColor {
    return objc_getAssociatedObject(self, @selector(borderColor));
}

- (void)setBorderColor:(UIColor *)borderColor {
    objc_setAssociatedObject(self, @selector(borderColor), borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isObervering {
    return [objc_getAssociatedObject(self, @selector(isObervering)) boolValue];
}

- (void)setIsObervering:(BOOL)isObervering {
    objc_setAssociatedObject(self, @selector(isObervering), @(isObervering), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIRectCorner)rectCorner {
    return [objc_getAssociatedObject(self, @selector(rectCorner)) unsignedLongValue];
}

- (void)setRectCorner:(UIRectCorner)rectCorner {
    objc_setAssociatedObject(self, @selector(rectCorner), @(rectCorner), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)originalImage
{
    return objc_getAssociatedObject(self, @selector(originalImage));
}

- (void)setOriginalImage:(UIImage *)originalImage
{
    objc_setAssociatedObject(self, @selector(originalImage), originalImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isRestting {
    return [objc_getAssociatedObject(self, @selector(isRestting)) boolValue];
}

- (void)setIsRestting:(BOOL)isRestting {
    objc_setAssociatedObject(self, @selector(isRestting), @(isRestting), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
