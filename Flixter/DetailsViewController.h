//
//  DetailsViewController.h
//  Flixter
//
//  Created by Tariq Almawash on 6/16/22.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backdropHolder;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterHolder;
@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;
@property (weak, nonatomic) NSString *movieTitle;
@property (weak, nonatomic) NSString *movieOverview;
@property (weak, nonatomic) NSURL *posterURL;
@property (weak, nonatomic) NSURL *backdropURL;

@end

NS_ASSUME_NONNULL_END
