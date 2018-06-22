//
//  WLProductDetailViewController.m
//  WalmartLabDemo
//
//  Created by daiyu zhang on 6/21/18.
//  Copyright © 2018 daiyu zhang. All rights reserved.
//

#import "WLProductDetailViewController.h"
#import "General.h"
#import "WlProductDetailView.h"
#import "Masonry.h"

@interface WLProductDetailViewController ()
{
    __weak IBOutlet UIView *_backGroundView;
    __weak IBOutlet UIScrollView *_scrollView;
    __weak IBOutlet NSLayoutConstraint *_scrollViewWidth;
    NSArray *_productsList;
    NSUInteger _pageIndex;
    NSMutableSet<NSNumber *> *_populatedPageIndexs;
}
@end

@implementation WLProductDetailViewController

- (id)initWithProductList:(NSArray *) productList
                    index:(NSUInteger) index {
    if (self = [super init]) {
        _productsList = productList;
        _pageIndex = index;
    }
    return self;
}

- (void)initData {
    _populatedPageIndexs = [NSMutableSet set];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Product";
    [self initData];
    [self configScrollView];
}

#pragma mark -config views

- (void)configScrollView {
    self.navigationItem.title = @"Product";
    _scrollViewWidth.constant = [General screenWidth] * _productsList.count;
    [self updateProductDetailView];
    [_scrollView layoutIfNeeded];
    [_scrollView setContentOffset:CGPointMake(_pageIndex * [General screenWidth], 0) animated:NO];
}

- (void)updateProductDetailView {
    [self configViewWithIndex:_pageIndex - 1];
    [self configViewWithIndex:_pageIndex];
    [self configViewWithIndex:_pageIndex + 1];
}

- (void)configViewWithIndex:(NSInteger) index {
    if (![_populatedPageIndexs containsObject:[NSNumber numberWithInteger:index]]
        && index >= 0
        && index < _productsList.count ) {
        [_populatedPageIndexs addObject:[NSNumber numberWithInteger:index]];
        WlProductDetailView *detailView = [[[NSBundle mainBundle] loadNibNamed:@"WlProductDetailView"
                                                                         owner:self
                                                                       options:nil]
                                           objectAtIndex:0];
    
        [_backGroundView addSubview:detailView];
        [detailView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self->_backGroundView);
            make.left.mas_equalTo([General screenWidth] * index);
            make.width.mas_equalTo([General screenWidth]);
        }];
        [detailView configViewWithModel:_productsList[index]];
    }
}

#pragma mark --scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x / [General screenWidth];
    if (index != _pageIndex) {
        _pageIndex = index;
        [self updateProductDetailView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
