//
//  Playmp3Controller.m
//  Audioplayer
//
//  Created by XXT on 15/9/21.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "Playmp3Controller.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImageView+WebCache.h"
@interface Playmp3Controller ()<NSURLConnectionDataDelegate>
@property (nonatomic,retain)AVAudioPlayer *audioPlayer;
@property (nonatomic,retain)AVPlayerItem *playerItem;
@property (nonatomic,retain)AVPlayer *mp3Player;
@property (nonatomic,retain)UISlider *slider;
@property (nonatomic,retain)NSMutableData *mp3data;
@end

@implementation Playmp3Controller
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
//    
//    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory,
//                            
//                            sizeof(sessionCategory),
//                            
//                            &sessionCategory);
//    
//    
//    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
//    
//    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,
//                             
//                             sizeof (audioRouteOverride),
//                             
//                             &audioRouteOverride);
//    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//    
//    //默认情况下扬声器播放
//    
//    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    self.navigationItem.title = _data.name;
    self.navigationItem.leftBarButtonItem =[[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)]autorelease];
    [self layoutView];
//    [self request];
    NSURL *videoUrl = [NSURL URLWithString:_data.mp3Url];
    self.playerItem = [AVPlayerItem playerItemWithURL:videoUrl];
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    self.mp3Player = [AVPlayer playerWithPlayerItem:self.playerItem];

//[self. mp3Player setAllowsExternalPlayback:YES];
}
-(void)back{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"status"]) {
        NSLog(@"%@",change);
        if (AVPlayerItemStatusReadyToPlay == self.mp3Player.currentItem.status)
        {
            [self.mp3Player play];
//            NSLog(@"%f", self.mp3Player.currentTime);

        }
    }
}



-(void)layoutView{
    //添加背景
    UIImageView *picback=[[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height/3*2)]autorelease];;
    [picback sd_setImageWithURL:[NSURL URLWithString:_data.blurPicUrl]];
        [self.view addSubview:picback];
    //添加旋转图片
    UIImageView *imageview = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)]autorelease];
    imageview.center =CGPointMake(picback.bounds.size.width/2, picback.bounds.size.height/2);
    imageview.layer.cornerRadius = 150;
    imageview.layer.masksToBounds =YES;
    [imageview sd_setImageWithURL:[NSURL URLWithString:_data.picUrl]];
    [picback addSubview:imageview];
    //添加动画
    CABasicAnimation *picanimation = [CABasicAnimation animation];
    picanimation.keyPath = @"transform.rotation";
    picanimation.toValue = @(M_PI*100);
    picanimation.duration = 5000;
    [imageview.layer addAnimation:picanimation forKey:nil];
    
    _slider =[[UISlider alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/3*2+74, self.view.frame.size.width, 30)];
    _slider.minimumValue = 0;
    _slider.maximumValue = 500;
    [self.view addSubview:_slider];
    
}
//-(void)request{
//    //    1.创建URL对象
//    //    创建网址字符串
////    NSString *urlStr = _data.;
//    //    再编码
////    NSString *newStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    //    创建URL
//    NSURL *url =[NSURL URLWithString:_data.mp3Url];
//    //    2.创建requset
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    //    3.请求并设置代理
//    //    3.请求并设置代理
//    [NSURLConnection connectionWithRequest:request delegate:self];
//self.mp3data =[NSMutableData data];
//}
//#pragma mark -NSURLConnectionDataDelegate
////连接到服务器
//-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
//
//}
////接受数据
//-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
////    if (_mp3data ==nil) {
////        
////    }
//    //拼接数据
//    [_mp3data appendData:data];
////    [_audioPlayer prepareToPlay];
//    //    _imageView.image = [UIImage imageWithData:_data];
//    if (_audioPlayer.playing ==FALSE) {
//        NSError *error;
//        _audioPlayer=[[AVAudioPlayer alloc]initWithData:_mp3data error:&error];
//        _audioPlayer.numberOfLoops=0;
//        AVPlayerItem
//        [self.audioPlayer play];
//    }
//
//}
////数据加载完成
//-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
////    NSDictionary *newDic =[NSJSONSerialization JSONObjectWithData:_data options:0 error:nil];
////    NSLog(@"%@",newDic);
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
