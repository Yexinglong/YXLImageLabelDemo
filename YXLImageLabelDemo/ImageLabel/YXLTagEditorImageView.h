//
//  YXLTagEditorImageView.h
//  YXLImageLabelDemo
//
//  Created by 叶星龙 on 15/10/26.
//  Copyright © 2015年 叶星龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pch.h"
@interface YXLTagEditorImageView : UIView

/**
 *  初始化并添加一张图片
 *
 *  @param image 作为点选标签的底图
 */
-(id)initWithImage:(UIImage *)image;
/**
 *  图片尺寸初始化
 */
-(void)scaledFrame;
/**
 *  添加已有的标签
 *
 *  @param text  标签文本
 *  @param point 
 *  标签的位置  位置都是以点的起始位置  正向标签X取最小值  反向则取最大值 Y值为标签的Y值
 *  如果是取本demo里面值则不需要修改直接传入,如果是自定义的需要参考一下上面标签位置的逻辑！否则会有点偏移
 *  @param isPositiveAndNegative 标签这个样式是正还是反
 */
-(void)addTagViewText:(NSString *)text Location:(CGPoint )point isPositiveAndNegative:(BOOL)isPositiveAndNegative;
/**
 *  获取所有标签信息
 *
 *  @return 数组里面包含一个字典 @{@"positiveAndNegative":positiveAndNegative,@"point":point,@"text":tag.imageLabel.labelWaterFlow.text}
    positiveAndNegative  标签样式正反
    point                标签坐标
    text                 标签文本
 */
-(NSMutableArray *)popTagModel;

/**
 *  如果是网络图片在SDWebimage回调中并调用初始化Frame方法
 */
@property (nonatomic ,strong) UIImageView *imagePreviews;


@property (nonatomic ,strong) UIViewController *viewC;




@end
