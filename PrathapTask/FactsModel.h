//
//  FactsModel.h
//  PrathapTask
//
//  Created by test on 7/25/16.
//  Copyright © 2016 Wipro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FactsModel : NSObject

@property(nonatomic,strong)NSString *factTitle;
@property(nonatomic,strong)NSString *factDescription;
@property(nonatomic,strong)NSString *factImageUrl;
-(FactsModel*)returnFactsModelWithData:(NSDictionary*)receivedData;

@end
