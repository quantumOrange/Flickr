//
//  PhotoViewController.m
//  Flickr
//
//  Created by David Crooks on 10/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhotoViewController.h"
#import "SubtileTableViewController.h"
#import "FlickrFetcher.h"
@interface PhotoViewController () <SubtileTableViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@end

@implementation PhotoViewController 
@synthesize photoView;

-(void) TVC:(SubtileTableViewController *) sender choseTableCell:(NSDictionary *)photo
{
    NSURL *photoURL = [FlickrFetcher urlForPhoto:photo format:FlickrPhotoFormatLarge];
    NSData *imageData = [NSData dataWithContentsOfURL:photoURL];
    UIImage *image =[UIImage imageWithData:imageData];
    self.photoView.image = image;
    
    //update the list of recently viewd photos
    NSMutableArray *recentPhotos;
    recentPhotos = [[[NSUserDefaults standardUserDefaults] objectForKey:@"recentlyViewedPhotos"] mutableCopy];
    if(!recentPhotos)  recentPhotos =[[NSMutableArray alloc] init];
    
    //check if the photo we're viewing is already recently viewed using its unique id
    NSNumber *photoId = [photo objectForKey:@"id"];
    BOOL photoIsAlreadyRecentlyViewed=NO;
    for (NSDictionary *recentPhoto in recentPhotos) {
        if([photoId isEqual:[recentPhoto objectForKey:@"id"]]) photoIsAlreadyRecentlyViewed=YES;
    }
    
    
    if (!photoIsAlreadyRecentlyViewed) [recentPhotos insertObject:photo atIndex:0];
    
    if ([recentPhotos count]>50) [recentPhotos removeLastObject];
    NSLog(@"%@",recentPhotos);
    [[NSUserDefaults standardUserDefaults] setObject:recentPhotos forKey:@"recentlyViewedPhotos"];
    [NSUserDefaults resetStandardUserDefaults];
}
     



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setPhotoView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
