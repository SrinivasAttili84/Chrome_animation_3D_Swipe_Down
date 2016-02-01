//
//  ViewController.m
//  Drawing3D
//
//  Created by Rakesh on 1/5/16.
//  Copyright © 2016 PTG. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIView *vw1;
    UIView *vw2;
    UIView *vw3;
    UIView *vw4;
    UIView *vw5;
    NSMutableArray *vwArray;
    BOOL animationFlag;
    NSMutableArray *temp;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    
    animationFlag = NO;
    
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    gestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:gestureRecognizer];
    
    UIButton *back1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 30)];
    back1.backgroundColor = [UIColor purpleColor];
    back1.tag = 0;
    back1.layer.borderColor = [UIColor grayColor].CGColor;
    back1.layer.borderWidth = 2;
    [back1 addTarget:self action:@selector(backToAnimation:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *back2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 30)];
    back2.backgroundColor = [UIColor orangeColor];
    back2.tag = 1;
    back2.layer.borderColor = [UIColor grayColor].CGColor;
    back2.layer.borderWidth = 2;
    [back2 addTarget:self action:@selector(backToAnimation:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *back3 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 30)];
    back3.backgroundColor = [UIColor greenColor];
    back3.tag = 2;
    back3.layer.borderColor = [UIColor grayColor].CGColor;
    back3.layer.borderWidth = 2;
    [back3 addTarget:self action:@selector(backToAnimation:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *back4 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 30)];
    back4.backgroundColor = [UIColor redColor];
    back4.tag = 3;
    back4.layer.borderColor = [UIColor grayColor].CGColor;
    back4.layer.borderWidth = 2;
    [back4 addTarget:self action:@selector(backToAnimation:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *back5 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 30)];
    back5.backgroundColor = [UIColor whiteColor];
    back5.tag = 4;
    back5.layer.borderColor = [UIColor grayColor].CGColor;
    back5.layer.borderWidth = 2;
    [back5 addTarget:self action:@selector(backToAnimation:) forControlEvents:UIControlEventTouchUpInside];
    
    
    vw1 = [[UIView alloc]initWithFrame:CGRectMake(50, 50, self.view.frame.size.width-100, 250)];
    vw1.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:vw1];
    [vw1 addSubview:back1];
    
    vw2 = [[UIView alloc]initWithFrame:CGRectMake(50, 80, self.view.frame.size.width-100, 250)];
    vw2.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:vw2];
    [vw2 addSubview:back2];

    
    vw3 = [[UIView alloc]initWithFrame:CGRectMake(50, 110, self.view.frame.size.width-100, 250)];
    vw3.backgroundColor = [UIColor greenColor];
    [self.view addSubview:vw3];
    [vw3 addSubview:back3];

    
    vw4 = [[UIView alloc]initWithFrame:CGRectMake(50, 140, self.view.frame.size.width-100, 250)];
    vw4.backgroundColor = [UIColor redColor];
    [self.view addSubview:vw4];
    [vw4 addSubview:back4];

    
    vw5 = [[UIView alloc]initWithFrame:CGRectMake(50, 170, self.view.frame.size.width-100, 250)];
    vw5.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vw5];
    [vw5 addSubview:back5];

    vwArray = [[NSMutableArray alloc]initWithObjects:vw1,vw2,vw3,vw4,vw5, nil];
    //frameArray = [[NSMutableArray alloc]initWithObjects:@"50",@"80",@"110",@"140",@"170", nil];
    temp = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backToAnimation:(UIButton *)button
{
    if (animationFlag == YES)
    {
        NSMutableArray *frameArray = [[NSMutableArray alloc]initWithObjects:@"50",@"80",@"110",@"140",@"170", nil];
        NSMutableArray *frontView = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
        [self shiftArrayRight:frameArray shift:button.tag+1];
        [self shiftArrayRight:frontView shift:button.tag+1];
        
        temp = frontView;
        
        [UIView animateWithDuration:0.5 animations:^{
            for (int i =0; i<[frameArray count]; i++)
            {
                UIView *finalView = [vwArray objectAtIndex:i];
                finalView.frame = CGRectMake(50, [[frameArray objectAtIndex:i] floatValue], self.view.frame.size.width-100, 250);
                [self stopAnimation:finalView];
                finalView.alpha = 1;
                finalView.layer.zPosition =[[frontView objectAtIndex:i] floatValue];
            }
        } completion:^(BOOL finished) {
        }];
        animationFlag = NO;
    }
}

-(void)shiftArrayRight:(NSMutableArray *)mutableArray shift:(NSUInteger)shift
{
    for (NSUInteger i = shift; i > 0; i--) {
        NSObject *obj = [mutableArray lastObject];
        [mutableArray insertObject:obj atIndex:0];
        [mutableArray removeLastObject];
    }
}

-(void)swipeHandler:(UISwipeGestureRecognizer *)recognizer {
    [UIView animateWithDuration:0.5 animations:^{
        for (int i=0; i<5; i++)
        {
            UIView *v = [vwArray objectAtIndex:i];
            v.frame = CGRectMake(50, 10+(60*[[temp objectAtIndex:i] floatValue]), self.view.frame.size.width-100, 250);
            [self startAnimation:v];
            v.alpha = 0.8;
            NSLog(@"%f",v.frame.origin.y);
        }
    } completion:^(BOOL finished) {
    }];
    animationFlag = YES;
}

-(void)startAnimation:(UIView*)vw
{
    CATransform3D t = CATransform3DIdentity;
    //Add the perspective!!!
    t.m34 = 1.0/ -500;
    t = CATransform3DRotate(t, 60 * M_PI / 180.0f, -1, 0, 0);
    vw.layer.transform = t;
}
-(void)stopAnimation:(UIView*)vw
{
    CATransform3D t = CATransform3DIdentity;
    //Add the perspective!!!
    t.m34 = 1.0/ -500;
    t = CATransform3DRotate(t, 0 * M_PI / 180.0f, -1, 0, 0);
    vw.layer.transform = t;
}
@end
