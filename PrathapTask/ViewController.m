//
//  ViewController.m
//  PrathapTask
//
//  Created by test on 7/25/16.
//  Copyright © 2016 Wipro. All rights reserved.
//

#import "ViewController.h"
#import "FactsUtility.h"
#import "FactsModel.h"
#import "CustemTableViewCell.h"

@interface ViewController () <FactsDelegate,UITableViewDelegate,UITableViewDataSource>
{
    FactsUtility *factsUtility ;
    NSMutableArray *factsModelsArray ; // array can store factsmodel objects
    UITableView *baseTableView ;
    UIRefreshControl *refreshControl ;
    UIActivityIndicatorView *activityIndicator ;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    factsModelsArray = [[NSMutableArray alloc] init];
    baseTableView = [[UITableView alloc] init];
    baseTableView.dataSource = self;
    baseTableView.delegate = self;
    baseTableView.rowHeight = UITableViewAutomaticDimension;
    baseTableView.estimatedRowHeight = 2.0;
    [baseTableView registerClass:[CustemTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:baseTableView];
    
    factsUtility = [[FactsUtility alloc] init];
    factsUtility.delegate = self ;
    [factsUtility getFactsData];
    [self createActivityIndicator];
    
    baseTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addPullToRefreshController];
    [self addConstraintsToTableView];
    
}

-(void) addConstraintsToTableView
{
    NSLayoutConstraint *baseTableViewLeadingConstraint = [NSLayoutConstraint constraintWithItem:baseTableView
                                                                                      attribute:NSLayoutAttributeLeading
                                                                                      relatedBy:NSLayoutRelationEqual
                                                                                         toItem:self.view
                                                                                      attribute:NSLayoutAttributeLeading
                                                                                     multiplier:1
                                                                                       constant:0] ;
    NSLayoutConstraint *baseTableViewTopConstraint = [NSLayoutConstraint constraintWithItem:baseTableView
                                                                                  attribute:NSLayoutAttributeTop
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self.view
                                                                                  attribute:NSLayoutAttributeTop
                                                                                 multiplier:1
                                                                                   constant:0] ;
    NSLayoutConstraint *baseTableViewBottomConstraint = [NSLayoutConstraint constraintWithItem:baseTableView
                                                                                     attribute:NSLayoutAttributeBottom
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:self.view
                                                                                     attribute:NSLayoutAttributeBottom
                                                                                    multiplier:1
                                                                                      constant:0] ;
    NSLayoutConstraint *baseTableViewTrailingConstraint = [NSLayoutConstraint constraintWithItem:baseTableView
                                                                                       attribute:NSLayoutAttributeTrailing
                                                                                       relatedBy:NSLayoutRelationEqual
                                                                                          toItem:self.view
                                                                                       attribute:NSLayoutAttributeTrailing
                                                                                      multiplier:1
                                                                                        constant:0] ;
    
    [self.view addConstraints:[NSArray arrayWithObjects:baseTableViewLeadingConstraint,baseTableViewTopConstraint,baseTableViewBottomConstraint,baseTableViewTrailingConstraint, nil]] ;
}

-(void) addPullToRefreshController
{
    refreshControl = [[UIRefreshControl alloc]init];
    [baseTableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshHasTriggered) forControlEvents:UIControlEventValueChanged];
}

- (void)refreshHasTriggered {
    [factsUtility getFactsData];
    [self createActivityIndicator];
    [refreshControl endRefreshing];
    [baseTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return factsModelsArray.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    FactsModel *facts = [factsModelsArray objectAtIndex:indexPath.row];
    cell.titleLabel.text = facts.factTitle;
    cell.descriptionLabel.text = facts.factDescription;
    cell.rowImageView.image = [UIImage imageNamed:@"placeholder.png"];
    // this will load image asynchronously
    [self downloadImageWithURL:[NSURL URLWithString:facts.factImageUrl] completionBlock:^(BOOL succeeded, UIImage *image) {
        if(succeeded)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
               cell.rowImageView.image = image;
            });
            
        }
        
    }];
    [cell updateConstraints];
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    cell.backgroundColor = [UIColor lightGrayColor];
    return cell ;
}

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error)
    {
                if(!error)
                {
                    UIImage *image = [[UIImage alloc] initWithData:data];
                    completionBlock(YES,image);
                }
                else
                {
                    completionBlock(NO,nil);
                }
                
    }] resume];

}


// delegate method from FactsUtility
-(void) reloadTableViewWithFactsData:(NSDictionary *)dataDictionary
{
    NSMutableArray *rowsArray = [dataDictionary valueForKey:@"rows"];
    [factsModelsArray removeAllObjects];
    
    for (NSDictionary *dataDict in rowsArray)
    {
        FactsModel *model =[[FactsModel alloc] init];
        [factsModelsArray addObject:[model returnFactsModelWithData:dataDict]];
    }
    
    self.title = [dataDictionary objectForKey:@"title"];
    [baseTableView reloadData];
    [self startStopActivitiyIndicator:NO];
}

#pragma mark Activity Indicator

-(void)createActivityIndicator
{
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:activityIndicator];
    activityIndicator.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    
    [self startStopActivitiyIndicator:YES];
    
}

-(void)startStopActivitiyIndicator:(BOOL)state
{
    if (state==YES)
    {
        [activityIndicator startAnimating];
        
    }
    else
    {
        [activityIndicator stopAnimating];
        
    }
}

@end
