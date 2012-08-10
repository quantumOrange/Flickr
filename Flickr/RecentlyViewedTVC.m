//
//  RecentlyViewedTVC.m
//  Flickr
//
//  Created by David Crooks on 24/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RecentlyViewedTVC.h"
#import "FlickrFetcher.h"


@implementation RecentlyViewedTVC
@synthesize tableData=_tableData;
@synthesize cellIdentifier=_cellIdentifier;

-(NSArray *) tableData
{
    if(!_tableData)
    {
        //_tableData= 
    }
    return _tableData;
}

-(NSString *) cellIdentifier
{
    if(!_cellIdentifier)
    {
        _cellIdentifier= @"Recently Viewed";
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



@end
