//
//  FactsUtility.h
//  PrathapTask
//
//  Created by test on 7/25/16.
//  Copyright © 2016 Wipro. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol FactsDelegate  <NSObject>

-(void) reloadTableViewWithFactsData:(NSDictionary *)dataDictionary ;

@end

@interface FactsUtility : NSObject

@property (weak,nonatomic) id <FactsDelegate> delegate ;

-(void) getFactsData;

@end
