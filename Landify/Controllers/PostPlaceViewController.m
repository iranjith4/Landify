//
//  PostPlaceViewController.m
//  Landify
//
//  Created by Ranjith on 25/04/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import "PostPlaceViewController.h"

@interface PostPlaceViewController (){
    UIButton *camera;
}

@end

@implementation PostPlaceViewController

- (void)viewDidLoad {
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
    [self.view addSubview:close];
    
    camera = [[UIButton alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 50)];
    [camera setTitle:@"CAMERA" forState:UIControlStateNormal];
    [camera setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [camera addTarget:self action:@selector(openCamera) forControlEvents:UIControlEventTouchUpInside];
    [camera sizeToFit];
    [self.view addSubview:camera];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, camera.frame.origin.y + camera.frame.size.height, self.view.frame.size.width, self.view.frame.size.width)];
    [self.view addSubview:self.imageView];
    
}

- (void)initLocationManager {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;

    // Check for iOS 8.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
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
   
    NSLog(@"%@",locations);
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
