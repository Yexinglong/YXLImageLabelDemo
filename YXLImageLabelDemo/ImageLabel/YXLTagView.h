//
//  YXLTagView.h
//  YXLImageLabelDemo
//
//  Created by 叶星龙 on 15/10/26.
//  Copyright © 2015年 叶星龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXLWaterFlowImageView.h"
#import "pch.h"

@interface YXLTagView : UIView
/**
 *  判断是否是正向和反向 NO and YES
 */
@property (nonatomic ,assign) BOOL isPositiveAndNegative;
/**
 *  标签图片+文本
 */
@property (nonatomic ,strong) YXLWaterFlowImageView *imageLabel;
/**
 *  最开始点击是不显示标签图片只显示一个点  默认NO : 不显示标签 NO And 显示 YES
 */
@property (nonatomic ,assign) BOOL isImageLabelShow;
@end
