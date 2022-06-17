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
    [self loadPoster];
    [self loadBackdrop];
}

- (void)loadPoster {
    NSString *str = @"https://image.tmdb.org/t/p/w342";
        
    NSURL *smallURL = [NSURL URLWithString:[str stringByAppendingString:self.posterPath]];
    
    str = @"https://image.tmdb.org/t/p/original";
        
    NSURL *largeURL = [NSURL URLWithString:[str stringByAppendingString:self.posterPath]];
    
    NSURLRequest *posterReq = [NSURLRequest requestWithURL:smallURL];
    NSURLRequest *posterReqLarge  = [NSURLRequest requestWithURL:largeURL];

    [self.posterHolder setImageWithURLRequest:posterReq placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        if (response) {
            self.posterHolder.alpha = 0.0;
            self.posterHolder.image = image;
            [UIView animateWithDuration:1 animations:^{
                self.posterHolder.alpha = 1;
            } completion:^(BOOL finished) {
                [self.posterHolder setImageWithURLRequest:posterReqLarge placeholderImage:image success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                    self.posterHolder.image = image;
                } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                    
                }];
            }];
        }
        else {
            [self.posterHolder setImageWithURLRequest:posterReqLarge placeholderImage:image success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                self.posterHolder.image = image;
            } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                
            }];
        }
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        
    }];
    
}

- (void)loadBackdrop {
    NSString *str = @"https://image.tmdb.org/t/p/w300";
        
    NSURL *smallURL = [NSURL URLWithString:[str stringByAppendingString:self.backdropPath]];
    
    str = @"https://image.tmdb.org/t/p/original";
        
    NSURL *largeURL = [NSURL URLWithString:[str stringByAppendingString:self.backdropPath]];
    
    NSURLRequest *posterReq = [NSURLRequest requestWithURL:smallURL];
    NSURLRequest *posterReqLarge = [NSURLRequest requestWithURL:largeURL];

    [self.backdropHolder setImageWithURLRequest:posterReq placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        if (response) {
            self.backdropHolder.alpha = 0.0;
            self.backdropHolder.image = image;
            [UIView animateWithDuration:1 animations:^{
                self.backdropHolder.alpha = 1;
            } completion: ^(BOOL finished){
                [self.backdropHolder setImageWithURLRequest:posterReqLarge placeholderImage:image success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                    self.backdropHolder.image = image;
                } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {}];
            }];
        }
        else {
            [self.backdropHolder setImageWithURLRequest:posterReqLarge placeholderImage:image success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                self.backdropHolder.image = image;
            } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {}];
        }

    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        
    }];
    
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
