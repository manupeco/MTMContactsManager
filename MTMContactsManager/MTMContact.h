//
//  MTMContact.h
//  MTMContactsManager
//
//  Created by Emanuele on 18/11/2014.
//  Copyright (c) 2014 manupeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTMContact : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;

@property (strong, nonatomic) NSArray *phones;
@property (strong, nonatomic) NSArray *emails;

@end
