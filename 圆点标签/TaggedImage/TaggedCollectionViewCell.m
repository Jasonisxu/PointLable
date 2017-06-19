//
//  TaggedCollectionViewCell.m
//  圆点标签
//
//  Created by Wicrenet_Jason on 2017/6/16.
//  Copyright © 2017年 Wicrenet_Jason. All rights reserved.
//

#import "TaggedCollectionViewCell.h"

@implementation TaggedCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)cellAddTaggedViewAction:(UIImage *)image{
    
    self.imagePhoto = image;
    
    _markedImageView = [[MarkedImageView alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_HEIGHT / 4 * 3 - 100)*self.imagePhoto.size.width/self.imagePhoto.size.height, (SCREEN_HEIGHT / 4 * 3 - 100))];
    _markedImageView.center = self.contentView.center;
    _markedImageView.image = self.imagePhoto;
    self.markedImageView.editable = NO;
    __weak typeof(self) wself = self;
    //点击图片，编辑或新建标签
    _markedImageView.markedImageDidTapBlock = ^(TagViewModel *viewModel){
        [wself showTagBuilderViewWithViewModel:viewModel];
    };
    _markedImageView.deleteTagViewBlock = ^(TagViewModel *viewModel){
        [wself handleDeleteTagViewWithViewModel:viewModel];
    };
    
    [self.contentView addSubview:self.markedImageView];
    NSLog(@"%@",_markedImageView);


    [self setupTestData];
}

#pragma mark - test data
- (void)setupTestData
{
    //test data
    TagModel *model1 = [[TagModel alloc] initWithName:@"Mar" value:@"11"];
    TagModel *model2 = [[TagModel alloc] initWithName:@"清晨" value:@"5:32"];
    TagModel *model3 = [[TagModel alloc] initWithName:@"Tidus" value:@"@锡耶纳"];
    TagViewModel *viewModel = [[TagViewModel alloc] initWithArray:@[model1, model2, model3].mutableCopy coordinate:CGPointMake(0.7, 0.5)];
    
    //test data
    TagModel *model4 = [[TagModel alloc] initWithName:@"悬崖" value:@""];
    TagModel *model5 = [[TagModel alloc] initWithName:@"欧洲" value:@"伊利奥斯"];
    TagViewModel *viewModel1 = [[TagViewModel alloc] initWithArray:@[model4, model5].mutableCopy coordinate:CGPointMake(0.6, 0.75)];
    viewModel1.style = TagViewStyleObliqueLeft;
    
    //data array
    _viewModels = [[NSMutableArray alloc] initWithObjects:viewModel, viewModel1, nil];
    
    [self showMarkedImageView];
}

#pragma mark - getter/setter

//- (MarkedImageView *)markedImageView
//{
//    if(!_markedImageView){
//        _markedImageView = [[MarkedImageView alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_HEIGHT / 4 * 3 - 100)*self.imagePhoto.size.width/self.imagePhoto.size.height, (SCREEN_HEIGHT / 4 * 3 - 100))];
//        _markedImageView.center = self.contentView.center;
//        _markedImageView.image = self.imagePhoto;
//        NSLog(@"%@",self.imagePhoto);
//        self.markedImageView.editable = NO;
//        __weak typeof(self) wself = self;
//        //点击图片，编辑或新建标签
//        _markedImageView.markedImageDidTapBlock = ^(TagViewModel *viewModel){
//            [wself showTagBuilderViewWithViewModel:viewModel];
//        };
//        _markedImageView.deleteTagViewBlock = ^(TagViewModel *viewModel){
//            [wself handleDeleteTagViewWithViewModel:viewModel];
//        };
//    }
//    return _markedImageView;
//}

- (TagBuilderView *)tagBuilderView
{
    if(!_tagBuilderView){
        _tagBuilderView = [TagBuilderView viewFromNib];
        [_tagBuilderView setFrame:CGRectMake(0, 0, 320, 568)];
        _tagBuilderView.alpha = 0;
        _tagBuilderView.backgroundImageView.image = self.markedImageView.blurImage;
        //编辑、新建标签后返回viewModel，更新到现有数组
        __weak typeof(self) wself = self;
        _tagBuilderView.confirmBlock = ^(TagViewModel *viewModel){
            [wself handleNewTagViewModel:viewModel];
        };
    }
    return _tagBuilderView;
}

#pragma mark - private
- (void)showMarkedImageView
{
    [self.markedImageView createTagView:self.viewModels];
    [self.markedImageView showTagViews];
}
- (void)showTagBuilderViewWithViewModel:(TagViewModel *)viewModel
{
    [self.contentView addSubview:self.tagBuilderView];
    [self.tagBuilderView setInfo:viewModel];
    [self.tagBuilderView show];
}

- (void)handleDeleteTagViewWithViewModel:(TagViewModel *)viewModel
{
    self.deleteIndex = viewModel.index;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"删除标签？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.delegate = self;
    [alertView show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0: {
            break;
        }
        case 1: {
            if(self.deleteIndex == -1){
                return;
            }
            [self.viewModels removeObjectAtIndex:self.deleteIndex];
            [self showMarkedImageView];
            self.deleteIndex = -1;
            break;
        }
            
        default:
            break;
    }
}

- (void)handleNewTagViewModel:(TagViewModel *)viewModel
{
    if(viewModel.index == -1){
        viewModel.index = self.viewModels.count;
        [self.viewModels addObject:viewModel];
    }else{
        [self.viewModels replaceObjectAtIndex:viewModel.index withObject:viewModel];
    }
    [self.tagBuilderView hide];
    [self showMarkedImageView];
}
@end
