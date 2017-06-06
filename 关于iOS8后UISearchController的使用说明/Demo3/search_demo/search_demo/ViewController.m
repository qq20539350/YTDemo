//
//  ViewController.m
//  search_demo
//
//  Created by YT_lwf on 2017/5/31.
//  Copyright © 2017年 YT_lwf. All rights reserved.
//


#import "ViewController.h"

@interface YTresultViewController ()<UITableViewDelegate,UITableViewDataSource>
/**
 * tableview
 */
@property(nonatomic,strong) UITableView            *resultTableView;
/**
 * 展示数据
 */
@property(nonatomic,strong) NSMutableArray        *dataArray;
/**
 * 空数据
 */
@property(nonatomic,strong) UIView               *emptyView;
/**
 * tipLable
 */
@property(nonatomic,strong) UIView               *emptyLable;
/**
 *  tipImg
 */
@property(nonatomic,strong) UIView               *emptyImg;
@end

@implementation YTresultViewController
- (void)viewDidLoad{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
;
    self.resultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.resultTableView];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

#pragma mark - Get
- (UITableView *)resultTableView{
    if (!_resultTableView) {
        _resultTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _resultTableView.delegate = self;
        _resultTableView.dataSource = self;
        
       _resultTableView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 44);
    }
    return _resultTableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i = 0; i < 100; i++) {
            //            [_dataArray addObject:[NSString stringWithFormat:@"宇通%d员工",arc4random() % 100]];
            [_dataArray addObject:[NSString stringWithFormat:@"宇通%d员工",i]];
        }
    }
    return _dataArray;
}

@end



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchResultsUpdating>

/**
 * 搜索
 */
@property(nonatomic,strong) UISearchController      *searchVc;
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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.mytableView];
    self.mytableView.tableHeaderView = self.searchVc.searchBar;
    self.mytableView.tableHeaderView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
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
    self.mytableView.tableHeaderView.backgroundColor  = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];

}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    self.mytableView.tableHeaderView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:36/255.0 green:52/255.0 blue:81/255.0 alpha:1]] forBarMetrics:UIBarMetricsDefault];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.filteredArray removeAllObjects];
    [self.resultVc.dataArray removeAllObjects];
    [self.resultVc.resultTableView reloadData];
    [self.mytableView reloadData];
   
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.mytableView reloadData];
    [self.searchVc.searchBar resignFirstResponder];
    
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString * searchString = searchController.searchBar.text;
    if (![searchString isEqualToString:@""]) {
        NSString * resultString = [NSString stringWithFormat:@"宇通%@员工",searchString];
        NSPredicate * predicate = [NSPredicate  predicateWithFormat:@"SELF CONTAINS %@",resultString];
        self.filteredArray = [[self.dataArray filteredArrayUsingPredicate:predicate] mutableCopy];
        self.resultVc.dataArray = [[self.dataArray filteredArrayUsingPredicate:predicate] mutableCopy];
    }
    [self.mytableView reloadData];
    [self.resultVc.resultTableView reloadData];
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

- (UISearchController *)searchVc{
    if (!_searchVc) {
        _resultVc = [[YTresultViewController alloc] init];
//        [_resultVc.view addSubview:self.mytableView];
        
        _searchVc = [[UISearchController alloc] initWithSearchResultsController:_resultVc];
        
        
        _searchVc.searchResultsUpdater = self;
        _searchVc.searchBar.placeholder = @"搜索";
        _searchVc.searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchVc.dimsBackgroundDuringPresentation = YES;
        _searchVc.searchBar.delegate = self;
//        [_searchVc.searchBar setSearchFieldBackgroundImage:[self createImageWithColor:[UIColor grayColor]] forState:UIControlStateNormal];
        [_searchVc.searchBar setSearchFieldBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
//        _searchVc.hidesNavigationBarDuringPresentation = NO;
        [_searchVc.searchBar setValue:@"取消" forKeyPath:@"_cancelButtonText"];
        UIButton * cancel = [_searchVc.searchBar valueForKey:@"_cancelButton"];
        [_searchVc.searchBar sizeToFit];
        self.mytableView.tableHeaderView = _searchVc.searchBar;
        self.searchBartextFile =  [_searchVc.searchBar valueForKey:@"_searchField"];
        self.searchBartextFile.layer.cornerRadius = 4.0f;
//        self.searchBartextFile.leftView= nil;
        self.searchBartextFile.layer.masksToBounds = YES;
        _searchVc.searchBar.tintColor = [UIColor whiteColor];
        
    }
    return _searchVc;
}
@end
