//
//  Program.h
//  msse652
//
//  Created by Christopher Howell on 7/31/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Program : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;

@end
