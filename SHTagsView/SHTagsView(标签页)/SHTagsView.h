//
//  SHTagsView.h
//  SHTagsView
//
//  Created by CSH on 2017/7/20.
//  Copyright © 2017年 CSH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHTagsView;

typedef void (^SHTagsViewDidSelectButtonBlock)(SHTagsView *tagsView, NSString *obj);

@interface SHTagsView : UIView

+ (SHTagsView *)showSHTagsViewWithFrame:(CGRect)frame DataSoure:(NSArray *)dataSoure Block:(SHTagsViewDidSelectButtonBlock)block;

@end
