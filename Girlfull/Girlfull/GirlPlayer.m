
#import "GirlPlayer.h"

@implementation GirlPlayer
{
    AVAudioPlayer *audioPlayer;
}

static GirlPlayer* sharedPlayer = nil;

+ (GirlPlayer*)sharedPlayer {
    @synchronized(self) {
        if (sharedPlayer == nil) {
            sharedPlayer = [[self alloc] init];
        }
    }
    return sharedPlayer;
}

- (void) playVoiceWithType:(int)type
{
    NSString *voiceName = [NSString stringWithFormat:@"voice%d", type];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:voiceName ofType:@"mp3"];
    if (filePath == nil) filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp3"];
    NSURL *fileUrl  = [NSURL fileURLWithPath:filePath];
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:nil];
    audioPlayer.delegate = self;
    [audioPlayer prepareToPlay];
    [audioPlayer play];
}

- (void) playSecretVoice
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"end" ofType:@"mp3"];
    NSURL *fileUrl  = [NSURL fileURLWithPath:filePath];
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:nil];
    audioPlayer.delegate = self;
    [audioPlayer prepareToPlay];
    [audioPlayer play];
}

- (void) stop
{
    [audioPlayer stop];
}

@end
