//
//  ImageObject.h
//  Photos
//
//  Created by steve on 2017-07-24.
//  Copyright © 2017 Sam Meech-Ward. All rights reserved.
//

@import UIKit;

@interface ImageObject : NSObject
@property (nonatomic, strong) UIImage * _Nonnull defaultImage;
- (instancetype _Nonnull )initWithImage:(UIImage * _Nonnull )image;
@end
