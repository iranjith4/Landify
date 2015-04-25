//
//  PostPlaceViewController.m
//  Landify
//
//  Created by Ranjith on 25/04/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import "PostPlaceViewController.h"
#import "Constants.h"
#import <Parse/Parse.h>
#import "ProgressHUD.h"

@interface PostPlaceViewController (){
    UIScrollView *scroll;
    UIButton *camera;
    UITextField *userText;
    UITextField *tags;
    UIButton *postButton;
    UIProgressView *imageProgress;
}

@end

@implementation PostPlaceViewController

- (void)viewDidLoad {
    scroll = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scroll.alwaysBounceVertical = YES;
    scroll.scrollEnabled = YES;
    [self.view addSubview:scroll];
    
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
        if ([CLLocationManager locationServicesEnabled]) {
            [self initLocationManager];
        } else {
            //TODO: Alert User to Enable location in settings
        }

    
    UIButton *close = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 70, 40, 50, 40)];
    [close setTitle:@"Close" forState:UIControlStateNormal];
    [close setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(closeViewController) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:close];
    
    camera = [[UIButton alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 50)];
    [camera setTitle:@"CAMERA" forState:UIControlStateNormal];
    [camera setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [camera addTarget:self action:@selector(openCamera) forControlEvents:UIControlEventTouchUpInside];
    [camera sizeToFit];
    [scroll addSubview:camera];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, camera.frame.origin.y + camera.frame.size.height, self.view.frame.size.width / 3, self.view.frame.size.width / 3)];
    self.imageView.center = CGPointMake(self.view.center.x, self.imageView.center.y);
    [scroll addSubview:self.imageView];
    
    UILabel *location = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imageView.frame.size.height + self.imageView.frame.origin.y + 3, self.view.frame.size.width, 50)];
    location.font = [UIFont fontWithName:FONT_BOLD size:13];
    location.text = [NSString stringWithFormat:@" %.4f, %.4f",[self deviceLocation].latitude,[self deviceLocation].longitude];
    location.textAlignment = NSTextAlignmentCenter;
    [scroll addSubview: location];
    
    userText = [[UITextField alloc] initWithFrame:CGRectMake(10,location.frame.origin.y + location.frame.size.height + 3, self.view.frame.size.width - 20, 30)];
    userText.font = [UIFont fontWithName:FONT_MEDIUM size:12];
    userText.borderStyle = UITextBorderStyleLine;
    userText.delegate = self;
    [scroll addSubview:userText];
    
    tags = [[UITextField alloc] initWithFrame:CGRectMake(10,userText.frame.origin.y + userText.frame.size.height + 3, self.view.frame.size.width - 20, 30)];
    tags.font = [UIFont fontWithName:FONT_MEDIUM size:12];
    tags.borderStyle = UITextBorderStyleLine;
    tags.delegate = self;
    [scroll addSubview:tags];
    
    
    postButton = [[UIButton alloc] initWithFrame:CGRectMake(0, tags.frame.origin.y + tags.frame.size.height + 5, self.view.frame.size.width / 3, 40)];
    postButton.backgroundColor = [UIColor colorWithRed:0.266 green:0.527 blue:1.000 alpha:1.000];
    [postButton setTitle:@"Post Place" forState:UIControlStateNormal];
    [postButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [postButton addTarget:self action:@selector(postToServer) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:postButton];
    
    imageProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(10, postButton.frame.origin.y + postButton.frame.size.height + 10, self.view.frame.size.width - 20,10 )];
    imageProgress.trackTintColor = [UIColor colorWithWhite:0.980 alpha:0.5];
    [scroll addSubview:imageProgress];
    
    scroll.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
}

- (void)postToServer{
    [ProgressHUD show:@"Uploading" Interaction:NO hide:YES];
    
    PFGeoPoint *point = [PFGeoPoint geoPointWithLatitude:[self deviceLocation].latitude longitude:[self deviceLocation].longitude];
    
    NSData *imageData = UIImagePNGRepresentation(self.imageView.image);
    PFFile *imageFile = [PFFile fileWithName:@"5.png" data:imageData];
    
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        // Handle success or failure here ...
        if (succeeded) {
            PFObject *place = [PFObject objectWithClassName:@"Places"];
            place[@"image_url"] = imageFile.url;
            place[@"location_name_gp"] = @"";
            place[@"landify_user_id"] = @5; // Just hardcoded for Temp usage
            place[@"user_name"] = @"Ranjith"; // Just hardcoded fot Temp usage
            place[@"tags"] = tags.text;
            place[@"user_text"] = userText.text;
            place[@"geo_point"] = point;
            place[@"verify_points"] = @50;
            [place saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [ProgressHUD dismiss];
                    [self closeViewController];
                } else {
                    [ProgressHUD dismiss];
                    // There was a problem, check error.description
                    NSLog(@"Error : %@",error.description);
                }
            }];
        }else{
            [ProgressHUD dismiss];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error in uploading File" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [alert show];
        }
    } progressBlock:^(int percentDone) {
        NSLog(@"Value : %d",percentDone);
        // Update your progress spinner here. percentDone will be between 0 and 100.
        imageProgress.progress = (float)percentDone / 100;
    }];
}

- (void)initLocationManager {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    // Check for iOS 8.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

- (void)closeViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)openCamera{
    TGCameraNavigationController *navigationController =
    [TGCameraNavigationController newWithCameraDelegate:self];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - TGCameraDelegate optional

- (void)cameraWillTakePhoto
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)cameraDidSavePhotoAtPath:(NSURL *)assetURL
{
    // When this method is implemented, an image will be saved on the user's device
    NSLog(@"%s album path: %@", __PRETTY_FUNCTION__, assetURL);
}

- (void)cameraDidSavePhotoWithError:(NSError *)error
{
    NSLog(@"%s error: %@", __PRETTY_FUNCTION__, error);
}

#pragma mark - TGCameraDelegate required

- (void)cameraDidCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cameraDidTakePhoto:(UIImage *)image
{
    self.imageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cameraDidSelectAlbumPhoto:(UIImage *)image
{
    self.imageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error: %@",error.description);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
   NSLog(@"LOC : %@",locations);
}

- (CLLocationCoordinate2D )deviceLocation {
    return self.locationManager.location.coordinate;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
