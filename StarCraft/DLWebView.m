//
//  DLWebView.m
//  StarCraft
//
//  Created by Mark Wilkinson on 8/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DLWebView.h"

@implementation DLWebView {
    
    NSURL *urlForPlayer;
}
@synthesize navBar = _navBar;
@synthesize navItem = _navItem;
@synthesize webView = _webView;

- (id)initWithUrl:(NSURL *)url {
    
    if (self = [super init]) {
        urlForPlayer = url;
    }
    return self;
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
    // Do any additional setup after loading the view from its nib.
    _navItem.title = @"Sc2 Ranks";
    NSURLRequest *request = [NSURLRequest requestWithURL:urlForPlayer];
    [_webView loadRequest:request];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [self setNavBar:nil];
    [self setNavItem:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)done:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}
@end
