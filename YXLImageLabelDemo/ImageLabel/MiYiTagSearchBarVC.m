//
//  MiYiTagSearchBarVC.m
//  MiYi
//
//  Created by 叶星龙 on 15/8/27.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "MiYiTagSearchBarVC.h"
#import "pch.h"
@interface MiYiTagSearchBarVC ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) UISearchBar *searchBar;

@property (nonatomic, strong) UITextField *searchField;

@property (nonatomic ,strong) UITableView *tableView ;

@property (nonatomic ,strong) NSArray *dataList;

@property (strong, nonatomic) NSMutableDictionary *sectionDict;

@end

@implementation MiYiTagSearchBarVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"2" ofType:@"plist"];
    self.dataList = [NSArray arrayWithContentsOfFile:path];
    
    
    _searchBar =[[UISearchBar alloc]init];
    [self.searchBar setPlaceholder:@"搜索"];
    [self.searchBar setTintColor:HEX_COLOR_THEME];
    [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"TagSearchBar"] forState:UIControlStateNormal];
    self.searchBar.delegate=self;
    self.navigationItem.titleView=_searchBar;
    
    UITableView *tableView =[[UITableView alloc]initWithFrame:(CGRect){0,0,kWindowWidth,kWindowHeight-64}];
    tableView.backgroundColor=HEX_COLOR_VIEW_BACKGROUND;
    tableView.dataSource=self;
    tableView.delegate=self;
    [tableView setSectionHeaderHeight:50];
    [tableView setRowHeight:50];
    [self.view addSubview:tableView];

    self.sectionDict = [NSMutableDictionary dictionaryWithCapacity:self.dataList.count];
    
    // Do any additional setup after loading the view.
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@",searchBar.text);
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dict = self.dataList[section];
    
    NSArray *array = dict[@"friends"];
    
    return array.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"TagSearchBarCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSDictionary *dict = self.dataList[indexPath.section];
    
    NSArray *array = dict[@"friends"];
    
    [cell.textLabel setText:array[indexPath.row]];
    
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dict = self.dataList[section];
    return dict[@"group"];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.dataList[indexPath.section];
    
    NSArray *array = dict[@"friends"];
    _block(array[indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
}
@end
