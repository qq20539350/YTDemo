//
//  ViewController.m
//  search_demo
//
//  Created by YT_lwf on 2017/5/31.
//  Copyright © 2017年 YT_lwf. All rights reserved.
//


#import "ViewController.h"
#import "YTSearchController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchResultsUpdating,YTSearchTableViewDelegate>

/**
 * tableview
 */
@property(nonatomic,strong) UITableView            *mytableView;
/**
 * 展示数据
 */
@property(nonatomic,strong) NSMutableArray       *dataArray;
/**
 * 搜索到的数据
 */
@property(nonatomic,strong) NSMutableArray      *filteredArray;
/**
 * vc
 */
@property(nonatomic,strong) YTresultViewController      *resultVc;
/**
 * searchbar-textfile
 */
@property(nonatomic,strong) UITextField      *searchBartextFile;
/**
 * searchbar-button
 */
@property(nonatomic,strong) UIButton      *searchBarBtn;

@property(nonatomic,strong) YTSearchController        *searchController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"TEST";
    self.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.mytableView];
    self.mytableView.tableHeaderView = self.searchController.searchBar;
//    self.mytableView.tableHeaderView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    UILabel *title = [[UILabel alloc] init];
    title.text = @"我的群组";
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont systemFontOfSize:18];
    [title sizeToFit];
    self.definesPresentationContext = YES;
    self.navigationItem.titleView = title;
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor blueColor]];
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:36/255.0 green:52/255.0 blue:81/255.0 alpha:1]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - 请求数据

#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.filteredArray.count > 0 ?self.filteredArray.count : self.dataArray.count;
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    if (self.filteredArray.count>0) {
        cell.textLabel.text = self.filteredArray[indexPath.row];
    }else{
        cell.textLabel.text = self.dataArray[indexPath.row];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.filteredArray removeAllObjects];
    [self.mytableView reloadData];
//    self.mytableView.tableHeaderView.backgroundColor  = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];

}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
//    self.mytableView.tableHeaderView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
//    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:36/255.0 green:52/255.0 blue:81/255.0 alpha:1]] forBarMetrics:UIBarMetricsDefault];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.filteredArray removeAllObjects];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchController resignFirstResponder];
    
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString * searchString = searchController.searchBar.text;
    if (![searchString isEqualToString:@""]) {
        NSString * resultString = [NSString stringWithFormat:@"宇通%@员工",searchString];
        NSPredicate * predicate = [NSPredicate  predicateWithFormat:@"SELF CONTAINS %@",resultString];
        self.filteredArray = [[self.dataArray filteredArrayUsingPredicate:predicate] mutableCopy];
    }
    [self.searchController resultTableViewReloadData];
    [self.mytableView reloadData];
}

#pragma mark - YTSearchTableViewDelegate

- (NSInteger)ytSearch_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.filteredArray.count;
}

- (UITableViewCell *)ytSearch_tableView_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    if (self.filteredArray.count>0) {
        cell.textLabel.text = self.filteredArray[indexPath.row];
    }else{
        cell.textLabel.text = self.dataArray[indexPath.row];
    }
    return cell;
}

- (CGFloat)ytSearch_tableView_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


#pragma mark - Private
- (UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect = CGRectMake(0.0f,0.0f,100.0f,28.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *myImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}
#pragma mark - Event


#pragma mark - Get
- (UITableView *)mytableView{
    if (!_mytableView) {
        _mytableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _mytableView.delegate = self;
        _mytableView.dataSource = self;
    }
    return _mytableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i = 0; i < 100; i++) {
            [_dataArray addObject:[NSString stringWithFormat:@"宇通%d员工",arc4random() % 100]];
//            [_dataArray addObject:[NSString stringWithFormat:@"宇通%d员工",i]];
        }
        
        for (int i = 0 ; i < 20; i++) {
            [_dataArray addObject:@"宇通22员工"];
        }
    }
    return _dataArray;
}
- (NSMutableArray *)filteredArray{
    if (!_dataArray) {
        _filteredArray = [NSMutableArray array];
    }
    return _filteredArray;
}

- (YTSearchController *)searchController{
    if (!_searchController) {
        _searchController = [[YTSearchController alloc] initWithSearchView];
        _searchController.searchBar.delegate = self;
        _searchController.searchResultsUpdater = self;
        YTResultViewController * resultVc = (YTResultViewController *)_searchController.searchResultsController;
        resultVc.searchResultDelegate = self;
        self.definesPresentationContext = YES;
    }
    return _searchController;
}
@end
