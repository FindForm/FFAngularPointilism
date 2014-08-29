//
//  FFShutteringViewController.m
//  TriangularPointilism
//
//  Created by James Graham on 8/20/14.
//  Copyright (c) 2014 FindandForm. All rights reserved.
//

#import "FFShutteringViewController.h"

@interface FFShutteringViewController ()
@property (strong, nonatomic) NSMutableArray *arrayOfTriangleLayers;
@property (strong, nonatomic) NSArray *images;
@end

@implementation FFShutteringViewController

- (NSArray *)images{
    if (_images) {
        _images = @[[UIImage imageNamed:@"topRight"],
                    [UIImage imageNamed:@"topLeft"],
                    [UIImage imageNamed:@"bottomRight"],
                    [UIImage imageNamed:@"bottomLeft"]];
    }
    return _images;
}

- (NSMutableArray *)arrayOfTriangleLayers{
    if (!_arrayOfTriangleLayers) {
        _arrayOfTriangleLayers = [NSMutableArray array];
    }
    return _arrayOfTriangleLayers;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    int width = 28;
    [super viewDidLoad];
    NSArray *grayscales = @[@0.3, @0.15, @0.6, @0.45, @0.75, @0.0];
    
    
    
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.02f target:self selector:@selector(fire:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    for (int i = 0; i <= self.view.bounds.size.width; i += width) {
        for (int j = 0; j <= self.view.bounds.size.height; j+=width) {
            if (j > 100 && j < self.view.bounds.size.height - 100) {
                continue;
            }
            
            UIImageView *topLeft = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topLeft"]];
            UIImageView *topRight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topRight"]];
            UIImageView *bottomLeft = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottomLeft"]];
            UIImageView *bottomRight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottomRight"]];
            
            UIImageView *topLeft2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topLeft"]];
            UIImageView *topRight2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topRight"]];
            UIImageView *bottomLeft2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottomLeft"]];
            UIImageView *bottomRight2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottomRight"]];

           

            bottomRight.frame = CGRectMake(i, j, topLeft.frame.size.width, topLeft.frame.size.height);
            topLeft2.frame    = bottomRight.frame;
            bottomLeft.frame = CGRectMake(i + topLeft.frame.size.width, j, topRight.frame.size.width, topRight.frame.size.height);
            topRight2.frame = bottomLeft.frame;

            topRight.frame = CGRectMake(i, j + topLeft.frame.size.height, bottomLeft.frame.size.width, bottomLeft.frame.size.height);
            bottomLeft2.frame = topRight.frame;
            topLeft.frame = CGRectMake(i + bottomLeft.frame.size.width, j + topLeft.frame.size.height, bottomRight.frame.size.width, bottomRight.frame.size.height);
            bottomRight2.frame = topLeft.frame;
            topLeft.alpha = [grayscales[arc4random() % grayscales.count] floatValue];
            topLeft2.alpha = [grayscales[arc4random() % grayscales.count] floatValue];
            topRight.alpha = [grayscales[arc4random() % grayscales.count] floatValue];
            topRight2.alpha = [grayscales[arc4random() % grayscales.count] floatValue];
            bottomLeft.alpha = [grayscales[arc4random() % grayscales.count] floatValue];
            bottomLeft2.alpha = [grayscales[arc4random() % grayscales.count] floatValue];
            bottomRight.alpha = [grayscales[arc4random() % grayscales.count] floatValue];
            bottomRight2.alpha =[grayscales[arc4random() % grayscales.count] floatValue];
            
            
                [self.view addSubview:topLeft];
                [self.view addSubview:topLeft2];
                [self.view addSubview:topRight];
                [self.view addSubview:topRight2];
                [self.view addSubview:bottomLeft];
                [self.view addSubview:bottomLeft2];
                [self.view addSubview:bottomRight];
                [self.view addSubview:bottomRight2];
            
             
            

        }
    }
    
    [self.view addSubview:[self sectionalView]];
    // Do any additional setup after loading the view.
}

- (UIView *)sectionalView{
    UIView *sectionalView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIImageView *first = [[UIImageView alloc] initWithImage:self.images[0]];
    UIImageView *second = [[UIImageView alloc] initWithImage:self.images[3]];
    [sectionalView addSubview:first];
    [sectionalView addSubview:second];
    return sectionalView;
}
- (void)fire:(NSTimer *)timer{
    for (UIView *subview in self.view.subviews) {
        
        
        if (subview.tag > 1 ){
            subview.tag--;
        }
        
        if (subview.tag == 1 || subview.tag == 0) {
            subview.alpha += subview.tag == 0 ? -0.01f : 0.01f;
        }
        
        if (subview.alpha >= 0.8f) {
            subview.tag = 0;
        }
        if (subview.alpha <= 0.0f) {
            //defines maximum possible amount of time a triangle may be dead (alpha 0) before coming back to life
            subview.tag = (arc4random() % 400) + 1;
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


                      

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
