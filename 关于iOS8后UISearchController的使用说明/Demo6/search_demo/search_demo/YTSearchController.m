//
//  YTSearchController.m
//  eyutong
//
//  Created by YT_lwf on 2017/6/1.
//  Copyright © 2017年 Zhengzhou Yutong Bus Co.,Ltd. All rights reserved.
//

#import "YTSearchController.h"

@interface YTResultViewController ()<UITableViewDelegate,UITableViewDataSource>

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

@implementation YTResultViewController

- (void)viewDidLoad{
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.view.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.resultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.resultTableView];
}

#pragma mark - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.searchResultDelegate ytSearch_tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.searchResultDelegate ytSearch_tableView_tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.searchResultDelegate ytSearch_tableView_tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.searchResultDelegate ytSearch_tableView_tableView:tableView didSelectRowAtIndexPath:indexPath];
}

#pragma mark - Get/Set
- (UITableView *)resultTableView{
    if (!_resultTableView) {
        _resultTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _resultTableView.delegate = self;
        _resultTableView.dataSource = self;
        _resultTableView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
        _resultTableView.showsVerticalScrollIndicator = NO;
        _resultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _resultTableView.separatorColor = TimeLB_Color;
    }
    return _resultTableView;
}

@end

@interface YTSearchController ()

/**
 * searchbar-textfile
 */
@property(nonatomic,strong) UITextField               *searchBartextFile;
@property(nonatomic,strong) YTResultViewController               *resultVc;
@end

@implementation YTSearchController
-(instancetype)initWithSearchView{
    if (self = [super init]) {
        self.resultVc = [[YTResultViewController alloc] init];
        NSLog(@"---出入前-%@",self.resultVc);
        self = [[YTSearchController alloc] initWithSearchResultsController:self.resultVc];
        NSLog(@"---出入后-%@",self.resultVc);
        self.searchBar.placeholder = @"搜索";
        self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
        self.dimsBackgroundDuringPresentation = YES;
//        self.hidesNavigationBarDuringPresentation = NO;
        [self.searchBar setSearchFieldBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [self.searchBar setValue:@"取消" forKeyPath:@"_cancelButtonText"];
        self.searchBartextFile =  [self.searchBar valueForKey:@"_searchField"];
        UIImageView * leftImg = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"search_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        leftImg.frame = CGRectMake(0, 0, 14, 14);
        UIView *leftView = [[UIView alloc] initWithFrame:leftImg.frame];
        [leftView addSubview:leftImg];
        self.searchBartextFile.leftView = leftView;
        self.searchBartextFile.layer.cornerRadius = 4.0f;
        self.searchBartextFile.layer.masksToBounds = YES;
        
        self.searchBar.tintColor = [UIColor whiteColor];
        self.searchBar.backgroundColor = [UIColor greenColor];
        self.searchBartextFile.borderStyle = UITextBorderStyleNone;
        [self.searchBar sizeToFit];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
//        [UIView animateWithDuration:0.4 animations:^{
//           statusBar.backgroundColor = self.searchBar.backgroundColor;
//        }];
//    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
//        statusBar.backgroundColor = nil;
//    }
}

#pragma mark - Private

- (UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect = CGRectMake(0.0f,0.0f,100.0f,30.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *myImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}

- (void)resultTableViewReloadData{
    YTResultViewController * resultVc = (YTResultViewController *)self.searchResultsController;
    [resultVc.resultTableView reloadData];
}

@end












