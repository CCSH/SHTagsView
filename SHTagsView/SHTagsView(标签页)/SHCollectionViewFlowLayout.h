//
//  SHCollectionViewFlowLayout.h
//  SHTagsView
//
//  Created by CSH on 2017/7/20.
//  Copyright © 2017年 CSH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SHCollectionViewFlowLayoutType_Center,
    SHCollectionViewFlowLayoutType_Left,
    SHCollectionViewFlowLayoutType_Right,
} SHCollectionViewFlowLayoutType;

@interface SHCollectionViewFlowLayout : UICollectionViewFlowLayout

- (instancetype)initWithHorizontal:(CGFloat)horizontal Vertical:(CGFloat)vertical EdgeInset:(UIEdgeInsets)edgeInset Type:(SHCollectionViewFlowLayoutType)type;

@end
