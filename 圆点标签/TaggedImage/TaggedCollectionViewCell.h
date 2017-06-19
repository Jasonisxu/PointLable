//
//  TaggedCollectionViewCell.h
//  圆点标签
//
//  Created by Wicrenet_Jason on 2017/6/16.
//  Copyright © 2017年 Wicrenet_Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagModel.h"
#import "TagViewModel.h"
#import "MarkedImageView.h"
#import "TagBuilderView.h"
#import "TagView.h"

@interface TaggedCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImage *imagePhoto;

@property (nonatomic, strong) TagView *tagView;
@property (nonatomic, strong) MarkedImageView *markedImageView;
@property (nonatomic, strong) TagBuilderView *tagBuilderView;
@property (nonatomic, strong) NSMutableArray<TagViewModel *> *viewModels;
@property (nonatomic, assign) NSInteger deleteIndex;
- (void)cellAddTaggedViewAction:(UIImage *)image;
@end
