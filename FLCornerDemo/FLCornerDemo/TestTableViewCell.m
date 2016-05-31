//
//  TestTableViewCell.m
//  FLCornerDemo
//
//  Created by fenglin on 16/5/31.
//  Copyright © 2016年 fenglin. All rights reserved.


#import "TestTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+FLCorner.h"

@implementation TestTableViewCell

+ (id)cellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indePath{
    static NSString *identifier = @"CountryImageCell";
    [tableView registerClass:[TestTableViewCell class] forCellReuseIdentifier:identifier];
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indePath];
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initImageView];
    }
    return self;
}

- (void)initImageView
{
    CGFloat width = 100;
    CGFloat height = 100;
    CGFloat y = 0;
    
    CGFloat count = [UIScreen mainScreen].bounds.size.width / width;
    for (NSInteger i = 0; i < count; i++) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.frame = CGRectMake(i*width, y, width, height);
        [self.contentView addSubview:imageV];
        [imageV sd_setImageWithURL:[NSURL URLWithString:@"http://pic2.ooopic.com/01/01/00/66bOOOPIC8b.jpg"]];
         
//        imageV.layer.cornerRadius = 50.f;
//        imageV.layer.masksToBounds = YES;
        [imageV fl_imageViewWithCorner:50.f];
       
    }
}


@end
