//
//  TaggedImageViewController.m
//  TidusWWDemo
//
//  Created by Tidus on 17/1/12.
//  Copyright © 2017年 Tidus. All rights reserved.
//

#import "TaggedImageViewController.h"
#import "TaggedCollectionViewCell.h"
#import "NextViewController.h"

@interface TaggedImageViewController ()<UIAlertViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *centerCollectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation TaggedImageViewController
#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"a1"],[UIImage imageNamed:@"a2"],[UIImage imageNamed:@"a3"],[UIImage imageNamed:@"a4"],[UIImage imageNamed:@"a5"],[UIImage imageNamed:@"a6"],nil];

    [self addButtomViewAction];
    [self addcollectionViewAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --增加底部View--
- (void)addButtomViewAction {
    UIView *bttomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT -  SCREEN_HEIGHT/4, SCREEN_WIDTH, SCREEN_HEIGHT/4)];
    bttomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bttomView];
    
    UIButton *nextBt = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBt.backgroundColor = [UIColor grayColor];
    [nextBt setFrame:CGRectMake(0, 0, 100, 200)];
    [bttomView addSubview:nextBt];
    [nextBt addTarget:self action:@selector(nextControllerAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)nextControllerAction:(id)sender {
    [self.navigationController pushViewController:[NextViewController new] animated:YES];
}

#pragma mark 添加collectionView
- (void)addcollectionViewAction {
    /**
     *
     http://www.jianshu.com/p/16c9d466f88c
     *
     http://www.cocoachina.com/bbs/read.php?tid=327440&page=1#1411664
     **/
    
    
    /**
     *http://www.cnblogs.com/leo-92/p/4311379.html
     *iOS UICollectionView 缝隙修复
     */
    
    //    NSLog(@"%f",SCREEN_WIDTH + pointX * 2);
    
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //横向滑动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //2.初始化collectionView
    self.centerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -  SCREEN_HEIGHT/4) collectionViewLayout:layout];
    self.centerCollectionView.backgroundColor = [UIColor blackColor];
    self.centerCollectionView.pagingEnabled = YES;
    [self.view addSubview:self.centerCollectionView];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [self.centerCollectionView registerNib:[UINib nibWithNibName:@"TaggedCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TaggedCollectionViewCell"];
    
    //4.设置代理
    self.centerCollectionView.delegate = self;
    self.centerCollectionView.dataSource = self;
    
}

#pragma mark collectionView代理方法
//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT / 4 * 3 - 100);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(50, 0, 0, 0);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *TaggedID=@"TaggedCollectionViewCell";
    TaggedCollectionViewCell *cell = (TaggedCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:TaggedID forIndexPath:indexPath];
    
    //cell重用的话会导致试图叠加
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    UIImage *image = self.dataArray[indexPath.row];
    [cell cellAddTaggedViewAction:image];
    
    return cell;
}


//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"row:%li",indexPath.row);
}


@end
