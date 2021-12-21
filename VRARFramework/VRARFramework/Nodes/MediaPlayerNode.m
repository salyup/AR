//
//  MediaPlayerNode.m
//  ARPlayer
//
//  Created by Maxim Makhun on 9/20/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

// Nodes
#import "MediaPlayerNode.h"
#import "TVNode.h"

// Utils
#import "Constants.h"

@interface MediaPlayerNode ()

@property (nonatomic, strong) TVNode *tvNode;
@property (nonatomic, strong) NSArray<NSURL *> *playlist;
@property (nonatomic) NSInteger currentPlaybackIndex;

@end

@implementation MediaPlayerNode

#pragma mark - Init methods

- (instancetype)initWithPlaylist:(NSArray<NSURL *> *)playlist direction:(NSString *)direction {
    self = [self init];
    
    if (self) {
        self.playlist = playlist;
        [self constructNodes:direction];
        [self setupMediaPlayerNode];
    }
    
    return self;
}

- (void)setupMediaPlayerNode {
    self.currentPlaybackIndex = 0;
    self.physicsBody = [SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeStatic shape:nil];
    self.name = kMediaPlayerNode;
}

- (void)constructNodes: (NSString *)direction {
    self.tvNode = [[TVNode alloc] initWithdirection:direction];
    [self addChildNode:self.tvNode];
}

#pragma mark - Video player control logic

- (void)pause {
    self.state = Paused;
    [self.tvNode.player pause];
}

- (void)playAnimated:(BOOL)animated {
    if (self.playlist.count != 0) {
        if (self.tvNode.player == NULL) {
            [self switchToTrackWithIndex:self.currentPlaybackIndex];
        } else {
            [self.tvNode.player play];
        }

        self.state = Playing;
    } else {
        NSLog(@"[%s] Playlist empty, playback won't be started.", __FUNCTION__);
    }
}

- (void)play {
    if (self.playlist.count != 0) {
        if (self.tvNode.player == NULL) {
            [self switchToTrackWithIndex:self.currentPlaybackIndex];
        } else {
            [self.tvNode.player play];
        }
        
        self.state = Playing;
    } else {
        NSLog(@"[%s] Playlist empty, playback won't be started.", __FUNCTION__);
    }
}

- (void)togglePlay {
    switch (self.state) {
        case Playing:
            [self pause];
            break;
        case Paused:
            [self play];
            break;
        default:
            break;
    }
}

- (void)stop {
    self.state = Paused;
    self.tvNode.player = nil;
}

#pragma mark - Video player track switching logic


- (void)switchToTrackWithIndex:(NSUInteger)index {    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:self.playlist[index]];
    
    if (self.tvNode.player.currentItem != playerItem) {
        self.tvNode.player = [AVPlayer playerWithPlayerItem:playerItem];
    }
    
    self.state = Playing;
}

@end
