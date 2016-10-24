//
//  ViewController.m
//  YXLImageLabelDemo
//
//  Created by 叶星龙 on 15/8/29.
//  Copyright (c) 2015年 叶星龙. All rights reserved.
//

#import "ViewController.h"
#import "YXLTagVC.h"
#import "pch.h"
#import "testTable.h"
@interface ViewController ()

@property (nonatomic ,strong) UILabel *   labbel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationController.navigationBar.translucent=NO;
    self.view .backgroundColor =HEX_COLOR_VIEW_BACKGROUND;

    
    UILabel *labbel =[[UILabel alloc]initWithFrame:(CGRect){0,100,kWindowWidth,kWindowHeight-100}];
    labbel.numberOfLines=0;
    labbel.font=Font(15);
    labbel.text=@"这里是显示回调的信息";
    labbel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:labbel];
    _labbel=labbel;
    
    
    UIButton *btn =[[UIButton alloc]initWithFrame:(CGRect){0,0,kWindowWidth,100}];
    [btn setTitle:@"点击跳转标签页面" forState:UIControlStateNormal];
    btn.backgroundColor=[UIColor redColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)btnClick{
    __weak ViewController *weakSelf =self;
    YXLTagVC *tagView =[[YXLTagVC alloc]init];
    tagView.popBlock=^(NSString *string){
        weakSelf.labbel.text=string;
    };
    [self.navigationController pushViewController:tagView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
