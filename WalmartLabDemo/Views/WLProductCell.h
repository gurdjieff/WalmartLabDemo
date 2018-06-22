//
//  WLProductCell.h
//  WalmartLabDemo
//
//  Created by daiyu zhang on 6/21/18.
//  Copyright © 2018 daiyu zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLProductModel.h"

@interface WLProductCell : UICollectionViewCell

- (void)configCellWithModel:(WLProductModel *)model;

@end
