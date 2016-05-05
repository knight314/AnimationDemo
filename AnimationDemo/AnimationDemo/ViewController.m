//
//  ViewController.m
//  AnimationDemo
//
//  Created by Guangyao on 16/5/5.
//  Copyright © 2016年 Guangyao. All rights reserved.
//

#import "ViewController.h"

#import "GJBasicAnimationViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *mainTableView;

@property (nonatomic,strong) NSArray *destinationClasses;

@end

@implementation ViewController


#pragma mark - vc life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.mainTableView.frame=self.view.bounds;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - view getter

-(UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView=[[UITableView alloc]init];
        _mainTableView.dataSource=self;
        _mainTableView.delegate=self;
        [self.view addSubview:_mainTableView];
    }
    return _mainTableView;

}


#pragma mark - data getter

-(NSArray *)destinationClasses{

    if (!_destinationClasses) {
        _destinationClasses=@[[GJBasicAnimationViewController class]];
    }
    return _destinationClasses;

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.destinationClasses.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier=@"DestinationClassCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    Class class=self.destinationClasses[indexPath.row];
    UIViewController *destinationVC=[[class alloc]init];
    
    if (destinationVC.title) {
        cell.textLabel.text=destinationVC.title;
    }
    return cell;
}

#pragma mark - table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"cell");
    Class class=self.destinationClasses[indexPath.row];
    UIViewController *destinationVC=[[class alloc]init];
    if (destinationVC) {
        [self.navigationController pushViewController:destinationVC animated:YES];
    }

}

@end
