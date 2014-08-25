//
//  SecondViewController.m
//  msse652
//
//  Created by Christopher Howell on 7/5/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import "SecondViewController.h"

#import "SRWebSocket.h"

@interface SecondViewController () <SRWebSocketDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) NSMutableArray *messages;
@end

@implementation SecondViewController

SRWebSocket *_webSocket;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _messages = [NSMutableArray new];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)createConnection {
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://regisscis:8080/chat"]]];
    _webSocket.delegate = self;
    
    self.title = @"Opening socket connection...";
    [_webSocket open];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"Websocket Connected");
    self.title = @"Connected";
}

-(void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@"Websocket FAILED with error: %@", error);
    self.title = @"Connection Failed";
    _webSocket = nil;
}

- (void)webSocket:(SRWebSocket *) didReceiveMessage:(id)message {
    NSLog(@"Received msg: %@", message);
    
    NSString *msg = (NSString *)message;
    
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"WebSocket closed");
    self.title = @"Connection Closed";
    _webSocket = nil;
}

-(void)sendMessage:(NSString *)message {
    [_webSocket send:message];
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
