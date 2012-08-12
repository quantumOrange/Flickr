//
//  SubtileTableViewController.h
//  Flickr
//
//  Created by David Crooks on 24/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SubtitleTableViewController;

@protocol SubtitleTableViewControllerDelegate 
@optional 
-(void) TVC:(SubtitleTableViewController *) sender choseTableCell:(NSDictionary *)tableCellData;
@end

@interface SubtitleTableViewController : UITableViewController

//tableData is an array of dictionarys
@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, strong)  NSString *cellIdentifier;
@property (nonatomic, weak) id <SubtitleTableViewControllerDelegate> delegate;
@end







