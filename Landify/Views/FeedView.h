//
//  FeedView.h
//  Landify
//
//  Created by Ranjith on 25/04/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedCell.h"

@interface FeedView : UIView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *feedTable;
@property (nonatomic, strong) NSArray *feedDataArray;

- (void)reloadFeedTable;

@end
