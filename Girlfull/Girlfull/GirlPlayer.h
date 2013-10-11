
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface GirlPlayer : NSObject<AVAudioPlayerDelegate>

+ (GirlPlayer*)sharedPlayer;

- (void) playVoiceWithType:(int)type;
- (void) playSecretVoice;
- (void) stop;

@end
