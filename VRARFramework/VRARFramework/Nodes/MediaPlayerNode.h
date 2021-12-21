//
//  MediaPlayerNode.h
//  ARPlayer
//
//  Created by Maxim Makhun on 9/20/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

@import SceneKit;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, PlayerState) {
    Playing,
    Paused,
};

/*!
 @class MediaPlayerNode
 @abstract MediaPlayerNode main video playback node.
 @discussion It is holder class for all other media playback related nodes. For example:
 Play, pause, switch tracks, playback time etc
 */
@interface MediaPlayerNode : SCNNode

/*!
 @method initWithPlaylist:
 @abstract Creates and initializes media player node instance with the specified playlist.
 @param playlist Array of NSURLs.
 @param direction NSString of video direction(vertically or horizontally), default is horizontal.
 */
- (instancetype)initWithPlaylist:(NSArray<NSURL *> *)playlist direction:(NSString *)direction;

/*!
 @method pause
 @abstract Pauses playback of media player.
 */
- (void)pause;

/*!
 @method play
 @abstract Starts media playback.
 */
- (void)play;

/*!
 @method togglePlay
 @abstract Either starts or pauses playback.
 */
- (void)togglePlay;

/*!
 @method stop
 @abstract Stop media playback.
 */
- (void)stop;

/*!
 @property state
 @abstract Current playback state - can be either paused or playing.
 */
@property (nonatomic) PlayerState state;

@end

NS_ASSUME_NONNULL_END
