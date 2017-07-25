#import "PhotoCollectionViewCell.h"
#import "Photos-Swift.h"
#import "ImageObject.h"

@interface PhotoCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation PhotoCollectionViewCell
- (void)setPhoto:(Photo *)photo {
  _photo = photo;
  self.imageView.image = _photo.imageObject.defaultImage;
  self.label.text = _photo.title;
}
@end
