//
//  HomeFeed.m
//  Landify
//
//  Created by Ranjith on 25/04/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import "HomeFeed.h"
#import "FeedView.h"
#import "PostPlaceViewController.h"

@interface HomeFeed ()

@end

@implementation HomeFeed

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setProperties];
    [self loadFeedView];
    [self addPostButton];
       // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addPostButton {
    UIBarButtonItem *post = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(openPostController)];
    [post setTitle:@"Post"];
    self.navigationItem.rightBarButtonItem = post;
}

- (void)setProperties{
    self.title = @"Landify";
}

- (void)openPostController{
    PostPlaceViewController *postPlace = [[PostPlaceViewController alloc] initWithNibName:nil bundle:nil];
    [self presentViewController:postPlace animated:YES completion:nil];
}

- (void)loadFeedView{
    FeedView *feedView = [[FeedView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:feedView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
