//
//  SubtileTableViewController.m
//  Flickr
//
//  Created by David Crooks on 24/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SubtileTableViewController.h"

@interface SubtileTableViewController ()

@end

@implementation SubtileTableViewController
@synthesize tableData=_tableData;
@synthesize delegate=_delegate;
@synthesize cellIdentifier=_cellIdentifier;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.tableData count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = self.cellIdentifier;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) 
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *tableCellData = [self.tableData objectAtIndex:indexPath.row];
    
    
    if ([self tableCellTitle:tableCellData]  && ![[self tableCellTitle:tableCellData] isEqualToString:@""]) 
    {
        cell.textLabel.text = [self tableCellTitle:tableCellData];
    }
    else 
    {
        cell.textLabel.text =@"Unknown";
    }
    
    
    if ([self tableCellSubtitle:tableCellData] && ![[self tableCellSubtitle:tableCellData]  isEqualToString:@""]) 
    {
        cell.detailTextLabel.text= [self tableCellSubtitle:tableCellData];
    }
    else 
    {
        cell.detailTextLabel.text=@"No description availble";
    }
    
    return cell;
}

-(NSString *) tableCellTitle: (NSDictionary *) tableCellData
{
    NSString *title=[tableCellData objectForKey:@"title"];
    return title;
}


-(NSString *) tableCellSubtitle: (NSDictionary *) tableCellData
{
    NSString *subtitle=[tableCellData objectForKey:@"description"];
    return subtitle;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tableCellData=[self.tableData objectAtIndex:indexPath.row];
    [self.delegate TVC:self choseTableCell:tableCellData];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.delegate=segue.destinationViewController;
}


@end
