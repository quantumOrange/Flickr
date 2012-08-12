//
//  PhotoViewController.m
//  Flickr
//
//  Created by David Crooks on 10/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#define MINIMUM_ZOOM 0.2
#define MAXIMUM_ZOOM 5
#import "ScrollingImageViewController.h"
#import "SubtitleTableViewController.h"
#import "FlickrFetcher.h"
@interface ScrollingImageViewController () <SubtitleTableViewControllerDelegate , UIScrollViewDelegate>

@property (nonatomic) BOOL isLandscape;
@end

@implementation ScrollingImageViewController 
@synthesize imageView;
@synthesize scrollView;
@synthesize isLandscape;
-(void) TVC:(UITableViewController *) sender choseTableCell:(NSDictionary *)photo
{
    //////////// SET IMAGE ////////////////////////
    NSLog(@"TVC");
    NSURL *photoURL = [FlickrFetcher urlForPhoto:photo format:FlickrPhotoFormatLarge];
    NSData *imageData = [NSData dataWithContentsOfURL:photoURL];
    UIImage *image =[UIImage imageWithData:imageData];
    self.imageView.image = image;
    self.title=  [photo objectForKey:FLICKR_PHOTO_TITLE];
    /////////// END SET IMAGE /////////////////////
   
    ///////////// RECENT PHOTOS ///////////////////
    //update the list of recently viewed photos
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
    ///////// END RECENT PHOTOS /////////////////
    
    NSLog(@"scroll width: %f",self.scrollView.bounds.size.width);
    NSLog(@"scroll height: %f",self.scrollView.bounds.size.height);
    NSLog(@"image width: %f",self.imageView.image.size.width);
    NSLog(@"image height: %f",self.imageView.image.size.height);
    
    //CGFloat zoom;
    /*
    if (isLandscape) 
    {
       // zoom = MAX(self.scrollView.bounds.size.height / self.photoView.image.size.width, self.scrollView.bounds.size.width / self.photoView.image.size.height);
        //zoom = MAX(self.scrollView.bounds.size.width / self.photoView.image.size.height, self.scrollView.bounds.size.height / self.photoView.image.size.width);
        zoom=1.0;
        //self.photoView.frame = CGRectMake(0,0,self.photoView.image.size.width,self.photoView.image.size.height);
        self.scrollView.contentSize = self.imageView.bounds.size;
        self.imageView.frame = CGRectMake(0,0,self.imageView.image.size.height,self.imageView.image.size.width);
        //CGSize photoLandscape;
        //photoLandscape.width=self.photoView.image.size.height;
        //photoLandscape.height=self.photoView.image.size.width;
        //self.scrollView.contentSize = photoLandscape;
    }
    else 
    {
        zoom = MAX(self.scrollView.bounds.size.width / self.imageView.image.size.width, self.scrollView.bounds.size.height / self.imageView.image.size.height);
        self.imageView.frame = CGRectMake(0,0,self.imageView.image.size.width,self.imageView.image.size.height);
        self.scrollView.contentSize = self.imageView.bounds.size;
    }
    */
    [self setZoomForImage];
}
  
-(void) setZoomForImage
{
    CGFloat zoom = MAX(self.scrollView.bounds.size.width / self.imageView.image.size.width, self.scrollView.bounds.size.height / self.imageView.image.size.height);
    self.imageView.frame = CGRectMake(0,0,self.imageView.image.size.width,self.imageView.image.size.height);
    self.scrollView.contentSize = self.imageView.image.size;
    NSLog(@"zoom: %f",zoom);
    self.scrollView.zoomScale =zoom;
}


- (UIView *) viewForZoomingInScrollView:(UIScrollView *) scrollView
{
    return self.imageView;
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
    NSLog(@"View did load");
    [super viewDidLoad];
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = MINIMUM_ZOOM;
    self.scrollView.maximumZoomScale = MAXIMUM_ZOOM;
    if(self.imageView.image) [self setZoomForImage];
}

-(void) viewWillAppear:(BOOL)animated
{
    NSLog(@"View will appear");
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    NSLog(@"should autorotate");
    self.isLandscape = UIInterfaceOrientationIsLandscape(interfaceOrientation);
    return YES;
    
}

@end
