//
//  YXLTagVC.m
//  YXLImageLabelDemo
//
//  Created by 叶星龙 on 15/10/30.
//  Copyright © 2015年 叶星龙. All rights reserved.
//

#import "YXLTagVC.h"
#import "YXLTagEditorImageView.h"

@interface YXLTagVC ()<UIGestureRecognizerDelegate>
{
    YXLTagEditorImageView *tagEditorImageView;
}



@end

@implementation YXLTagVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view .backgroundColor =HEX_COLOR_VIEW_BACKGROUND;
    
    tagEditorImageView =[[YXLTagEditorImageView alloc]initWithImage:[UIImage imageNamed:@"2011102267331457.jpg"]];
    tagEditorImageView.viewC=self;
    tagEditorImageView.userInteractionEnabled=YES;
    [self.view addSubview:tagEditorImageView];
    [tagEditorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [tagEditorImageView addTagViewText:@"哈哈哈哈" Location:CGPointMake(100, 100) isPositiveAndNegative:YES];
    [tagEditorImageView addTagViewText:@"哈哈lalallallal" Location:CGPointMake(200, 150) isPositiveAndNegative:NO];
    UIBarButtonItem *item =[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(navItemClick)];
    self.navigationItem.rightBarButtonItem=item;
    
}

///**
// *  确定并pop    返回这个图片所有的标签地址内容，是否翻转样式的数组   坐标为这个图片的真实坐标
// */
-(void)navItemClick{
    NSMutableArray *array =[tagEditorImageView popTagModel];
    NSMutableArray *array1 =[NSMutableArray array];
    for(NSDictionary *dic in array){
        BOOL is =dic[@"positiveAndNegative"];
        NSString *positiveAndNegative ;
        if (is) {
            positiveAndNegative=@"正";
        }else{
            positiveAndNegative=@"反";
        }
        NSString *string =[NSString stringWithFormat:@"方向%@坐标%@文本%@",positiveAndNegative,dic[@"point"],dic[@"text"]];
        [array1 addObject:string];
    }
    NSString *string =[array1 componentsJoinedByString:@"\n"];
    _popBlock(string);
    [self.navigationController popViewControllerAnimated:YES];
}

@end
