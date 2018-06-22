//
//  WLProductModel.h
//  WalmartLabDemo
//
//  Created by daiyu zhang on 6/21/18.
//  Copyright © 2018 daiyu zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLProductModel : NSObject

@property (nonatomic, strong, readonly) NSString *productId;
@property (nonatomic, strong, readonly) NSString *productName;
@property (nonatomic, strong, readonly) NSString *shortDescription;
@property (nonatomic, strong, readonly) NSString *longDescription;
@property (nonatomic, strong, readonly) NSString *price;
@property (nonatomic, strong, readonly) NSString *productImage;
@property (nonatomic, strong, readonly) NSNumber *reviewRating;
@property (nonatomic, strong, readonly) NSNumber *reviewCount;
@property (nonatomic, assign, readonly) BOOL inStock;

- (id)initWithProductId:(NSString *) productId
            productName:(NSString *) productName
       shortDescription:(NSString *) shortDescription
        longDescription:(NSString *) longDescription
                  price:(NSString *) price
           productImage:(NSString *) productImage
           reviewRating:(NSNumber *) reviewRating
            reviewCount:(NSNumber *) reviewCount
                inStock:(BOOL) inStock;

@end
