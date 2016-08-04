//
//  ViewController.m
//  MRWaterflow
//
//  Created by Andrew554 on 16/8/4.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "ViewController.h"
#import "MRWaterflowLayout.h"
#import "MRShop.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "MRShopCell.h"

@interface ViewController () <UICollectionViewDataSource, MRWaterflowLayoutDelegate>
/** 所有的商品数据 */
@property (nonatomic, strong) NSMutableArray *shops;

@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation ViewController

- (NSMutableArray *)shops
{
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

static NSString * const MRShopId = @"shop";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLayout];
    
    [self setupRefresh];
}

- (void)setupRefresh
{
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    [self.collectionView.header beginRefreshing];
    
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    self.collectionView.footer.hidden = YES;
}

- (void)loadNewShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shops = [MRShop objectArrayWithFilename:@"shops.plist"];
        [self.shops removeAllObjects];
        [self.shops addObjectsFromArray:shops];
        
        // 刷新数据
        [self.collectionView reloadData];
        
        [self.collectionView.header endRefreshing];
    });
}

- (void)loadMoreShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shops = [MRShop objectArrayWithFilename:@"shops.plist"];
        [self.shops addObjectsFromArray:shops];
        
        // 刷新数据
        [self.collectionView reloadData];
        
        [self.collectionView.footer endRefreshing];
    });
}

- (void)setupLayout
{
    // 创建布局
    MRWaterflowLayout *layout = [[MRWaterflowLayout alloc] init];
    layout.delegate = self;
    
    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MRShopCell class]) bundle:nil] forCellWithReuseIdentifier:MRShopId];
    
    self.collectionView = collectionView;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    self.collectionView.footer.hidden = self.shops.count == 0;
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MRShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MRShopId forIndexPath:indexPath];
    
    cell.shop = self.shops[indexPath.item];
    
    return cell;
}

#pragma mark - <MRWaterflowLayoutDelegate>
- (CGFloat)waterflowLayout:(MRWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
    MRShop *shop = self.shops[index];
    
    return itemWidth * shop.h / shop.w;
}

- (CGFloat)rowMarginInWaterflowLayout:(MRWaterflowLayout *)waterflowLayout
{
    return 10;
}

- (CGFloat)columnCountInWaterflowLayout:(MRWaterflowLayout *)waterflowLayout
{
//    if (self.shops.count <= 50) return 2;
    return 3;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(MRWaterflowLayout *)waterflowLayout
{
    return UIEdgeInsetsMake(10, 20, 30, 20);
}

@end
