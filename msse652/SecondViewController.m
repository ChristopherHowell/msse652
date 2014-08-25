//
//  SecondViewController.m
//  msse652
//
//  Created by Christopher Howell on 7/5/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import "SecondViewController.h"
#import "SocketSvc.h"

@interface SecondViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) SocketSvc *service;
@property (strong, nonatomic) NSMutableArray *messages;
@end

@implementation SecondViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _service = [SocketSvc new];
    _messages = [NSMutableArray new];
    [_service connect];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_service disconnect];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section based on number of Programs.
    return _messages.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell...
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"simpleTableIdentifier" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"simpleTableIdentifier"];
    }
    [cell.textLabel setText:[_messages objectAtIndex:indexPath.row]];
    
    return cell;
}

- (IBAction)send:(UIButton *)sender {
    NSString *messageOut = _textField.text;
    [_service send:messageOut];
    _textField.text = @"";
    [_textField resignFirstResponder];
}

- (void)updateMessage:(NSString *)msg {
    if (msg) {
        [_messages addObject:msg];
        [_tableView reloadData];
    }
}

@end
