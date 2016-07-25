//
//  FactsModel.m
//  PrathapTask
//
//  Created by test on 7/25/16.
//  Copyright © 2016 Wipro. All rights reserved.
//

#import "FactsModel.h"
#import "NSString+IsEmpty.h"

@implementation FactsModel

-(FactsModel*)returnFactsModelWithData:(NSDictionary*)receivedData
{
    if ([[receivedData valueForKey:@"title"] respondsToSelector: @selector(isEmpty)])
    {
        self.factTitle= [[receivedData valueForKey:@"title"] isEmpty];
    }
    else
    {
        self.factTitle = @"" ;
    }
    
    if ([[receivedData valueForKey:@"description"] respondsToSelector: @selector(isEmpty)])
    {
        self.factDescription=[[receivedData valueForKey:@"description"] isEmpty];
    }
    else
    {
        self.factDescription=@"";
    }
    
    if ([[receivedData valueForKey:@"imageHref"] respondsToSelector: @selector(isEmpty)])
    {
        self.factImageUrl=[[receivedData valueForKey:@"imageHref"] isEmpty];
    }
    else{
        self.factImageUrl=@"";
    }
    
    
    return self;

}

@end
