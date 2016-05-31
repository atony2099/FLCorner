//
//  TestController.m
//  FLCornerDemo
//
//  Created by fenglin on 16/5/31.
//  Copyright © 2016年 fenglin. All rights reserved.

#import "TestController.h"
#import "TestTableViewCell.h"

@implementation TestController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 100.f;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestTableViewCell *cell = [TestTableViewCell cellWithTableView:tableView cellForRowAtIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [self dismissViewControllerAnimated:YES completion:nil];
}

@end
