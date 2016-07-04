//
//  GJBasicAnimationViewController.m
//  AnimationDemo
//
//  Created by Guangyao on 16/5/5.
//  Copyright © 2016年 Guangyao. All rights reserved.
//


// reference :http://www.cnblogs.com/wengzilin/p/4250957.html



#import "GJBasicAnimationViewController.h"
#import "GJBasicAnimationItem.h"

@interface GJBasicAnimationViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak) UIView *displayView;

@property (nonatomic,weak) UIView *animationView;

@property (nonatomic,weak) UITableView *animationListTableView;

@property (nonatomic,strong) NSArray *animationItems;

@property (nonatomic,strong) CALayer *animationLayer;

@end

@implementation GJBasicAnimationViewController


#pragma mark - vc life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"Basic Animation";

    
    
    
    
    [self.animationView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(64);
        make.height.equalTo(@300);
        
    }];
    
    [self.animationListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.animationView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)groupLayer
{
    
    
    //设定剧本
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.5];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.duration = 0.8;
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:self.animationLayer.position];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(320 - 80,
                                                                  self.animationLayer.position.y)];
    moveAnimation.autoreverses = YES;
    moveAnimation.repeatCount = MAXFLOAT;
    moveAnimation.duration = 2;
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:6.0 * M_PI];
    rotateAnimation.autoreverses = YES;
    rotateAnimation.repeatCount = MAXFLOAT;
    rotateAnimation.duration = 2;
    
    CAAnimationGroup *groupAnnimation = [CAAnimationGroup animation];
    groupAnnimation.duration = 2;
    groupAnnimation.autoreverses = YES;
    groupAnnimation.animations = @[moveAnimation, scaleAnimation, rotateAnimation];
    groupAnnimation.repeatCount = MAXFLOAT;
    //开演
    [self.animationLayer addAnimation:groupAnnimation forKey:@"groupAnnimation"];
}

- (void)transformScale
{
  
    //设定剧本
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.5];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.duration = 0.8;
    
    [self.animationLayer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
 
}


-(void)tranformX{

    
    //设定剧本
    CABasicAnimation *xAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    xAnimation.fromValue = [NSNumber numberWithFloat:60];
    xAnimation.toValue = [NSNumber numberWithFloat:100];
    xAnimation.autoreverses = YES;
    xAnimation.fillMode = kCAFillModeForwards;
    xAnimation.repeatCount = MAXFLOAT;
    xAnimation.duration = 0.8;
    
    //开演
    [self.animationLayer addAnimation:xAnimation forKey:@"xAnimation"];

}

#pragma mark - data getter
-(NSArray *)animationItems{
    if (!_animationItems) {
        GJBasicAnimationItem *scaleAnimationItem=[[GJBasicAnimationItem alloc]init];
        scaleAnimationItem.animationName=@"transform scale";
        scaleAnimationItem.animationSEL=@selector(transformScale);
        
        GJBasicAnimationItem *xAnimationItem=[[GJBasicAnimationItem alloc]init];
        xAnimationItem.animationName=@"transform x";
        xAnimationItem.animationSEL=@selector(tranformX);
        
        GJBasicAnimationItem *groupAnimationItem=[[GJBasicAnimationItem alloc]init];
        groupAnimationItem.animationName=@"groupAnimation ";
        groupAnimationItem.animationSEL=@selector(groupLayer);
        
        
        
        
        _animationItems=@[scaleAnimationItem,xAnimationItem,groupAnimationItem];
    }
    return _animationItems;

}

#pragma mark - view getter


-(CALayer *)animationLayer{
    if (!_animationLayer) {
        
        CALayer *scaleLayer = [[CALayer alloc] init];
        scaleLayer.backgroundColor = [UIColor blueColor].CGColor;
        scaleLayer.frame = CGRectMake(60, 20 + 50, 50, 50);
        scaleLayer.cornerRadius = 10;
        [self.animationView.layer addSublayer:scaleLayer];
        _animationLayer=scaleLayer;
        
    }
    return _animationLayer;

}
-(UITableView *)animationListTableView{
    if (!_animationListTableView) {
        UITableView *tableView=[[UITableView alloc]init];
        tableView.dataSource=self;
        tableView.delegate=self;
        [self.view addSubview:tableView];
        _animationListTableView=tableView;
    }
    
    return _animationListTableView;

}


-(UIView *)animationView{
    if (!_animationView) {
        
        UIView *animationView=[[UIView alloc]init];
        animationView.backgroundColor=[UIColor greenColor];
        [self.view addSubview:animationView];
        
        _animationView=animationView;
    }
    return _animationView;

}

#pragma mark - table view datasource 

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.animationItems.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"BasicAnimationTableViewCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    GJBasicAnimationItem *animationItem=self.animationItems[indexPath.row];
    
    cell.textLabel.text=animationItem.animationName;
    
    return cell;
    
}

#pragma mark - table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    GJBasicAnimationItem *animationItem=self.animationItems[indexPath.row];
    
    
    [self.animationLayer removeAllAnimations];
    
    if([self respondsToSelector:animationItem.animationSEL]){
        [self performSelector:animationItem.animationSEL];
    }


}
+(NSString *)classDescription{

    return @"Basic Animation";

}


@end
