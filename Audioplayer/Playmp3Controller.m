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
@interface Playmp3Controller ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)AVAudioPlayer *audioPlayer;
@property (nonatomic,retain)AVPlayerItem *playerItem;
@property (nonatomic,retain)AVPlayer *mp3Player;
@property (nonatomic,retain)UISlider *slider;
@property (nonatomic,retain)NSMutableData *mp3data;
@property (nonatomic,retain)NSTimer *timer;
@property (nonatomic,retain)UIScrollView *scrollView;
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,assign)NSInteger currentRow;
@end

@implementation Playmp3Controller
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
//-(NSTimer *)timer{
//    if(!_timer){
//
//    }
//    return _timer;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.navigationItem.title = _data.name;
    self.navigationItem.leftBarButtonItem =[[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)]autorelease];
    [self layoutView];
//    [self request];
    NSURL *videoUrl = [NSURL URLWithString:_data.mp3Url];
    self.playerItem = [AVPlayerItem playerItemWithURL:videoUrl];
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    self.mp3Player = [AVPlayer playerWithPlayerItem:self.playerItem];
        [self.tableView reloadData];
//[self. mp3Player setAllowsExternalPlayback:YES];
}
-(void)back{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        if (AVPlayerItemStatusReadyToPlay == self.mp3Player.currentItem.status)
        {
            [self.mp3Player play];
            _timer =[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(uptimer) userInfo:nil repeats:true];
            _currentRow = 0;
            _slider.maximumValue = self.playerItem.duration.value/self.playerItem.duration.timescale;
//            NSLog(@"%f",_slider.maximumValue);
        }
    }
    
}

-(void)uptimer{
    float time =self.mp3Player.currentTime.value/self.mp3Player.currentTime.timescale;
//    NSLog(@"%f",time);
    _slider.value =time;
    _currentRow=time;
    NSLog(@"%ld",_currentRow);
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:_currentRow inSection:0]
     
                                animated:YES
     
                          scrollPosition:UITableViewScrollPositionMiddle];
}

-(void)layoutView{
    _scrollView = [[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/3*2+64)]autorelease];
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width*2, self.view.frame.size.height/3*2-64);
    _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
     _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    [self layoutScrollViewpic];
    [self layoutScrollViewric];
    _slider =[[UISlider alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/3*2+74, self.view.frame.size.width, 30)];
    _slider.minimumValue = 0;
    [_slider addTarget:self action:@selector(upslider) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
    
}
-(void)upslider{
    int timescale =self.mp3Player.currentTime.timescale;
    int value = _slider.value*timescale;
    CMTime currentTime =CMTimeMake(value, timescale);
    [self.playerItem seekToTime:currentTime];
    
//    [self.tableView reloadData];
    
}

-(void)layoutScrollViewpic{
    //添加背景
    UIImageView *picback=[[[UIImageView alloc]initWithFrame:self.scrollView.bounds]autorelease];;
    [picback sd_setImageWithURL:[NSURL URLWithString:_data.blurPicUrl]];
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
    [_scrollView addSubview:picback];
}
-(void)layoutScrollViewric{
    _tableView =[[[UITableView alloc]initWithFrame:CGRectMake(self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)]autorelease];
    _tableView.dataSource =self;
    _tableView.delegate =self;
    [_scrollView addSubview:_tableView];

//    NSLog(@"%@",_data.lyrics);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return _data.lyrics.count+5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //设置 重用标识符
//    static NSString *identifier = @"ID";
    
    //先到重用队列去取 cell
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    //判定
//    if(cell == nil){
        //没有获取 就创建cell
      UITableViewCell*  cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//    }
//    NSLog(@"--%ld",indexPath.row);
    if (indexPath.row>4) {
//        NSString *lyric = [_data.lyrics[indexPath.row] valueForKey:@"lyric"];
        cell.textLabel.text =_data.lyrics[indexPath.row];
    }

    if (indexPath.row ==5) {
        cell.textLabel.textColor = [UIColor redColor];
    }else{
        cell.textLabel.textColor = [UIColor blackColor];
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
