//
//  ViewController.m
//  FLCornerDemo
//
//  Created by fenglin on 16/5/31.
//  Copyright © 2016年 fenglin. All rights reserved.
//

#import "ViewController.h"
#import "TestController.h"
#import "UIImageView+FLCorner.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *imageV1 = [[UIImageView alloc] init];
    UIImageView *imageV2 = [[UIImageView alloc] init];
    UIImageView *imageV3 = [[UIImageView alloc] init];
    UIImageView *imageV4 = [[UIImageView alloc] init];
    UIImageView *imageV5 = [[UIImageView alloc] init];
    
    
    imageV1.frame = CGRectMake(150, 10, 100, 100);
    imageV2.frame = CGRectMake(150, 120, 100, 100);
    imageV3.frame = CGRectMake(150, 230, 100, 100);
    imageV4.frame = CGRectMake(150, 340, 100, 100);
    imageV5.frame = CGRectMake(150, 450, 100, 100);
    
    
    
    [self.view addSubview:imageV1];
    [self.view addSubview:imageV2];
    [self.view addSubview:imageV3];
    [self.view addSubview:imageV4];
    [self.view addSubview:imageV5];
    
    [imageV1 sd_setImageWithURL:[NSURL URLWithString:@"http://pic2.ooopic.com/01/00/13/66bOOOPICd7.jpg"]];
    [imageV2 sd_setImageWithURL:[NSURL URLWithString:@"http://pic2.ooopic.com/01/00/13/66bOOOPICd7.jpg"]];
    [imageV3 sd_setImageWithURL:[NSURL URLWithString:@"http://pic2.ooopic.com/01/00/13/66bOOOPICd7.jpg"]];
    [imageV4 sd_setImageWithURL:[NSURL URLWithString:@"http://pic2.ooopic.com/01/00/13/66bOOOPICd7.jpg"]];
    [imageV5 sd_setImageWithURL:[NSURL URLWithString:@"http://pic2.ooopic.com/01/00/13/66bOOOPICd7.jpg"]];
    
    [imageV1 fl_imageViewWithCorner:50.f];
    [imageV2 fl_imageViewWithCorner:50.f];
    imageV2.contentMode = UIViewContentModeCenter;
    [imageV3 fl_imageViewWithCorner:50.f borderWidth:10.f];
    [imageV4 fl_imageViewWithCorner:50.f borderWidth:10.f borderColor:[UIColor redColor]];
    [imageV5 fl_imageViewWithCorner:50.f borderWidth:10.f borderColor:[UIColor blueColor] rectCorner:UIRectCornerTopLeft | UIRectCornerBottomRight];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self presentViewController:[[TestController alloc] init] animated:YES completion:^{
        nil;
    }];
}


@end
