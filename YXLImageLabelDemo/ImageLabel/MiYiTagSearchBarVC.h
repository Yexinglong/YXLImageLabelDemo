//
//  MiYiTagSearchBarVC.h
//  MiYi
//
//  Created by 叶星龙 on 15/8/27.
//  Copyright (c) 2015年 北京美耶时尚信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MiYiTagSearchBarVC : UIViewController

@property (nonatomic ,copy) void (^block)(NSString *text);


@end
