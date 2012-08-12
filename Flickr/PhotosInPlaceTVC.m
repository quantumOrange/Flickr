//
//  PhotosInPlaceTVC.m
//  Flickr
//
//  Created by David Crooks on 24/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhotosInPlaceTVC.h"
#import "FlickrFetcher.h"
#import "TopPlacesTVC.h"

@interface PhotosInPlaceTVC () <TopPlacesTVCDelegate>

@end

@implementation PhotosInPlaceTVC
@synthesize cellIdentifier=_cellIdentifier;

-(void) TVC:(TopPlacesTVC *) sender choseTableCell:(NSDictionary *)place
{
    self.tableData = [FlickrFetcher photosInPlace:place maxResults:50];
    self.title = [place objectForKey:FLICKR_PHOTO_TITLE];
   // NSLog(@"%@",self.tableData);
}


#pragma mark - Table view data source
-(NSString *) cellIdentifier
{
    if(!_cellIdentifier)
    {
        _cellIdentifier= @"Photo At Place";
    }
    return _cellIdentifier;
}


-(NSString *) tableCellTitle: (NSDictionary *) tableCellData
{
    NSString *title=[tableCellData  objectForKey:@"title"];
    return title;
}


-(NSString *) tableCellSubtitle: (NSDictionary *) tableCellData
{
    NSString *subtitle=[tableCellData  valueForKeyPath:@"description._content"];
    return subtitle;
}


#pragma mark - Table view delegate


@end
