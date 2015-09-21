//
//  Mp3ViewController.m
//  Audioplayer
//
//  Created by XXT on 15/9/21.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "Mp3ViewController.h"
#import "Mp3Data.h"
#import "MusicCell.h"
#import "UIImageView+WebCache.h"
#import "Playmp3Controller.h"
@interface Mp3ViewController ()
@property (nonatomic,retain)NSMutableArray *mp3arr;
@end

@implementation Mp3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}
-(void)loadData{
    self.mp3arr =[NSMutableArray array];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MusicInfoList" ofType:@"plist"];
    NSArray *dataarr= [NSArray arrayWithContentsOfFile:plistPath];
    for (NSDictionary *data in dataarr) {
        Mp3Data *mp=[[Mp3Data alloc]init];
        [mp setValuesForKeysWithDictionary:data];
        [self.mp3arr addObject:mp];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _mp3arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    Mp3Data *data =self.mp3arr[indexPath.row];
    cell.name.text =data.name;
    cell.singer.text =data.singer;
    [cell.picimg sd_setImageWithURL:[NSURL URLWithString:data.picUrl] placeholderImage:[UIImage imageNamed:@"picholder.png"]];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     Mp3Data *data =self.mp3arr[indexPath.row];

    Playmp3Controller *playmp3= [[Playmp3Controller alloc]init];
    playmp3.data =data;
    UINavigationController *playmp3nv =[[UINavigationController alloc]initWithRootViewController:playmp3];
    [self presentViewController:playmp3nv animated:YES completion:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
