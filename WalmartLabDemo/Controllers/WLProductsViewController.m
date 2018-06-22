//
//  WLProductsViewController.m
//  WalmartLabDemo
//
//  Created by daiyu zhang on 6/21/18.
//  Copyright © 2018 daiyu zhang. All rights reserved.
//
#import "WLProductsViewController.h"
#import "WLWebApi.h"
#import "General.h"
#import "WLProductCell.h"
#import "MJRefresh.h"
#import "WLProductDetailViewController.h"

static NSString * const reuseIdentifier = @"WLProductCell";
static CGFloat cellHeight = 100.0;

@interface WLProductsViewController ()
{
    NSMutableArray *_productsList;
    NSInteger _pageNumber;
    NSInteger _totalProducts;
}
@end

@implementation WLProductsViewController

#pragma mark --NetWork

- (void)freshProductList {
    _pageNumber = 1;
    [WLWebApi getProductsWithPageNumber:_pageNumber completion:^(NSDictionary *result, WebApiState state, NSError *error) {
        [self.collectionView.mj_header endRefreshing];
        if (state == SUCCEEDED) {
            self->_pageNumber = [result[@"pageNumber"] integerValue];
            self->_totalProducts = [result[@"totalProducts"] integerValue];
            [self->_productsList setArray:result[@"products"]];
            [self.collectionView reloadData];
        }
    }];
}

- (void)loadProductList {
    _pageNumber += 1;
    [WLWebApi getProductsWithPageNumber:_pageNumber completion:^(NSDictionary *result, WebApiState state, NSError *error) {
        if (state == SUCCEEDED) {
            NSArray *tempArray = result[@"products"];
            if (tempArray.count > 0) {
                self->_pageNumber = [result[@"pageNumber"] integerValue];
                self->_totalProducts = [result[@"totalProducts"] integerValue];
                [self->_productsList addObjectsFromArray:tempArray];
                [self.collectionView reloadData];
            }
        }
        if (self->_productsList.count < self->_totalProducts) {
            [self.collectionView.mj_footer endRefreshing];
        } else {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
}

#pragma mark --init views

-(void)addFreshView {
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self freshProductList];
    }];
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadProductList];
    }];
    self.collectionView.mj_footer.automaticallyChangeAlpha = YES;
}

-(void)registCell {
    [self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)initData {
    _productsList = [NSMutableArray array];
    _pageNumber = 1;
    self.navigationItem.title = @"Product List";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self registCell];
    [self addFreshView];
    [self loadProductList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([General screenWidth], cellHeight);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _productsList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WLProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell configCellWithModel:_productsList[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WLProductDetailViewController *controller =
                    [[WLProductDetailViewController alloc] initWithProductList:_productsList
                                                                         index:indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
