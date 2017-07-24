# Swift + Objective-C Demo

* Add a `Photo` object instead of using a dictionary. 
* Create a `ImageObject` class in Objective-C with a `defaultImage` `UIImage*` property for caching an image of the small size.
* Create a property on the `Photo` class for a `ImageObject`.
* Refactor the Cell to only take a `Photo` object.
* Refactor the image fetch method so that it fetches the missing images. You will have to pass it the `photo` instance and the `cell` instance.