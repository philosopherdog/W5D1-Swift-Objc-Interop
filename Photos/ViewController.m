#import "ViewController.h"
#import "PhotoCollectionViewCell.h"
#import "DataManager.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray<NSDictionary *> *photos;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) DataManager *dataManager;
@end

@implementation ViewController

- (void)setPhotos:(NSArray<NSDictionary *> *)photos {
  _photos = photos;
  dispatch_queue_t mainQ = dispatch_get_main_queue();
  dispatch_async(mainQ, ^{
    [self.collectionView reloadData];
  });
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.dataManager = [DataManager new];
  [self setupItemSize];
  [self.dataManager performRequest:^(NSArray *photos) {
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

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo-cell" forIndexPath:indexPath];
  
  NSDictionary *photo = self.photos[indexPath.row];
  cell.label.text = photo[@"title"];
  NSURL *url = [NSURL URLWithString:photo[@"url_m"]];
  [self.dataManager fetchImageAtURL:url handler:^(UIImage *image) {
    dispatch_queue_t mainQ = dispatch_get_main_queue();
    dispatch_async(mainQ, ^{
      cell.imageView.image = image;
    });
  }];
  return cell;
}



@end

