
#import "EndViewController.h"
#import "TopViewController.h"

@implementation EndViewController
{
    GirlPlayer *player;
}

- (void)viewDidLoad
{
    player = [GirlPlayer sharedPlayer];
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backImage.backgroundColor = [UIColor redColor];
    backImage.image = [UIImage imageNamed:@"end.png"];
    backImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveToTopView)];
    [backImage addGestureRecognizer:tap];
    [self.view addSubview:backImage];
}

- (void)viewDidAppear:(BOOL)animated
{
    [player playSecretVoice];
}

- (void) moveToTopView
{
    [player stop];
    
    NSNotification *n = [NSNotification notificationWithName:@"dismiss" object:self];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotification:n];
}
@end
