//
//  Macros.h
//  iGithub
//
//  Created by Jack Yin on 15/2/2.
//  Copyright (c) 2015年 Yin Xiaoyu. All rights reserved.
//

#define UIColorFromHex(hexString) [UIColor colorWithRed:((float)((hexString & 0xFF0000) >> 16))/255.0 \
                                                  green:((float)((hexString & 0x00FF00) >>  8))/255.0 \
                                                   blue:((float)((hexString & 0x0000FF) >>  0))/255.0 \
                                                  alpha:1.0]
