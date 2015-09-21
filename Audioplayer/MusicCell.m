//
//  MusicCell.m
//  Audioplayer
//
//  Created by XXT on 15/9/21.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "MusicCell.h"

@implementation MusicCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_picimg release];
    [_name release];
    [_singer release];
    [super dealloc];
}
@end
