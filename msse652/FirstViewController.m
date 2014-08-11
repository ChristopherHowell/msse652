//
//  FirstViewController.m
//  msse652
//
//  Created by Christopher Howell on 7/5/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

// unwind the segue
- (IBAction)exitHere:(UIStoryboardSegue *)sender {
    
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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// post to Facebook
- (IBAction)shareFacebook:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *view = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [self presentViewController:view animated:YES completion:nil];
    } else {
        NSLog(@"Facebook Share Failed");
    }
}

// post to Twitter
- (IBAction)shareTwitter:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *view = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [self presentViewController:view animated:YES completion:nil];
    } else {
        NSLog(@"Twitter Share Failed");
    }
}
@end
