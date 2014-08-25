//
//  SocketSvc.m
//  msse652
//
//  Created by Christopher Howell on 8/24/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import "SocketSvc.h"

@implementation SocketSvc

NSInputStream *inputStream;
NSOutputStream *outputStream;

- (void) connect {
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"www.regisscis.net", 8080, &readStream, &writeStream);
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = (__bridge NSOutputStream *)(writeStream);
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    [outputStream open];
}

- (void) send:(NSString *) msg {
    NSData *data = [[NSData alloc] initWithData:[msg dataUsingEncoding:NSASCIIStringEncoding]];
    
    [outputStream write:[data bytes] maxLength:[data length]];
}

- (NSString *) retrieve {
    NSMutableString *msg;
    uint8_t buffer[1024];
    int len = 0;
    while ([inputStream hasBytesAvailable]) {
        len = [inputStream read:buffer maxLength:sizeof(buffer)];
        if (len > 0) {
            NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
            if (output != nil) {
                [msg appendString:output];
            }
        }
    }
    return msg;
}

- (void) disconnect {
    [inputStream close];
    [outputStream close];
    [inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream setDelegate:nil];
    [outputStream setDelegate:nil];
    inputStream = nil;
    outputStream = nil;
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
    switch (eventCode) {
        case NSStreamEventOpenCompleted:
            NSLog(@"Stream Opened");
            break;
        case NSStreamEventHasBytesAvailable:
            NSLog(@"Stream has bytes");
            
            
        default:
            break;
    }
}

@end
