//
//  YXLWaterFlowImageView.m
//  YXLImageLabelDemo
//
//  Created by 叶星龙 on 15/10/26.
//  Copyright © 2015年 叶星龙. All rights reserved.
//

#import "YXLWaterFlowImageView.h"

@implementation YXLWaterFlowImageView
-(id)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds=YES;
        _labelWaterFlow =[[UILabel alloc]init];
        _labelWaterFlow.font =Font(11);
        _labelWaterFlow.textColor=[UIColor whiteColor];
        _labelWaterFlow.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_labelWaterFlow];
        [_labelWaterFlow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 10, 0, 5));
        }];
    }
    return self;
}
@end
