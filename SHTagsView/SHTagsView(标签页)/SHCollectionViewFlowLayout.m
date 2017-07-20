//
//  SHCollectionViewFlowLayout.m
//  SHTagsView
//
//  Created by CSH on 2017/7/20.
//  Copyright © 2017年 CSH. All rights reserved.
//

#import "SHCollectionViewFlowLayout.h"

@interface SHCollectionViewFlowLayout ()

//cell对齐方式
@property (nonatomic,assign) SHCollectionViewFlowLayoutType type;
//在居中对齐的时候需要知道这行所有cell的宽度总和
@property (nonatomic,assign) CGFloat widthSum;

@end

@implementation SHCollectionViewFlowLayout

- (instancetype)initWithHorizontal:(CGFloat)horizontal Vertical:(CGFloat)vertical EdgeInset:(UIEdgeInsets)edgeInset Type:(SHCollectionViewFlowLayoutType)type{
    
    if (self){
        
        //设置水平间距（内部）
        self.minimumInteritemSpacing = horizontal;
        //设置竖直间距（内部）
        self.minimumLineSpacing = vertical;
        //上左下右
        self.sectionInset = edgeInset;
        //类型
        _type = type;
    }
    return self;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray * layoutAttributes_t = [super layoutAttributesForElementsInRect:rect];
    NSArray * layoutAttributes = [[NSArray alloc]initWithArray:layoutAttributes_t copyItems:YES];
    //用来临时存放一行的Cell数组
    NSMutableArray * layoutAttributesTemp = [[NSMutableArray alloc]init];
    for (NSUInteger index = 0; index < layoutAttributes.count ; index++) {
        
        UICollectionViewLayoutAttributes *currentAttr = layoutAttributes[index]; // 当前cell的位置信息
        UICollectionViewLayoutAttributes *previousAttr = index == 0 ? nil : layoutAttributes[index-1]; // 上一个cell 的位置信
        UICollectionViewLayoutAttributes *nextAttr = index + 1 == layoutAttributes.count ?
        nil : layoutAttributes[index+1];//下一个cell 位置信息
        
        //加入临时数组
        [layoutAttributesTemp addObject:currentAttr];
        self.widthSum += currentAttr.frame.size.width;
        
        CGFloat previousY = previousAttr == nil ? 0 : CGRectGetMaxY(previousAttr.frame);
        CGFloat currentY = CGRectGetMaxY(currentAttr.frame);
        CGFloat nextY = nextAttr == nil ? 0 : CGRectGetMaxY(nextAttr.frame);
        //如果当前cell是单独一行
        if (currentY != previousY && currentY != nextY){
            if ([currentAttr.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
                [layoutAttributesTemp removeAllObjects];
                self.widthSum  = 0.0;
            }else if ([currentAttr.representedElementKind isEqualToString:UICollectionElementKindSectionFooter]){
                [layoutAttributesTemp removeAllObjects];
                self.widthSum  = 0.0;
            }else{
                [self setCellFrameWith:layoutAttributesTemp];
            }
        }
        //如果下一个cell在本行，这开始调整Frame位置
        else if( currentY != nextY) {
            [self setCellFrameWith:layoutAttributesTemp];
        }
    }
    return layoutAttributes;
}

-(void)setCellFrameWith:(NSMutableArray*)layoutAttributes{
    
    CGFloat width = 0.0;
    switch (self.type) {
        case SHCollectionViewFlowLayoutType_Left:
        {
            width = self.sectionInset.left;
            for (UICollectionViewLayoutAttributes * attributes in layoutAttributes) {
                CGRect frame = attributes.frame;
                frame.origin.x = width;
                attributes.frame = frame;
                width += frame.size.width + self.minimumInteritemSpacing;
            }
        }
            break;
        case SHCollectionViewFlowLayoutType_Center:
        {
            width = (self.collectionView.frame.size.width - self.widthSum  - (layoutAttributes.count * self.minimumInteritemSpacing)) / 2;
            for (UICollectionViewLayoutAttributes * attributes in layoutAttributes) {
                CGRect frame = attributes.frame;
                frame.origin.x = width;
                attributes.frame = frame;
                width += frame.size.width + self.minimumInteritemSpacing;
            }
        }
            break;
            
        case SHCollectionViewFlowLayoutType_Right:
        {
            width = self.collectionView.frame.size.width - self.sectionInset.right;
            for (NSInteger index = layoutAttributes.count - 1 ; index >= 0 ; index-- ) {
                UICollectionViewLayoutAttributes * attributes = layoutAttributes[index];
                CGRect frame = attributes.frame;
                frame.origin.x = width - frame.size.width;
                attributes.frame = frame;
                width = width - frame.size.width - self.minimumInteritemSpacing;
            }
        }
            break;
        default:
            break;
    }
    
    self.widthSum  = 0.0;
    [layoutAttributes removeAllObjects];
}

@end
