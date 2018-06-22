//
//  WLWebApi.h
//  WalmartLabDemo
//
//  Created by daiyu zhang on 6/21/18.
//  Copyright © 2018 daiyu zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WebApiState){
    FAILED = 0,
    SUCCEEDED,
};

typedef void(^WebApiCompletion)(NSDictionary* dic, WebApiState state, NSError *error);

@interface WLWebApi : NSObject

+ (void) getProductsWithPageNumber:(NSUInteger) pageNumber completion:(WebApiCompletion) completion;

@end
