//
//  PostPlaceViewController.h
//  Landify
//
//  Created by Ranjith on 25/04/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGCameraViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface PostPlaceViewController : UIViewController<TGCameraDelegate,CLLocationManagerDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *locationLabel;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *lastLocation;

@end
