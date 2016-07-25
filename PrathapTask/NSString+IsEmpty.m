//
//  NSString+IsEmpty.m
//  PrathapTask
//
//  Created by test on 7/25/16.
//  Copyright © 2016 Wipro. All rights reserved.
//

#import "NSString+IsEmpty.h"

@implementation NSString (IsEmpty)

-(NSString *) isEmpty
{
    if (self.length==0)
    {
        return @"";
    }
    else
    {
        return self;
    }
}

@end
