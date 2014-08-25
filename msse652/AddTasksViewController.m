//
//  AddTasksViewController.m
//  msse652
//
//  Created by Christopher Howell on 8/24/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import "AddTasksViewController.h"

@interface AddTasksViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textViewNote;


@end

@implementation AddTasksViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

// used to save task note to iCloud
- (IBAction)saveTask:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"New Note" object:self userInfo:[NSDictionary dictionaryWithObject:self.textViewNote.text  forKey:@"Note"]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
