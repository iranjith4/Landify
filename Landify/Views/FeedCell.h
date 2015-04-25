//
//  FeedCell.h
//  Landify
//
//  Created by Ranjith on 25/04/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagName.h"

@interface FeedCell : UITableViewCell

- (void)initUIForSize:(CGSize)size;

@property (nonatomic, strong) UIImageView *mainImage;
@property (nonatomic, strong) UILabel *location;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UIImageView *verifiedSign;
@property (nonatomic, strong) UILabel *userText;
@property (nonatomic, strong) UILabel *tagNames;
@end
