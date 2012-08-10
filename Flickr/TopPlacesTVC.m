//
//  TopPlacesTVC.m
//  Flickr
//
//  Created by David Crooks on 24/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TopPlacesTVC.h"
#import "FlickrFetcher.h"

@interface TopPlacesTVC ()

@end



@implementation TopPlacesTVC
@synthesize tableData=_tableData;
@synthesize cellIdentifier=_cellIdentifier;


#pragma mark - Table view data source
-(NSArray *) tableData
{
    if(!_tableData)
    {
        _tableData= [FlickrFetcher topPlaces];
    }
    return _tableData;
}

-(NSString *) cellIdentifier
{
    if(!_cellIdentifier)
    {
        _cellIdentifier= @"Place";
    }
    return _cellIdentifier;
}

-(NSString *) tableCellTitle: (NSDictionary *) tableCellData
{
    NSString *nameOfPlace=[tableCellData objectForKey:@"_content"];
    NSArray *components=[nameOfPlace componentsSeparatedByString:@","];
    NSString *title=[components objectAtIndex:0];
    return title;
}

-(NSString *) tableCellSubtitle: (NSDictionary *) tableCellData
{
    NSString *nameOfPlace=[tableCellData objectForKey:@"_content"];
    NSArray *components=[nameOfPlace componentsSeparatedByString:@","];
    NSString *title=[components objectAtIndex:0];
    NSString *subtitle=[nameOfPlace substringFromIndex:[title length]+2];
    return subtitle;
}


@end
