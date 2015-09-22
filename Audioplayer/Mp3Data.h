//
//  Mp3Data.h
//  Audioplayer
//
//  Created by XXT on 15/9/21.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mp3Data : NSObject
@property (nonatomic,copy)NSString *mp3Url;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *picUrl;
@property (nonatomic,copy)NSString *blurPicUrl;
@property (nonatomic,copy)NSString *album;
@property (nonatomic,copy)NSString *singer;
@property (nonatomic,copy)NSString *duration;
@property (nonatomic,copy)NSString *artists_name;
//@property (nonatomic,retain)NSMutableArray *lyrics;
@property (nonatomic,retain)NSArray *lyrics;
@end
