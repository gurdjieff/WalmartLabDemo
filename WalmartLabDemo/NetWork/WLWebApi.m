//
//  WLWebApi.m
//  WalmartLabDemo
//
//  Created by daiyu zhang on 6/21/18.
//  Copyright © 2018 daiyu zhang. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#import "WLProductModel.h"
#import "WLWebApi.h"
#import "General.h"

static NSString *productsList = @"walmartproducts";
static NSString *pageSize = @"20";

@implementation WLWebApi

+ (void) getProductsWithPageNumber:(NSUInteger) pageNumber completion:(WebApiCompletion) completion {
    NSURL *URL = [NSURL URLWithString:[General baseUrl]];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:URL];
    NSString *path = [NSString stringWithFormat:@"%@/%lu/%@", productsList, pageNumber, pageSize];
    [manager GET: path parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]
            && responseObject[@"statusCode"]
            && [responseObject[@"statusCode"] integerValue] == 200
            && responseObject[@"pageNumber"]
            && responseObject[@"pageSize"]
            && responseObject[@"products"]
            && responseObject[@"totalProducts"]) {
            NSLog(@"%@", responseObject);
            NSMutableArray<WLProductModel *> * products = [NSMutableArray array];
            for (NSDictionary *dic in responseObject[@"products"]) {
                WLProductModel *model = [[WLProductModel alloc] initWithProductId:dic[@"productId"]
                                              productName:dic[@"productName"]
                                         shortDescription:dic[@"shortDescription"]
                                          longDescription:dic[@"longDescription"]
                                                    price:dic[@"price"]
                                             productImage:dic[@"productImage"]
                                             reviewRating:dic[@"reviewRating"]
                                              reviewCount:dic[@"reviewCount"]
                                                  inStock:[dic[@"reviewRating"] boolValue]];
                [products addObject:model];
            }
            
            NSMutableDictionary *resultDictionary = [NSMutableDictionary dictionary];
            resultDictionary[@"products"] = products;
            resultDictionary[@"pageNumber"] = responseObject[@"pageNumber"];
            resultDictionary[@"pageSize"] = responseObject[@"pageSize"];
            resultDictionary[@"totalProducts"] = responseObject[@"totalProducts"];
            completion(resultDictionary, SUCCEEDED, nil);
        } else {
            completion(nil, FAILED, nil);
            NSLog(@"Error: %@", @"Data is not correct");
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        completion(nil, FAILED, error);
        NSLog(@"Error: %@", error);
    }];
}

@end
