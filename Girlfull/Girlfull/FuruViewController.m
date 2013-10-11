
#import "FuruViewController.h"
#import "EndViewController.h"
#import "GirlPlayer.h"

@implementation FuruViewController
{
    UIImageView *girl;
    UILabel *favo;
    EndViewController *endVC;
    
    CGPoint start, previous, moving, end, before, after;
    double favoRate;
    double time;
    
    GirlPlayer *player;
    NSTimer *voiceTimer;
    NSTimer *plusTimer, *minusTimer;
}

- (void)viewDidLoad
{
    player = [GirlPlayer sharedPlayer];
    favoRate = 0;
    time = 0;
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backImage.backgroundColor = [UIColor clearColor];
    backImage.image = [UIImage imageNamed:@"box.png"];
    [self.view addSubview:backImage];
    
    girl = [[UIImageView alloc] initWithFrame:CGRectMake(60, 200, 165, 192)];
    girl.backgroundColor = [UIColor clearColor];
    girl.image = [UIImage imageNamed:@"girl.png"];
    girl.userInteractionEnabled = YES;
    [self.view addSubview:girl];
    
    UIImageView *heart = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-90, SCREEN_HEIGHT-90, 60, 60)];
    heart.backgroundColor = [UIColor clearColor];
    heart.image = [UIImage imageNamed:@"heart.png"];
    heart.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveToEndView)];
    [heart addGestureRecognizer:tap];
    
    favo = [[UILabel alloc] initWithFrame:CGRectMake(-10, 12, heart.frame.size.width+20, 50)];
    favo.backgroundColor = [UIColor clearColor];
    favo.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:22];
    favo.text = [NSString stringWithFormat:@"%d", (int)favoRate];
    favo.textAlignment = UITextAlignmentCenter;
    favo.textColor = [UIColor whiteColor];
    favo.userInteractionEnabled = NO;
    
    [heart addSubview:favo];
    [self.view addSubview:heart];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(dismissViews) name:@"dismiss" object:nil];
    
}


- (void) moveToEndView
{
    [voiceTimer invalidate];
    endVC = [[EndViewController alloc] init];
    endVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:endVC animated:YES completion:nil];
}

- (void) dismissViews
{
    [endVC dismissViewControllerAnimated:NO completion:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    start = CGPointMake(-1, -1);
    
    if ([event touchesForView:girl]) {
        start = [[touches anyObject] locationInView:self.view];
        
        time = 0;
        [minusTimer invalidate];
        plusTimer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self
                                                   selector:@selector(plusFavoRate) userInfo:nil repeats:YES];
        voiceTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self
                                               selector:@selector(whisper) userInfo:nil repeats:YES];
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (start.x < 0 && start.y < 0) return;
    
    before = girl.center;
    previous = [[touches anyObject] previousLocationInView:self.view];
    moving = [[touches anyObject] locationInView:self.view];
    
    after = CGPointMake(before.x, before.y + (moving.y - previous.y));
    if (after.y > 196 && after.y < SCREEN_HEIGHT-200) {
        [girl setCenter:after];
        [self plusFavoRate];
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (start.x < 0 && start.y < 0) return;
    
    previous = [[touches anyObject] previousLocationInView:self.view];
    end = [[touches anyObject] locationInView:self.view];
    
    after = CGPointMake(before.x, before.y + (moving.y - previous.y));
    if (after.y >= 196 && after.y <= SCREEN_HEIGHT-200) {
        [girl setCenter:after];
        [self plusFavoRate];
    }
    
    if (favoRate >= 100) {
        [NSThread sleepForTimeInterval:1.0f];
        [self moveToEndView];
    }
    
    time = 0;
    [plusTimer invalidate];
    [voiceTimer invalidate];
    
    minusTimer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self
                                               selector:@selector(minusFavoRate) userInfo:nil repeats:YES];
}

- (void) plusFavoRate
{
    time += 0.001;
    favoRate += 1.5625 * pow(time, 2);
    
    if (favoRate >= 100) {
        favoRate = 100;
    }
    
    favo.text = [NSString stringWithFormat:@"%d", (int)favoRate];
}

- (void) minusFavoRate
{
    time += 0.1;
    favoRate -= (favoRate * 0.015625) * pow(time, 2);
    
    if (favoRate < 0) {
        favoRate = 0;
        time = 0;
        [minusTimer invalidate];
    }
    
    favo.text = [NSString stringWithFormat:@"%d", (int)favoRate];
}

- (void) whisper
{
    int type = arc4random() % 1 + 1;
    [player playVoiceWithType:type];
}


@end
