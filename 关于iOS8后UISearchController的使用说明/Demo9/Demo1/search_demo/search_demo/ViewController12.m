//
//  ViewController12.m
//  search_demo
//
//  Created by YT_lwf on 2017/6/1.
//  Copyright © 2017年 YT_lwf. All rights reserved.
//

#import "ViewController12.h"

@interface ViewController12 ()

@end

@implementation ViewController12
@synthesize testArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSMutableArray *)testArray{
    if (!testArray) {
        testArray = [NSMutableArray array];
    }
    return testArray;
}

- (void)setTestArray:(NSMutableArray *)newTestArray{
    if (newTestArray != testArray) {
        [testArray removeAllObjects];
        testArray = [newTestArray mutableCopy];
    }
}
@end
