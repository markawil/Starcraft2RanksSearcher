//
//  DLWebView.h
//  StarCraft
//
//  Created by Mark Wilkinson on 8/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLWebView : UIViewController

- (id)initWithUrl:(NSURL *)url;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;

- (IBAction)done:(id)sender;
@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@end
