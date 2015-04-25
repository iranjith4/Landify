//
//  FeedView.m
//  Landify
//
//  Created by Ranjith on 25/04/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import "FeedView.h"

@implementation FeedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void) initUI{
    self.backgroundColor = [UIColor whiteColor];
    [self loadFeedTable];
}

- (void) loadFeedTable {
    self.feedTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.frame.size.width, self.frame.size.height - 100)];
    self.feedTable.delegate = self;
    self.feedTable.dataSource = self;
    [self addSubview:self.feedTable];
}

#pragma mark - Table Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    FeedCell *feed;
    if (!feed) {
        feed = [[FeedCell alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height / 2)];
    }
    [feed initUIForSize:CGSizeMake(self.frame.size.width - 20, self.frame.size.height / 2)];
    cell = (FeedCell *)feed;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.frame.size.height / 2;
}

- (void) reloadFeedTable{
    [self.feedTable reloadData];
}



@end
