//
//  DLSc2RanksService.h
//  StarCraft
//
//  Created by Mark Wilkinson on 8/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLSc2RanksService : NSObject

+ (void)getPlayersByNameWithRequest:(NSURLRequest *)request onSuccess:(void(^)(NSMutableArray *array))success onFailure:(void(^)(NSString *errorMessage))failure;

@end
