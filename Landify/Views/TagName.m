//
//  TagName.m
//  Landify
//
//  Created by Ranjith on 25/04/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import "TagName.h"

@implementation TagName

- (instancetype)initWithName:(NSString *)name;
{
    self = [super init];
    if (self) {
        [self initUI];
        self.labelTag = name;
    }
    return self;
}

- (void) initUI{
    self.backgroundColor = [UIColor clearColor];
    self.text = self.labelTag;
    [self sizeToFit];
    [self adjustFrame];
    self.layer.cornerRadius = 3.0;
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.layer.borderWidth = 2;
    self.layer.masksToBounds = YES;
}

- (void)adjustFrame{
    CGRect frame = self.frame;
    frame.size.width += 4;
    frame.size.height += 4;
    self.frame = frame;
}

@end
