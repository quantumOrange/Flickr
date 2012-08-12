//
//  TopPlacesTVC.h
//  Flickr
//
//  Created by David Crooks on 24/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubtitleTableViewController.h"
@class TopPlacesTVC;

@protocol TopPlacesTVCDelegate 
@optional 
-(void) TVC:(TopPlacesTVC *) sender choseTableCell:(NSDictionary *)tableCellData;
@end

@interface TopPlacesTVC : SubtitleTableViewController

@end
