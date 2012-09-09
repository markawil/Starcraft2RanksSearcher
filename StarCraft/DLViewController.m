//
//  DLViewController.m
//  StarCraft
//
//  Created by Mark Wilkinson on 8/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DLViewController.h"
#import "DLPlayerInfo.h"
#import "DLSc2RanksService.h"
#import "DLWebView.h"

@implementation DLViewController {
    
    NSMutableArray *players;
}

@synthesize tableView = _tableView;
@synthesize searchBar = _searchBar;

- (void)addPlayer:(NSString *)aName withId:(NSString *)bnetid {
    
    DLPlayerInfo *player = [[DLPlayerInfo alloc] init];
    player.name = aName;
    player.bnet_id = bnetid;
    [players addObject:player];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setSearchBar:nil];
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DLPlayerInfo *player = [players objectAtIndex:indexPath.row];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://sc2ranks.com/us/%@/%@", player.bnet_id, player.name];
    NSURL *url = [NSURL URLWithString:urlStr];
    DLWebView *webView = [[DLWebView alloc] initWithUrl:url];
    [self presentModalViewController:webView animated:YES];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [players count];    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    DLPlayerInfo *playerId = [players objectAtIndex:indexPath.row];
    cell.textLabel.text = playerId.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", playerId.bnet_id];
    
    return cell;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    NSString *text = searchBar.text;
    [_searchBar resignFirstResponder];
    
    NSString *urlString = [NSString stringWithFormat:@"http://sc2ranks.com/api/search/exact/us/%@.json?appKey=google.com", text];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [DLSc2RanksService getPlayersByNameWithRequest:request onSuccess:^(NSMutableArray *array) {
        
        players = array;
        [_tableView reloadData];
        
    } onFailure:^(NSString *errorMessage) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Communication error" 
                                                            message:errorMessage 
                                                           delegate:self 
                                                  cancelButtonTitle:@"OK" 
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
}

@end
