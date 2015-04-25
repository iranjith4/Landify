//
//  FeedCell.m
//  Landify
//
//  Created by Ranjith on 25/04/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import "FeedCell.h"
#import "Constants.h"
#import "TagName.h"

@implementation FeedCell{
    float xPos;
    float yPos;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)initUIForSize:(CGSize)size{
    xPos = 10;
    yPos = 10;
    self.backgroundColor = [UIColor whiteColor];
    if (!self.mainImage) {
        self.mainImage = [[UIImageView alloc] initWithFrame:CGRectMake(xPos, yPos, size.width,size.height * 0.70)];
        self.mainImage.backgroundColor = [UIColor orangeColor];
        [self addSubview:self.mainImage];
        yPos += self.mainImage.frame.size.height + 3;
    }
    
    if (!self.location) {
        self.location = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos, size.width,size.height * 0.04)];
        self.location.font = [UIFont fontWithName:FONT_LIGHT size:9];
        self.location.textColor = [UIColor lightGrayColor];
        [self addSubview:self.location];
        yPos +=  self.location.frame.size.height + 3;
    }
    self.location.text = @"18.3535, 10.34234";
    
    if (!self.userName) {
        self.userName = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos,size.width, size.height * 0.04)];
        self.userName.font = [UIFont fontWithName:FONT_MEDIUM size:14];
        self.userName.textColor = [UIColor grayColor];
        [self addSubview:self.userName];
        yPos += self.userName.frame.size.height;
    }
    self.userName.text = @"Sibi";
    
    if (!self.tagNames) {
        self.tagNames = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos,size.width, size.height * 0.04)];
        self.tagNames.font = [UIFont fontWithName:FONT_MEDIUM size:13];
        self.tagNames.textColor = [UIColor grayColor];
        [self addSubview:self.tagNames];
        yPos += self.userName.frame.size.height;
    }
    self.tagNames.text = @"Housing, Pleasant";
    
    if (!self.userText) {
        self.userText = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos,size.width, size.height * 0.04)];
        self.userText.font = [UIFont fontWithName:FONT_MEDIUM size:14];
        self.userText.textColor = [UIColor colorWithRed:0.177 green:0.629 blue:0.373 alpha:1.000];
        [self addSubview:self.userText];
        yPos += self.userText.frame.size.height;
    }
    self.userText.text = @"This is a good Place for living with Good Place";
    
    if (!self.verifiedSign) {
        self.verifiedSign = [[UIImageView alloc] initWithFrame:CGRectMake(self.mainImage.frame.origin.x + self.mainImage.frame.size.width - 35, self.mainImage.frame.size.height + self.mainImage.frame.origin.y + 3, 30, 30)];
        self.verifiedSign.backgroundColor = [UIColor greenColor];
        [self addSubview:self.verifiedSign];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end