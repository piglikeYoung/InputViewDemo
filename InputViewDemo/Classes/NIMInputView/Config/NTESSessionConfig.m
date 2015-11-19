//
//  NTESSessionConfig.m
//  NIM
//
//  Created by amao on 8/11/15.
//  Copyright (c) 2015 Netease. All rights reserved.
//

#import "NTESSessionConfig.h"
#import "NIMMediaItem.h"

@interface NTESSessionConfig()

@end

@implementation NTESSessionConfig

- (NSArray *)mediaItems
{
    return @[[NIMMediaItem item:NTESMediaButtonPicture
                    normalImage:[UIImage imageNamed:@"bk_media_picture_normal"]
                  selectedImage:[UIImage imageNamed:@"bk_media_picture_nomal_pressed"]
                          title:@"相册"],
             
             [NIMMediaItem item:NTESMediaButtonShoot
                    normalImage:[UIImage imageNamed:@"bk_media_shoot_normal"]
                  selectedImage:[UIImage imageNamed:@"bk_media_shoot_pressed"]
                          title:@"拍摄"],
             
             [NIMMediaItem item:NTESMediaButtonLocation
                    normalImage:[UIImage imageNamed:@"bk_media_position_normal"]
                  selectedImage:[UIImage imageNamed:@"bk_media_position_pressed"]
                          title:@"位置"],
             
             [NIMMediaItem item:NTESMediaButtonJanKenPon
                    normalImage:[UIImage imageNamed:@"icon_jankenpon_normal"]
                  selectedImage:[UIImage imageNamed:@"icon_jankenpon_pressed"]
                          title:@"石头剪刀布"],
             
             [NIMMediaItem item:NTESMediaButtonAudioChat
                    normalImage:[UIImage imageNamed:@"btn_media_telphone_message_normal"]
                  selectedImage:[UIImage imageNamed:@"btn_media_telphone_message_pressed"]
                          title:@"实时语音"],
             
             [NIMMediaItem item:NTESMediaButtonVideoChat
                    normalImage:[UIImage imageNamed:@"btn_bk_media_video_chat_normal"]
                  selectedImage:[UIImage imageNamed:@"btn_bk_media_video_chat_pressed"]
                          title:@"视频聊天"],
             
             [NIMMediaItem item:NTESMediaButtonFileTrans
                    normalImage:[UIImage imageNamed:@"icon_file_trans_normal"]
                  selectedImage:[UIImage imageNamed:@"icon_file_trans_pressed"]
                          title:@"文件传输"],
             
             [NIMMediaItem item:NTESMediaButtonSnapchat
                    normalImage:[UIImage imageNamed:@"bk_media_snap_normal"]
                  selectedImage:[UIImage imageNamed:@"bk_media_snap_pressed"]
                          title:@"阅后即焚"],
             
             [NIMMediaItem item:NTESMediaButtonWhiteBoard
                    normalImage:[UIImage imageNamed:@"btn_whiteboard_invite_normal"]
                  selectedImage:[UIImage imageNamed:@"btn_whiteboard_invite_pressed"]
                          title:@"白板"]];
}



@end
