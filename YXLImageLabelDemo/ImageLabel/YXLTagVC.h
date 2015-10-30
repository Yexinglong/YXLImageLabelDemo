//
//  YXLTagVC.h
//  YXLImageLabelDemo
//
//  Created by 叶星龙 on 15/10/30.
//  Copyright © 2015年 叶星龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXLTagVC : UIViewController

@property (nonatomic, copy) void (^popBlock)(NSString *string);
@end
