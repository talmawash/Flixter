//
//  MovieViewController.h
//  Flixter
//
//  Created by Tariq Almawash on 6/15/22.
//

#import <UIKit/UIKit.h>
#import "MovieViewCell.h"
#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@end


NS_ASSUME_NONNULL_END
