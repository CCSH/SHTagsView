//
//  SHTagsView.m
//  SHTagsView
//
//  Created by CSH on 2017/7/20.
//  Copyright © 2017年 CSH. All rights reserved.
//

#import "SHTagsView.h"
#import "SHTagsViewCollectionViewCell.h"
#import "SHCollectionViewFlowLayout.h"

//视图左右间隔
#define kSHTagsViewMarginLF 15
//上下间隔
#define kSHTagsViewMarginUD 15
//标签间水平边距
#define kSHTagsViewTagHorizontal 10
//标签间垂直边距
#define kSHTagsViewTagVertical 5

//标签高度
#define kSHTagsViewH 22
//标签字体
#define kSHTagsViewTagFont [UIFont systemFontOfSize:16]

@interface SHTagsView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

//视图
@property (nonatomic, strong) UICollectionView *collectionView;
//参数
@property (nonatomic, strong) NSArray *dataSoure;
//size参数
@property (nonatomic, strong) NSMutableArray *frameArr;
//回调
@property (nonatomic, copy) SHTagsViewDidSelectButtonBlock block;

@end

@implementation SHTagsView

static NSString * const reuseIdentifier = @"SHTagsViewCollectionViewCell";

#pragma mark - 初始化
+ (SHTagsView *)showSHTagsViewWithFrame:(CGRect)frame DataSoure:(NSArray *)dataSoure Block:(SHTagsViewDidSelectButtonBlock)block{
    
    SHTagsView *tagsView = [[SHTagsView alloc] initWithWithFrame:frame DataSoure:dataSoure Block:block];
    return tagsView;
}

- (instancetype)initWithWithFrame:(CGRect)frame DataSoure:(NSArray<NSString *> *)dataSoure Block:(SHTagsViewDidSelectButtonBlock)block{
    self = [self init];
    
    if (self)
    {
        //初始化
        self.frame = frame;
        _dataSoure = dataSoure;
        _block = block;
        
        //设置size参数
        _frameArr = [[NSMutableArray alloc]init];
        for (NSArray *obj in dataSoure) {
            
            NSMutableArray *temp = [[NSMutableArray alloc]init];
            for (NSString *str in obj) {
                CGSize size = [str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, kSHTagsViewH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kSHTagsViewTagFont} context:nil].size;
                [temp addObject:[NSValue valueWithCGSize:CGSizeMake(ceil(size.width) + 10, ceil(size.height))]];
            }
            
            //添加到数据源
            [_frameArr addObject:temp];
        }
        
        //设置约束
        SHCollectionViewFlowLayout *layout = [[SHCollectionViewFlowLayout alloc]initWithHorizontal:kSHTagsViewTagHorizontal Vertical:kSHTagsViewTagVertical EdgeInset:UIEdgeInsetsMake(kSHTagsViewMarginUD, kSHTagsViewMarginLF, kSHTagsViewMarginUD, kSHTagsViewMarginLF) Type:SHCollectionViewFlowLayoutType_Center];
        //创建视图
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor orangeColor];
        //注册
        UINib *cellNib = [UINib nibWithNibName:reuseIdentifier bundle:nil];
        [_collectionView registerNib:cellNib forCellWithReuseIdentifier:reuseIdentifier];
        
        [self addSubview:_collectionView];
    }
    
    return self;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.dataSoure.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSoure[section] count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.frameArr[indexPath.section][indexPath.row] CGSizeValue];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(collectionView.frame.size.width, 40);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHTagsViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.tagLabel.text = self.dataSoure[indexPath.section][indexPath.row];
    cell.tagLabel.font = kSHTagsViewTagFont;

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *obj = self.dataSoure[indexPath.section][indexPath.row];
    if (self.block) {
        self.block(self, obj);
    }
}

@end
