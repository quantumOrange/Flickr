//
//  SubtileTableViewController.m
//  Flickr
//
//  Created by David Crooks on 24/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SubtitleTableViewController.h"

@interface SubtitleTableViewController ()

@end

@implementation SubtitleTableViewController
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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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
    NSLog(@"Call TVC delagate");
    [self.delegate TVC:self choseTableCell:tableCellData];
    NSLog(@"TVC called");
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"Prepare for segue");
    self.delegate=segue.destinationViewController;

    NSLog(@"delagate set");
}


@end
