//
//  BorderedButton.m
//  MusicStories
//
//  Created by Song Liao on 8/2/16.
//  Copyright © 2016 Song. All rights reserved.
//

#import "BorderedButton.h"

@implementation BorderedButton


- (void)drawRect:(CGRect)rect {
  self.layer.borderColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0].CGColor;
  self.layer.borderWidth = 1.0f;
}
@end
