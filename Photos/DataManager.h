//
//  DataManager.h
//  Photos
//
//  Created by steve on 2017-07-23.
//  Copyright © 2017 Sam Meech-Ward. All rights reserved.
//

@import UIKit;
@class PhotoCollectionViewCell;
@class Photo;

@interface DataManager : NSObject
- (void)performRequest:(void (^)(NSArray<Photo*> *))completionHandler;
- (void)fetchImageAtURL:(NSURL *)url handler:(void (^)(UIImage *image))handler;
@end
