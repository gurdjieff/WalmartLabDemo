//
//  WlProductDetailView.m
//  WalmartLabDemo
//
//  Created by daiyu zhang on 6/22/18.
//  Copyright © 2018 daiyu zhang. All rights reserved.
//

#import "WlProductDetailView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "General.h"

@implementation WlProductDetailView {
    
    __weak IBOutlet UILabel *_reviewRateLabel;
    __weak IBOutlet UILabel *_priceLabel;
    __weak IBOutlet UILabel *_longDescriptionLabel;
    __weak IBOutlet UILabel *_shortDescriptionLabel;
    __weak IBOutlet UIImageView *_productImage;
    __weak IBOutlet UILabel *_nameLabel;
}

- (void)configViewWithModel:(WLProductModel *)model {
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [General baseUrl], model.productImage]];
    [_productImage sd_setImageWithURL:imageUrl];
    _nameLabel.text = model.productName;
    _priceLabel.text = model.price;
    _reviewRateLabel.text = [NSString stringWithFormat:@"Rate:%@", model.reviewRating];
    
    _shortDescriptionLabel.attributedText = [[NSAttributedString alloc] initWithData:[model.shortDescription dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [_shortDescriptionLabel setContentCompressionResistancePriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisVertical];
    
    _longDescriptionLabel.attributedText = [[NSAttributedString alloc] initWithData:[model.longDescription dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
     [_longDescriptionLabel setContentCompressionResistancePriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisVertical];
}

@end
