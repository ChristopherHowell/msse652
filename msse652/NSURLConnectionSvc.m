//
//  NSURLConnectionSvc.m
//  msse652
//
//  Created by Christopher Howell on 7/14/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import "NSURLConnectionSvc.h"

@implementation NSURLConnectionSvc

NSMutableData *_responseData;

// called when a connection is made, then initializes responseData
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _responseData = [NSMutableData new];
}

// places received data in responseData
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}

// return nil to indicate a cached response is not necessary
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;
}

// parses the JSON data in responseData
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    // BOOL value added to loop run loop in an attempt to give enough time to receive response
    _finished = TRUE;
    
    NSError *error;
    NSArray *jsonData = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&error];
    NSLog(@"JSON: %@", jsonData);
    
    // iterate through jsonData and create a program object
    for (int i=0; i<jsonData.count; i++) {
        NSLog(@"string: %@", jsonData[i]);
        Program *program = [[Program alloc] init];
        NSDictionary *pgm = jsonData[i];
        
        // place jsonData in program object
        for (id key in pgm) {
            id value = [pgm objectForKey:key];
            NSLog(@"key: %@, value: %@", key, value);
            program.programId = [pgm objectForKey:@"id"];
            program.programName = [pgm objectForKey:@"name"];
        }
        
        // add program objects to the programs array
        [self.programs addObject:program];
    }
}

// catch exception if connection fails
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"error: %@", error);
}

// create programs array, connect to server, and download programs data
- (void) downloadPrograms:(UITableView *)tableView {
    
    // BOOL value added to loop run loop in an attempt to give enough time to receive response
    _finished = FALSE;
    
    self.programs = [NSMutableArray new];
    NSURL *url = [NSURL URLWithString:@"http://regisscis.net/Regis2/webresources/regis2.program"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    
    // run loop request to run in main run loop in an attempt to receive a connection response
    [connection scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [connection start];
    
    // loop to give extra time in an attempt to receive connection response
    while (!_finished) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

// retrieve programs array which contains all programs captured during connection
- (NSArray *) retrieveAllPrograms {
    return self.programs;
}

@end
