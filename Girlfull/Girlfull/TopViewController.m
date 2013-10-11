

#import "TopViewController.h"
#import "FuruViewController.h"

@implementation TopViewController

- (void)viewDidLoad
{
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backImage.backgroundColor = [UIColor blueColor];
    backImage.image = [UIImage imageNamed:@"title.png"];
    [self.view addSubview:backImage];
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [startBtn setFrame:CGRectMake(30, SCREEN_HEIGHT-80, SCREEN_WIDTH-60, 40)];
    [startBtn setTitle:@"スタート" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(moveToFuruView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
}

- (void) moveToFuruView
{
    FuruViewController *furuVC = [[FuruViewController alloc] init];
    furuVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:furuVC animated:YES completion:nil];
}


@end
