//
//  ThrowLineAnimationViewController.m
//  AnimationDemo
//
//  Created by Guangyao on 16/5/6.
//  Copyright © 2016年 Guangyao. All rights reserved.
//

#import "ThrowLineAnimationViewController.h"
#import "ThrowLineTool.h"


@interface ThrowLineAnimationViewController ()
<ThrowLineToolDelegate>



@end

@implementation ThrowLineAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    imageView.backgroundColor=[UIColor redColor];
    imageView.tag=1000;
    [self.view addSubview:imageView];
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
        UIImageView *bagImgView = (UIImageView *)[self.view viewWithTag:1000];
    [self bezierPath];

}

- (void)beginThrowing:(UIView *)view
{
    ThrowLineTool *tool = [ThrowLineTool sharedTool];
    tool.delegate = self;
    UIImageView *bagImgView = (UIImageView *)[self.view viewWithTag:1000];
    CGFloat startX = 0;//arc4random() % (NSInteger)CGRectGetWidth(self.frame);
    CGFloat startY = 150;//CGRectGetHeight(self.frame);
    CGFloat endX = CGRectGetMidX(bagImgView.frame) + 10 - (arc4random() % 50);
    CGFloat endY = CGRectGetMidY(bagImgView.frame);
    CGFloat height = 50 + arc4random() % 40;
    [tool throwObject:view
                 from:CGPointMake(startX, startY)
                   to:CGPointMake(endX, endY)
               height:height duration:16];
}

-(void)bezierPath{
    
     UIImageView *bagImgView = (UIImageView *)[self.view viewWithTag:1000];
    
    [bagImgView.layer removeAllAnimations];
    //路径曲线controlPoint为基准点
    UIBezierPath * movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:CGPointMake(0, 0)];
    CGPoint toPoint = CGPointMake(300, 460);
    [movePath addQuadCurveToPoint:toPoint controlPoint:CGPointMake(300, 0)];
    CAKeyframeAnimation * moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        moveAnimation.path = movePath.CGPath;
    moveAnimation.values = @[[NSValue valueWithCGPoint:CGPointMake(100, 100)],[NSValue valueWithCGPoint:CGPointMake(100, 300)],[NSValue valueWithCGPoint:CGPointMake(300, 300)],[NSValue valueWithCGPoint:CGPointMake(300, 100)]];
    moveAnimation.removedOnCompletion = YES;
    
    
    //缩放变化
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    scaleAnimation.removedOnCompletion = YES;
    
        //透明度变化
        CABasicAnimation * opacityAnimation = [CABasicAnimation animationWithKeyPath:@"alpha"];
        opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        opacityAnimation.toValue = [NSNumber numberWithFloat:0.1];
        opacityAnimation.removedOnCompletion = YES;
    
    //旋转
    CABasicAnimation * tranformAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    tranformAnimation.fromValue = [NSNumber numberWithFloat:0.f];
    tranformAnimation.toValue = [NSNumber numberWithFloat:M_PI];
    tranformAnimation.cumulative = YES;
    tranformAnimation.removedOnCompletion = YES;
    
    CAAnimationGroup*animaGroup = [CAAnimationGroup animation];
    animaGroup.animations = @[moveAnimation,scaleAnimation,tranformAnimation,opacityAnimation];
    animaGroup.duration = 2.f;
    animaGroup.autoreverses=NO;
    
    [bagImgView.layer addAnimation:animaGroup forKey:@"animaGroup"];
    

}

/**
 *  抛物线结束的回调
 */
- (void)animationDidFinish{

    NSLog(@"end of animation");
    

}


@end
