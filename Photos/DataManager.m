//
//  DataManager.m
//  Photos
//
//  Created by steve on 2017-07-23.
//  Copyright © 2017 Sam Meech-Ward. All rights reserved.
//

#import "DataManager.h"
#import "PhotoCollectionViewCell.h"
#import "Photos-Swift.h"

@implementation DataManager
- (void)performRequest:(void (^)(NSArray<Photo*> *))completionHandler {
  
  NSURL *url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&api_key=ee67416e0ab6d455026b90b4bfb1e5a1&tags=cat&nojsoncallback=1&extras=url_m"];
  NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
  
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  
  NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    if (error) {
      NSLog(@"error: %@", error.localizedDescription);
      return;
    }
    
    NSError *jsonError = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    
    if (jsonError) {
      NSLog(@"jsonError: %@", jsonError.localizedDescription);
      return;
    }
    
    completionHandler([self convertJSONToPhotos:json]);

  }];
  
  [dataTask resume];
  
}

- (NSArray<Photo*> *)convertJSONToPhotos:(NSDictionary *)json {
  NSDictionary *photosDictionary = json[@"photos"];
  NSArray *photoDictionaries = photosDictionary[@"photo"];
  NSMutableArray <Photo*>*result = [[NSMutableArray alloc] initWithCapacity:photoDictionaries.count];
  
  for (NSDictionary *dict in photoDictionaries) {
    NSString *urlString = dict[@"url_m"];
    if (!urlString || [urlString isEqualToString:@""]) {
      continue;
    }
    NSString *title = dict[@"title"];
    Photo *photo = [[Photo alloc] initWithTitle:title url:[NSURL URLWithString:urlString]];
    [result addObject:photo];
  }
  
  return result;
}

- (void)fetchImageAtURL:(NSURL *)url handler:(void (^)(UIImage *image))handler {
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  
  NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    if (error) {
      NSLog(@"error: %@", error.localizedDescription);
      return;
    }
    
    NSData *data = [NSData dataWithContentsOfURL:location];
    
    UIImage *image = [UIImage imageWithData:data];
    handler(image);
  }];
  
  [downloadTask resume];
}

@end
