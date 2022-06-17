//
//  MovieViewController.m
//  Flixter
//
//  Created by Tariq Almawash on 6/15/22.
//

#import "MovieViewController.h"


@interface MovieViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *movieArray;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    // Load data from appy
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self beginRefresh:self.refreshControl];
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=98d749638f0971b6300df0b516a15ed0"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

            if (error != nil) {
               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"A network error occured. Please check your internet connection." preferredStyle:UIAlertControllerStyleAlert];
               UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                   [self.refreshControl endRefreshing];
                   [MBProgressHUD hideHUDForView:self.view animated:YES];
                   [self beginRefresh:self.refreshControl];
               }];
               [alert addAction:okAction];
               [self presentViewController:alert animated:YES completion:^{

               }];
            }
            else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
               self.movieArray = dataDictionary[@"results"];
               [self.tableView reloadData];
                [self.refreshControl endRefreshing];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
       }];
    [task resume];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MovieViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.movieArray[indexPath.row][@"original_title"];
    cell.synopsisLabel.text = self.movieArray[indexPath.row][@"overview"];
    
    NSString *str = @"https://image.tmdb.org/t/p/w342";
        
    cell.posterURL = [NSURL URLWithString:[str stringByAppendingString:self.movieArray[indexPath.row][@"poster_path"]]];
    
    cell.backdropURL = [NSURL URLWithString:[str stringByAppendingString:self.movieArray[indexPath.row][@"backdrop_path"]]];
    
    NSURLRequest *posterReq = [NSURLRequest requestWithURL:cell.posterURL];
    [cell.posterImage setImageWithURLRequest:posterReq placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        if (response) {
            cell.posterImage.alpha = 0.0;
            cell.posterImage.image = image;
            [UIView animateWithDuration:1 animations:^{
                cell.posterImage.alpha = 1;
            }];
        }
        else {
            cell.posterImage.image = image;
        }
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        
    }];
    
    return  cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movieArray.count;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    DetailsViewController *destination = [segue destinationViewController];
    MovieViewCell *cell = sender;
    destination.movieTitle = cell.titleLabel.text;
    destination.movieOverview = cell.synopsisLabel.text;
    NSInteger indexPathR = [self.tableView indexPathForCell:cell].row;
    destination.posterPath = self.movieArray[indexPathR][@"poster_path"];
    destination.backdropPath = self.movieArray[indexPathR][@"backdrop_path"];
}


@end
