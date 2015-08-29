//
//  MiYiTagView.h
//  MiYi
//
//  Created by 叶星龙 on 15/8/26.
//  Copyright (c) 2015年 北京美耶时尚信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MiYiWaterflowImage.h"
@interface MiYiTagView : UIView

//@property (nonatomic ,weak) uil
/**
 *  默认Yes的时候就是标签没搞好,所以再次点击时候就会把原来的那个删除掉   NO就是搞好了  必选
 */
@property (nonatomic ,assign) BOOL isTagImageShow;


@property (nonatomic ,strong) MiYiWaterflowImage *waterflowImage;

/**
 *  YES是反向  NO是正向  默认是NO
 */
@property (nonatomic ,assign) BOOL overturn;

@end
