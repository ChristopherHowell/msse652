//
//  ProgramsTableViewController.h
//  msse652
//
//  Created by Christopher Howell on 7/6/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import <UIKit/UIKit.h>

// adding conformity to NSURLConnectionDelegate
@interface ProgramsTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@end
