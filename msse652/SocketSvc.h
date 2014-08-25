//
//  SocketSvc.h
//  msse652
//
//  Created by Christopher Howell on 8/24/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SocketSvc : NSObject

- (void) connect;
- (void) send:(NSString *) msg;
- (NSString *) retrieve;
- (void) disconnect;
- (void)updateMessage:(NSString *) msg;

@end
