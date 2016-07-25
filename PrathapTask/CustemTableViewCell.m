//
//  CustemTableViewCell.m
//  PrathapTask
//
//  Created by test on 7/25/16.
//  Copyright © 2016 Wipro. All rights reserved.
//

#import "CustemTableViewCell.h"

@implementation CustemTableViewCell
@synthesize titleLabel,descriptionLabel,rowImageView;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initTitleLabel];
        [self initDescriptionLabel];
        [self initRowImageView];
    }
    
    return self ;
}

-(void) initTitleLabel
{
    titleLabel  = [[UILabel alloc] init];
    titleLabel .numberOfLines = 0;
    titleLabel .lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel .preferredMaxLayoutWidth = 1000;
    [titleLabel  setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [titleLabel  setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [titleLabel  setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.titleLabel ];
}
-(void) initDescriptionLabel
{
    descriptionLabel = [[UILabel alloc] init];
    [descriptionLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f]];
    [descriptionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [descriptionLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [descriptionLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [descriptionLabel setNumberOfLines:0];
    [descriptionLabel setTextAlignment:NSTextAlignmentLeft];
    [descriptionLabel setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:self.descriptionLabel];
}
-(void) initRowImageView
{
    rowImageView  = [[UIImageView alloc] init];
    [rowImageView  setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [rowImageView  setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [rowImageView  setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:rowImageView ];
}

- (void)updateConstraints
{
    if(!self.isConstraintsUpdated)
    {
        self.isConstraintsUpdated = YES ;
        

        NSLayoutConstraint *titleLabelTop = [NSLayoutConstraint constraintWithItem:titleLabel
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.contentView
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1
                                                                          constant:15] ;
        NSLayoutConstraint *titleLabelLeading = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                             attribute:NSLayoutAttributeLeading
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.contentView
                                                                             attribute:NSLayoutAttributeLeading
                                                                            multiplier:1
                                                                              constant:15] ;
        
        [self.contentView addConstraints:[NSArray arrayWithObjects:titleLabelLeading,titleLabelTop, nil]];
        
        
        NSLayoutConstraint *rowImageViewTop = [NSLayoutConstraint constraintWithItem:rowImageView
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.titleLabel
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1
                                                                            constant:50] ;
        NSLayoutConstraint *rowImageViewCenterX = [NSLayoutConstraint constraintWithItem:self.rowImageView
                                                                               attribute:NSLayoutAttributeCenterX
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.contentView
                                                                               attribute:NSLayoutAttributeCenterX
                                                                              multiplier:1
                                                                                constant:0] ;
        
        NSLayoutConstraint *rowImageViewHeight = [NSLayoutConstraint constraintWithItem:self.rowImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:self.contentView.frame.size.width-40] ;
        
        NSLayoutConstraint *rowImageViewWidth = [NSLayoutConstraint constraintWithItem:self.rowImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:self.contentView.frame.size.width-40] ;
        [self.contentView addConstraints:[NSArray arrayWithObjects:rowImageViewTop,rowImageViewCenterX,rowImageViewHeight,rowImageViewWidth, nil]];
        
        NSLayoutConstraint *descriptionLabelTrailing = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                                    attribute:NSLayoutAttributeTrailing
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:descriptionLabel
                                                                                    attribute:NSLayoutAttributeTrailing
                                                                                   multiplier:1
                                                                                     constant:15] ;
        NSLayoutConstraint *descriptionLabelLeading = [NSLayoutConstraint constraintWithItem:self.descriptionLabel
                                                                                   attribute:NSLayoutAttributeLeading
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:self.contentView
                                                                                   attribute:NSLayoutAttributeLeading
                                                                                  multiplier:1
                                                                                    constant:15] ;
        NSLayoutConstraint *descriptionLabelTop = [NSLayoutConstraint constraintWithItem:self.descriptionLabel
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.rowImageView
                                                                               attribute:NSLayoutAttributeBottom
                                                                              multiplier:1
                                                                                constant:0] ;
        NSLayoutConstraint *descriptionLabelBottom = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                                  attribute:NSLayoutAttributeBottom
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:descriptionLabel
                                                                                  attribute:NSLayoutAttributeBottom
                                                                                 multiplier:1
                                                                                   constant:15] ;
        [self.contentView addConstraints:[NSArray arrayWithObjects:descriptionLabelTrailing,descriptionLabelLeading,descriptionLabelTop,descriptionLabelBottom, nil]];
        

            }
    [super updateConstraints];
}

@end
