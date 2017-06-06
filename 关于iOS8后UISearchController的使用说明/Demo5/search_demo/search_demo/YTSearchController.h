//
//  YTSearchController.h
//  eyutong
//
//  Created by YT_lwf on 2017/6/1.
//  Copyright © 2017年 Zhengzhou Yutong Bus Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YTSearchTableViewDelegate <NSObject>

@required
- (NSInteger)ytSearch_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)ytSearch_tableView_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)ytSearch_tableView_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (void)ytSearch_tableView_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
/**
 * 辅助使用
 */
@interface YTResultViewController : UIViewController

/**
 * 搜索结果展示页面的代理
 */
@property(nonatomic,assign) id<YTSearchTableViewDelegate>     searchResultDelegate;

/**
 * tableview
 */
@property(nonatomic,strong) UITableView                      *resultTableView;

@end


/**
 * 自定义的搜索页面
 */
@interface YTSearchController : UISearchController

/**
 * 初始化方法
 */
-(instancetype)initWithSearchView;

- (void)resultTableViewReloadData;
@end
