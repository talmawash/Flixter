//
//  MovieCollectionViewCell.h
//  Flixter
//
//  Created by Tariq Almawash on 6/16/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *posterHolder;
@property (strong, nonatomic) NSDictionary *arrayEntry;

@end

NS_ASSUME_NONNULL_END
