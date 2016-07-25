//
//  CustemTableViewCell.h
//  PrathapTask
//
//  Created by test on 7/25/16.
//  Copyright © 2016 Wipro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustemTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIImageView *rowImageView;

@property (assign) BOOL isConstraintsUpdated ;

@end
