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
@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Load data from appy
    
    self.tableView.dataSource = self;

    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=98d749638f0971b6300df0b516a15ed0"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
               self.movieArray = dataDictionary[@"results"];
               [self.tableView reloadData];
               // TODO: Get the array of movies
               // TODO: Store the movies in a property to use elsewhere
               // TODO: Reload your table view data
           }
       }];
    [task resume];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MovieViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.movieArray[indexPath.row][@"original_title"];
    cell.synopsisLabel.text = self.movieArray[indexPath.row][@"overview"];
    NSString *str = @"https://api.themoviedb.org/3/movie/";
    str = [str stringByAppendingString:self.movieArray[indexPath.row][@"poster_path"]];
    NSURL *url = [NSURL URLWithString:str];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: url];
    UIImage *image = [UIImage imageWithData: imageData];
    [cell.posterImage setImage:image];
    
    
    //cell.textLabel.text = self.movieArray[indexPath.row][@"original_title"];
    return  cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movieArray.count;
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
