//
//  MiYiTagsVC.h
//  MiYi
//
//  Created by 叶星龙 on 15/8/21.
//  Copyright (c) 2015年 北京美耶时尚信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MiYiTagsVC : UIViewController

@property (nonatomic, strong) UIImage  *image;

@property (nonatomic, copy) void (^blockUI)(NSString *string);
@end
