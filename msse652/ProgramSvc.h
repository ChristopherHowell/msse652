//
//  ProgramSvc.h
//  msse652
//
//  Created by Christopher Howell on 7/14/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Program.h"

@protocol ProgramSvc <NSObject>

- (NSArray *) retrieveAllPrograms;
- (void) downloadPrograms:(UITableView *)tableView;

@end
