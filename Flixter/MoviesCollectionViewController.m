//
//  MoviesCollectionViewController.m
//  Flixter
//
//  Created by Tariq Almawash on 6/16/22.
//

#import "MoviesCollectionViewController.h"

@interface MoviesCollectionViewController ()
@property (nonatomic, strong) NSArray *movieArray;
@property (nonatomic, strong) NSArray *filteredArray;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation MoviesCollectionViewController

static NSString * const reuseIdentifier = @"MovieCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[MovieCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.collectionView insertSubview:self.refreshControl atIndex:0];
    
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
                self.filteredArray = self.movieArray;
               [self.collectionView reloadData];
                [self.refreshControl endRefreshing];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
               }
       }];
    [task resume];
}

//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    if (searchText.length > 0) {
//        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
//            return [evaluatedObject[@"title"] containsString:searchText];
//        }];
//        self.filteredArray = [self.movieArray filteredArrayUsingPredicate:predicate];
//    }
//    else {
//        self.filteredArray = self.movieArray;
//    }
//
//    [self.collectionView reloadData];
//}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    DetailsViewController *destination = [segue destinationViewController];
    MovieCollectionViewCell *cell = sender;
    destination.movieTitle = cell.arrayEntry[@"title"];
    destination.movieOverview = cell.arrayEntry[@"overview"];

    destination.posterPath = cell.arrayEntry[@"poster_path"];
    destination.backdropPath = cell.arrayEntry[@"backdrop_path"];
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.filteredArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    NSString *str = @"https://image.tmdb.org/t/p/w154";
        
    NSURL *URL = [NSURL URLWithString:[str stringByAppendingString:self.movieArray[indexPath.row][@"poster_path"]]];
    
    cell.arrayEntry = self.filteredArray[indexPath.row];
    
    NSURLRequest *posterReq = [NSURLRequest requestWithURL:URL];
    [cell.posterHolder setImageWithURLRequest:posterReq placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        if (response) {
            cell.posterHolder.alpha = 0.0;
            cell.posterHolder.image = image;
            [UIView animateWithDuration:1 animations:^{
                cell.posterHolder.alpha = 1;
            }];
        }
        else {
            cell.posterHolder.image = image;
        }
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        
    }];
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/


// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
