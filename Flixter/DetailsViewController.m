//
//  DetailsViewController.m
//  Flixter
//
//  Created by Tariq Almawash on 6/16/22.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = self.movieTitle;
    self.overviewLabel.text = self.movieOverview;
    [self.titleLabel sizeToFit];
    [self.overviewLabel sizeToFit];
    NSLog(@"%@", self.posterURL);
    [self.posterHolder setImageWithURL:self.posterURL];
    [self.backdropHolder setImageWithURL:self.backdropURL];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
