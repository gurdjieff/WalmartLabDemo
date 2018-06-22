//
//  General.m
//  WalmartLabDemo
//
//  Created by daiyu zhang on 6/21/18.
//  Copyright © 2018 daiyu zhang. All rights reserved.
//

#import "General.h"
#import <UIKit/UIKit.h>

@implementation General

+ (double)screenWidth {
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (double)screenHeigth {
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (NSString *)baseUrl {
    return @"https://mobile-tha-server.appspot.com";
}

@end
