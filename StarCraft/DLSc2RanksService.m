//
//  DLSc2RanksService.m
//  StarCraft
//
//  Created by Mark Wilkinson on 8/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DLSc2RanksService.h"
#import "AFNetworking.h"
#import "DLPlayerInfo.h"

@implementation DLSc2RanksService

+ (void)getPlayersByNameWithRequest:(NSURLRequest *)request onSuccess:(void (^)(NSMutableArray *))success onFailure:(void (^)(NSString *))failure {
    
    NSMutableArray *arrayToReturn = [NSMutableArray array];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id jsonObject) {
        
        // block for when success happens
        NSArray *charactersArray = [jsonObject valueForKey:@"characters"];
        
        for (NSDictionary *d in charactersArray) {
            NSString *bnet_id = [d objectForKey:@"bnet_id"];
            NSString *name = [d objectForKey:@"name"];
            
            DLPlayerInfo *player = [[DLPlayerInfo alloc] init];
            player.name = name;
            player.bnet_id = bnet_id;
            player.imgUrl = @"http://sc2ranks.com/images/logo_tiny.png?1300844056";
            [arrayToReturn addObject:player];
        }
        
        success(arrayToReturn);
                
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        // block for when failure occurs
        
        failure([NSString stringWithFormat:@"%@", [error description]]);
    }];
    
    [operation start];
}
@end
