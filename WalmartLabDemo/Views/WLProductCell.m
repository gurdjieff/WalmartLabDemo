//
//  WLProductCell.m
//  WalmartLabDemo
//
//  Created by daiyu zhang on 6/21/18.
//  Copyright © 2018 daiyu zhang. All rights reserved.
//

#import "WLProductCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "General.h"

@implementation WLProductCell {
    __weak IBOutlet UILabel *_productRate;
    __weak IBOutlet UILabel *_productName;
    __weak IBOutlet UIImageView *_productImage;
    __weak IBOutlet UILabel *_productPrice;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)configCellWithModel:(WLProductModel *)model {
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [General baseUrl], model.productImage]];
    [_productImage sd_setImageWithURL:imageUrl];
    _productName.text = model.productName;
    _productPrice.text = model.price;
    _productRate.text = [NSString stringWithFormat:@"Rate:%@", model.reviewRating];
}

@end
