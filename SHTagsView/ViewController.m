//
//  ViewController.m
//  SHTagsView
//
//  Created by CSH on 2017/7/20.
//  Copyright © 2017年 CSH. All rights reserved.
//

#import "ViewController.h"
#import "SHTagsView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //设置数据源
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    for (int i = 0; i < 20; i++) {
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        
        for (int i = 0; i < 15; i++) {
            [arr addObject:[NSString stringWithFormat:@"随机数：%d",
                            arc4random()%100]];
        }
        [temp addObject:arr];
    }
    
    SHTagsView *view = [SHTagsView showSHTagsViewWithFrame:CGRectMake(15, 20, self.view.frame.size.width - 30, self.view.frame.size.height - 40) DataSoure:temp Block:^(SHTagsView *tagsView, NSString *obj) {
        
            NSLog(@"点击了===%@",obj);
    }];
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
