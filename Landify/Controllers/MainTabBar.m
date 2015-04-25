//
//  MainTabBar.m
//  Landify
//
//  Created by Ranjith on 25/04/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import "MainTabBar.h"

@interface MainTabBar ()

@end

@implementation MainTabBar

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeFeed* home = [[HomeFeed alloc] initWithNibName:nil bundle:nil];
    // discVC.title = @"Discover";
    //    home.tabBarItem.image = [UIImage imageNamed:@"tab_discover_act_.png"];
    UINavigationController* homeNav = [[UINavigationController alloc] initWithRootViewController:home];
    homeNav.title = @"Home";

    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self setViewControllers:[NSArray arrayWithObjects:homeNav,nil]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
