//
//  AFNetworkingSvc.m
//  msse652
//
//  Created by Christopher Howell on 7/26/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import "AFNetworkingSvc.h"
#import "AFNetworking.h"

@implementation AFNetworkingSvc


// create programs array, connect to server, and download programs data
- (void) downloadPrograms:(UITableView *)tableView {
    
    self.programs = [NSMutableArray new];
    NSURL *url = [NSURL URLWithString:@"http://regisscis.net/Regis2/webresources/regis2.program"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject: %@", responseObject);
        NSArray *jsonData = responseObject;
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
        [tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error with request" message: [NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
    }];
    
    [operation start];
}

// retrieve programs array which contains all programs captured during connection
- (NSArray *) retrieveAllPrograms {
    return self.programs;
}


@end
