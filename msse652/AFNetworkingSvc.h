//
//  AFNetworkingSvc.h
//  msse652
//
//  Created by Christopher Howell on 7/26/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProgramSvc.h"  

@interface AFNetworkingSvc : NSObject<ProgramSvc>

@property (strong, nonatomic) NSMutableArray *programs;

@end
