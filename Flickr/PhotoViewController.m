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
@interface PhotoViewController () <SubtileTableViewControllerDelegate , UIScrollViewDelegate>


@end

@implementation PhotoViewController 
@synthesize photoView;
@synthesize scrollView;

-(void) TVC:(SubtileTableViewController *) sender choseTableCell:(NSDictionary *)photo
{
   NSURL *photoURL = [FlickrFetcher urlForPhoto:photo format:FlickrPhotoFormatLarge];
   NSData *imageData = [NSData dataWithContentsOfURL:photoURL];
   UIImage *image =[UIImage imageWithData:imageData];
    self.photoView.image = image;
    self.title=  [photo objectForKey:FLICKR_PHOTO_TITLE];
   
    //update the list of recently viewd photos
    NSMutableArray *recentPhotos;
    recentPhotos = [[[NSUserDefaults standardUserDefaults] objectForKey:@"recentlyViewedPhotos"] mutableCopy];
    if(!recentPhotos)  recentPhotos =[[NSMutableArray alloc] init];
    
    //check if the photo we're viewing is already recently viewed using its unique id
    NSNumber *photoId = [photo objectForKey:@"id"];
    
    
    for (int i=0; i<[recentPhotos count]; i++) {
        if([photoId isEqual:[[recentPhotos objectAtIndex:i] objectForKey:@"id"]])  [recentPhotos removeObjectAtIndex:i];
    }
    [recentPhotos insertObject:photo atIndex:0];
    
    if ([recentPhotos count]>50) [recentPhotos removeLastObject];
    
    [[NSUserDefaults standardUserDefaults] setObject:recentPhotos forKey:@"recentlyViewedPhotos"];
    [NSUserDefaults resetStandardUserDefaults];
        
    self.scrollView.contentSize = self.photoView.image.size;
    self.photoView.frame = CGRectMake(0,0,self.photoView.image.size.width,self.photoView.image.size.height);
    CGFloat maxZoom = MAX(self.scrollView.bounds.size.width / self.photoView.image.size.width, self.scrollView.bounds.size.height / self.photoView.image.size.height);
    self.scrollView.zoomScale =maxZoom;
}
     
- (UIView *) viewForZoomingInScrollView:(UIScrollView *) scrollView
{
    return self.photoView;
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
    self.scrollView.delegate = self;
}

- (void)viewDidUnload
{
    [self setPhotoView:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
