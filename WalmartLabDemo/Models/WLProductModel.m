//
//  WLProductModel.m
//  WalmartLabDemo
//
//  Created by daiyu zhang on 6/21/18.
//  Copyright © 2018 daiyu zhang. All rights reserved.
//

#import "WLProductModel.h"

@implementation WLProductModel

- (id)initWithProductId:(NSString *) productId
            productName:(NSString *) productName
       shortDescription:(NSString *) shortDescription
        longDescription:(NSString *) longDescription
                  price:(NSString *) price
           productImage:(NSString *) productImage
           reviewRating:(NSNumber *) reviewRating
            reviewCount:(NSNumber *) reviewCount
                inStock:(BOOL) inStock {
    if (self = [super init]) {
        _productId = productId;
        _productName = productName;
        _shortDescription = shortDescription;
        _longDescription = longDescription;
        _price = price;
        _productImage = productImage;
        _reviewCount = reviewCount;
        _reviewRating = reviewRating;
        _inStock = inStock;
    }
    return self;
}
@end
