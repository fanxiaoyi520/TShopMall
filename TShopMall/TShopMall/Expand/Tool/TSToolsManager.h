//
//  TSToolsManager.h
//  TSale
//
//  Created by Daisy  on 2020/12/21.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TSToolsManager : NSObject

+(instancetype)shareManager;

/*
 * 字典转json字符串
 */
- (NSString *)convertToJsonData:(NSDictionary *)dict;

/*
 * json字符串转字典
 */
-(NSDictionary *)convertStrToDic:(NSString *)jsonStr;

/*
 * 设置行间距
 */

- (NSMutableAttributedString *) attributedStr:(NSString *)str
                                  LineSpacing:(CGFloat)lineSpacing;

/*
 * 文本字符高亮
 */
-(NSMutableAttributedString * )nomalText:(NSString *)nomalStr
                         highlightedText:(NSString *)highlighted
                            hasPrefixStr:(NSString *)prefixStr
                        highlightedColor:(UIColor *)highliaghtColor;

//读取存储的json数据
-(id)readerFromeCache:(NSString *)fileName;

//写入json数据
-(void)cacheData:(id)cacheJsonData fileName:(NSString *)name;

//消息富文本add 图片
-(NSMutableAttributedString *)attributedStr:(NSString *)content
                                   hightStr:(NSString *)highlighted;
@end


