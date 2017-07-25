//
//  ImageObject.m
//  Photos
//
//  Created by steve on 2017-07-24.
//  Copyright © 2017 Sam Meech-Ward. All rights reserved.
//

#import "ImageObject.h"

@implementation ImageObject
- (instancetype)initWithImage:(UIImage *)image {
  if (self = [super init]) {
    _defaultImage = image;
  }
  return self;
}

@end
