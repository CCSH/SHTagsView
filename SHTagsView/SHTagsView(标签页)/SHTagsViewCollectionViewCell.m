//
//  SHTagsViewCollectionViewCell.m
//  SHTagsView
//
//  Created by CSH on 2017/7/20.
//  Copyright © 2017年 CSH. All rights reserved.
//

#import "SHTagsViewCollectionViewCell.h"

@implementation SHTagsViewCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.tagLabel.layer.cornerRadius = 5;
    self.tagLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tagLabel.layer.borderWidth = 1;
}

@end
