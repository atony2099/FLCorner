//
//  UIImageView+FLCornerTool.h
//  FLCornerTool
//
//  Created by fenglin on 16/5/30.
//  Copyright © 2016年 fenglin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (FLCorner)

- (void)fl_imageViewWithCorner:(CGFloat)corner;
- (void)fl_imageViewWithCorner:(CGFloat)corner borderWidth:(CGFloat)borderWidth;
- (void)fl_imageViewWithCorner:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor;
- (void)fl_imageViewWithCorner:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor rectCorner:(UIRectCorner)rectCorner;

@end
