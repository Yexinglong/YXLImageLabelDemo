//
//  YXLTagView.m
//  YXLImageLabelDemo
//
//  Created by 叶星龙 on 15/10/26.
//  Copyright © 2015年 叶星龙. All rights reserved.
//

#import "YXLTagView.h"
#import "NSTimer+Addition.h"
@interface YXLTagView ()
{
    UIImage *imageLabelIcon;
    NSTimer *timerAnimation;
    UIView *viewSpread;
    UIView *viewTapDot;
    
}
@end

@implementation YXLTagView

-(instancetype)init
{
    self =[super init];
    if (self) {
        imageLabelIcon=[UIImage imageNamed:@"textTag"];
        timerAnimation =[NSTimer scheduledTimerWithTimeInterval:3
                                                              target:self
                                                            selector:@selector(animationTimerDidFired)
                                                            userInfo:nil
                                                             repeats:YES];
        [self initUI];
    }
    
    return self;
}

#pragma -mark 初始化
-(void)initUI{
    _imageLabel =[self getImageLabel];
    _imageLabel.hidden=YES;
    [_imageLabel sizeToFit];
    [_imageLabel.labelWaterFlow addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    [self addSubview:_imageLabel];
    [_imageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(8));
        make.centerY.equalTo(self);
        make.width.greaterThanOrEqualTo(@(CGWidth(_imageLabel.frame)));
        make.height.equalTo(@(CGHeight(_imageLabel.frame)));
    }];
    
    viewSpread =[self getViewSpread];
    viewSpread.layer.cornerRadius=7.5/2;
    [self addSubview:viewSpread];
    [viewSpread mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(7.5, 7.5));
    }];
    
    viewTapDot =[self getViewTapDot];
    viewTapDot.layer.cornerRadius=7.5/2;
    [self addSubview:viewTapDot];
    [viewTapDot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(7.5, 7.5));
    }];
    
    [timerAnimation resumeTimer];
}

#pragma -mark KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([object isEqual:_imageLabel.labelWaterFlow] && [keyPath isEqualToString:@"text"]) {
       
            if (_isPositiveAndNegative) {
                UIImage *image =[UIImage imageNamed:@"textTagAnti"];
                _imageLabel.image=[image resizableImageWithCapInsets:UIEdgeInsetsMake(3, 3, 3, 9)];
                [self setIsPositiveAndNegative:YES];
            }else{
                UIImage *image =[UIImage imageNamed:@"textTag"];
                _imageLabel.image=[image resizableImageWithCapInsets:UIEdgeInsetsMake(3, 9, 3, 3)];
                [self setIsPositiveAndNegative:NO];
            }

    }
}

#pragma -mark 监听
/**
 *  播放动画
 */
-(void)animationTimerDidFired{
    [UIView animateWithDuration:1 animations:^{
        viewTapDot.transform = CGAffineTransformMakeScale(1.3,1.3);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            viewTapDot.transform = CGAffineTransformIdentity;
        }completion:^(BOOL finished) {
            viewSpread.alpha=1;
            [UIView animateWithDuration:1 animations:^{
                viewSpread.alpha=0;
                viewSpread.transform = CGAffineTransformMakeScale(5,5);
            }completion:^(BOOL finished) {
                viewSpread.transform = CGAffineTransformIdentity;
            }];
        }];
        
    }];
}


-(void)setIsPositiveAndNegative:(BOOL)isPositiveAndNegative{
    _isPositiveAndNegative=isPositiveAndNegative;
    
    CGSize size =[_imageLabel.labelWaterFlow.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:Font(11),NSFontAttributeName, nil]];
    CGFloat W;
    if (CGWidth(imageLabelIcon)-15 > size.width) {
        W=0;
    }else{
        W=size.width-(CGWidth(imageLabelIcon)-15);
    }
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.greaterThanOrEqualTo(@(CGWidth(imageLabelIcon)+8+W));
        if(isPositiveAndNegative){
            make.left.equalTo(@(CGRectGetMaxX(self.frame)-(CGWidth(imageLabelIcon)+8+W)));
            UIImage *image =[UIImage imageNamed:@"textTagAnti"];
            _imageLabel.image=[image resizableImageWithCapInsets:UIEdgeInsetsMake(3, 3, 3, 9)];
            [_imageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@0);
            }];
            [_imageLabel.labelWaterFlow mas_updateConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(_imageLabel).insets(UIEdgeInsetsMake(0, 5, 0, 10));
            }];
            [viewSpread mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@(CGWidth(imageLabelIcon)+W+0.5));
            }];
            [viewTapDot mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@(CGWidth(imageLabelIcon)+W+0.5));
            }];
        }else{
            UIImage *image =[UIImage imageNamed:@"textTag"];
            _imageLabel.image=[image resizableImageWithCapInsets:UIEdgeInsetsMake(3, 9, 3, 3)];
            [_imageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@8);
            }];
            [_imageLabel.labelWaterFlow mas_updateConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(_imageLabel).insets(UIEdgeInsetsMake(0, 10, 0, 5));
            }];
            [viewSpread mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@0);
            }];
            [viewTapDot mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@0);
            }];
        }

    }];

}

-(void)setIsImageLabelShow:(BOOL)isImageLabelShow{
    _isImageLabelShow=isImageLabelShow;
    if (isImageLabelShow) {
        _imageLabel.hidden=NO;
    }else{
        _imageLabel.hidden=YES;
    }
}
#pragma -mark init

-(UIView *)getViewSpread{
    UIView *view =[UIView new];
    view.backgroundColor=UIColorRGBA(0, 0, 0, 0.7);
    view.userInteractionEnabled=NO;
    return view;
}

-(YXLWaterFlowImageView *)getImageLabel{
    YXLWaterFlowImageView *image =[YXLWaterFlowImageView new];
    image.image=[UIImage imageNamed:@"textTag"];
    image.userInteractionEnabled=YES;
    return image;
}

-(UIView *)getViewTapDot{
    UIView *view =[UIView new];
    view.backgroundColor=HEX_COLOR_THEME;
    view.userInteractionEnabled=NO;
    return view;
}


-(BOOL)canBecomeFirstResponder
{
    return YES;
};

-(void)dealloc
{
    [_imageLabel.labelWaterFlow removeObserver:self
                           forKeyPath:@"text"];
}
@end
