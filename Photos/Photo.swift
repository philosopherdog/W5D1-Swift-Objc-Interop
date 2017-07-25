//
//  Photo.swift
//  Photos
//
//  Created by steve on 2017-07-24.
//  Copyright © 2017 Sam Meech-Ward. All rights reserved.
//

import Foundation

class Photo: NSObject {
  let title: String
  let url: URL
  init(title: String, url: URL) {
    self.title = title
    self.url = url
  }
  var imageObject: ImageObject?
}
