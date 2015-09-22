//
//  Mp3Data.m
//  Audioplayer
//
//  Created by XXT on 15/9/21.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "Mp3Data.h"

@implementation Mp3Data

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID =value;
    }
    if ([key isEqualToString:@"lyric"]) {
        self.lyrics =[value componentsSeparatedByString:@"\n"];
//        self.lyrics =[[NSMutableArray alloc]init];
//        for (NSString *str in arr) {
//             NSString *time =nil;
//            if (str.length >0) {
//              time =[str substringWithRange:NSMakeRange(1,8)];
//            }
//            NSString *lyric =nil;
//            if (str.length>11) {
//               lyric =[str substringFromIndex:10];
//            }
//            NSLog(@"%@",time);
//
////            NSString *lyric =arr[1];
//            NSLog(@"%@",lyric);
//            NSDictionary *dic =[[NSDictionary alloc]initWithObjectsAndKeys:time,@"time",lyric,@"lyric", nil];
////            NSLog(@"%@",dic);
//            [self.lyrics addObject:dic];
//        }
        
    }
}
@end
