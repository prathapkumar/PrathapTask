//
//  FactsUtility.m
//  PrathapTask
//
//  Created by test on 7/25/16.
//  Copyright © 2016 Wipro. All rights reserved.
//

#import "FactsUtility.h"
#import "Reachability.h"

@implementation FactsUtility

-(void) getFactsData
{
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        NSLog(@"There IS NO internet connection");
    } else
    {
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *sessionDataTask = [session dataTaskWithURL:[NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/746330/facts.json"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                                 {
                                                     if(!error)
                                                     {
                                                         dispatch_async(dispatch_get_main_queue(), ^{
                                                             NSError *err ;
                                                             NSString *dataString = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
                                                             NSData *jsonData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
                                                             NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
                                                             if(!err)
                                                             {
                                                                 [self.delegate reloadTableViewWithFactsData:jsonDict];
                                                             }
                                                         });
                                                         
                                                     }
                                                     else
                                                     {
                                                         //Show allert
                                                     }
                                                     
                                                 }];
        
        [sessionDataTask resume];
    }
    
}



@end
