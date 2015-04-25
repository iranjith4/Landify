//
//  FeedView.m
//  Landify
//
//  Created by Ranjith on 25/04/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import "FeedView.h"
#import <Parse/Parse.h>

@implementation FeedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageDownloadingQueue = [[NSOperationQueue alloc] init];
        self.imageDownloadingQueue.maxConcurrentOperationCount = 3;
        self.imageCache = [[NSCache alloc] init];

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
    PFObject *obj = [self.feedDataArray objectAtIndex:indexPath.row];
    PFGeoPoint *geo = obj[@"geo_point"];
    feed.location.text = [NSString stringWithFormat:@"%f, %f",geo.latitude,geo.longitude];
    feed.userName.text = obj[@"user_name"];
    feed.userText.text = obj[@"user_text"];
    feed.tagNames.text = obj[@"tags"];
    if ([obj[@"verify_points"] intValue] > 100) {
        feed.verifiedSign.image = [UIImage imageNamed:@"ok2"];
    }
    UIImage *cachedImage = [self.imageCache objectForKey:obj[@"image_url"]];
    if (cachedImage)
    {
        feed.mainImage.image = cachedImage;
    } else {
        [self.imageDownloadingQueue addOperationWithBlock:^{
            NSURL *imageUrl   = [NSURL URLWithString:obj[@"image_url"]];
            NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
            UIImage *userImg = nil;
            if (imageData) {
                userImg = [UIImage imageWithData:imageData];
                // add the image to your cache
                [self.imageCache setObject:userImg forKey:obj[@"image_url"]];
                // finally, update the user interface in the main queue
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    // make sure the cell is still visible
                    FeedCell *tempCell = (FeedCell *)[self.feedTable cellForRowAtIndexPath:indexPath];
                    if (tempCell) {
                        tempCell.mainImage.image = userImg;
                    }
                }];
            }
        }];
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.feedDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.frame.size.height / 2;
}

- (void) reloadFeedTable{
    [self.feedTable reloadData];
}



@end
