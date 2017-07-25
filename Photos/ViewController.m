#import "ViewController.h"
#import "PhotoCollectionViewCell.h"
#import "DataManager.h"
#import "Photos-Swift.h"
#import "ImageObject.h"

@interface ViewController () <UICollectionViewDataSource>

@property (nonatomic, strong) NSArray<Photo *> *photos;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) DataManager *dataManager;
@end

@implementation ViewController

- (void)setPhotos:(NSArray<Photo *> *)photos {
  _photos = photos;
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.collectionView reloadData];
  });
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.dataManager = [DataManager new];
  [self setupItemSize];
  [self.dataManager performRequest:^(NSArray<Photo*> *photos) {
    self.photos = photos;
  }];
}

- (void)setupItemSize {
  UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
  CGFloat width = self.view.bounds.size.width/2;
  layout.itemSize = CGSizeMake(width, width);
}

#pragma mark - Collection View

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.photos.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo-cell" forIndexPath:indexPath];
  
  Photo *photo = self.photos[indexPath.row];
  
  cell.photo = photo;
  if (!photo.imageObject) {
    [self.dataManager fetchImageAtURL:photo.url handler:^(UIImage *image) {
      dispatch_queue_t mainQ = dispatch_get_main_queue();
      dispatch_async(mainQ, ^{
        ImageObject *imageObject = [[ImageObject alloc] initWithImage:image];
        photo.imageObject = imageObject;
        cell.photo = photo;
      });
    }];
  }
  return cell;
}

@end

