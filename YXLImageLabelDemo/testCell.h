//
//  testCell.h
//  YXLImageLabelDemo
//
//  Created by ZHY on 2016/10/24.
//  Copyright © 2016年 叶星龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface testCell : UITableViewCell
-(void)initSubviews;

+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString*)identifier;

@property (nonatomic ,weak) UIViewController *viewController;

-(UITableView *)tableView;
@end
