//
//  HYTimerTableViewCell.m
//  TimerCell
//
//  Created by 100lishi on 16/12/12.
//  Copyright © 2016年 whfwudi. All rights reserved.
//

#import "HYTimerTableViewCell.h"

@implementation HYTimerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1.0];
    self.countDownLabel.font = [UIFont boldSystemFontOfSize:25.0];
    self.countDownLabel.textColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
