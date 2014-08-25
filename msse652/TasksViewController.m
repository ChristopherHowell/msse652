//
//  TasksViewController.m
//  msse652
//
//  Created by Christopher Howell on 7/6/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import "TasksViewController.h"

@interface TasksViewController ()
@property (strong, nonatomic) NSMutableArray *notesArray;
@property (weak, nonatomic) IBOutlet UITextField *noteTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

@implementation TasksViewController

// create array if there is not one
- (NSMutableArray *) notesArray
{
    if (!_notesArray) {
        _notesArray = [NSMutableArray array];
    }
    return _notesArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUbiquitousKeyValueStore *store = [NSUbiquitousKeyValueStore defaultStore];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(storeDidChange:) name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification object:store];
    [[NSUbiquitousKeyValueStore defaultStore] synchronize];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didAddNewNote:) name:@"New Note" object:nil];
    self.notesArray = [NSMutableArray arrayWithArray:[store arrayForKey:@"Note"]];
    [self.tableView reloadData];
}

- (void) didAddNewNote:(NSNotification *) notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSString *noteStr = [userInfo valueForKey:@"Note"];
    [self.notesArray addObject:noteStr];
    
    // update data on the iCloud
    [[NSUbiquitousKeyValueStore defaultStore] setArray:self.notesArray forKey:@"Note"];
    
    // Reload the table view to show changes
    [self.tableView reloadData];
}

- (void)storeDidChange:(NSNotification *)notification
{
    NSUbiquitousKeyValueStore *store = [NSUbiquitousKeyValueStore defaultStore];
    self.notesArray = [NSMutableArray arrayWithArray:[store arrayForKey:@"Note"]];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.notesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell...
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"simpleTableIdentifier" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"simpleTableIdentifier"];
    }
    
    cell.textLabel.text = [self.notesArray objectAtIndex:indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.notesArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [[NSUbiquitousKeyValueStore defaultStore] setArray:self.notesArray forKey:@"Note"];
        [self.tableView reloadData];
    }
}
     
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// unwind the segue
- (IBAction)exitHere:(UIStoryboardSegue *)sender {
    
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


@end
