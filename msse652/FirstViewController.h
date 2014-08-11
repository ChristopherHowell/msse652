//
//  FirstViewController.h
//  msse652
//
//  Created by Christopher Howell on 7/5/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface FirstViewController : UIViewController

// post to Facebook
- (IBAction)shareFacebook:(id)sender;

// post to Twitter
- (IBAction)shareTwitter:(id)sender;

// unwind the segue
- (IBAction)exitHere:(UIStoryboardSegue *)sender;

@end
