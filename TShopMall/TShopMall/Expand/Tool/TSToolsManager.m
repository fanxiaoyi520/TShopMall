//
//  TSToolsManager.m
//  TSale
//
//  Created by Daisy  on 2020/12/21.
//  Copyright © 2020 TCL. All rights reserved.
//

#import "TSToolsManager.h"

@implementation TSToolsManager

+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    static TSToolsManager *toolManager;
    dispatch_once(&onceToken, ^{
        toolManager = [[TSToolsManager allocWithZone:nil] init];
    });
    
    return toolManager;
}

- (NSString *)convertToJsonData:(NSDictionary *)dict {
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}
-(NSDictionary *)convertStrToDic:(NSString *)jsonStr
{
    if ([jsonStr isNotBlank]) {
        
        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];

        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        return dic;
    }
    return @{};
}
- (NSMutableAttributedString *) attributedStr:(NSString *)str
                                  LineSpacing:(CGFloat)lineSpacing {
    
    if (![str  isNotBlank]) {
        return nil;
    }
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:lineSpacing];
    
    paragraphStyle.lineBreakMode   = NSLineBreakByTruncatingTail;
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    
    return  attributedString;
}
#pragma mark  - 高亮字符简单的处理
-(NSMutableAttributedString * )nomalText:(NSString *)nomalStr
                         highlightedText:(NSString *)highlighted
                            hasPrefixStr:(NSString *)prefixStr
                        highlightedColor:(UIColor *)highliaghtColor {
    
    NSMutableAttributedString *attributedStr  = [[NSMutableAttributedString alloc]initWithString:(nomalStr.length  == 0)? @"":nomalStr];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName value:highliaghtColor range:NSMakeRange(prefixStr.length, highlighted.length)];
    
    return attributedStr;
}

-(void)cacheData:(id)cacheJsonData fileName:(NSString *)name
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:name];
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:cacheJsonData options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {

        return ;
    }
    NSString *json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    [json writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {

    }
}

-(id)readerFromeCache:(NSString *)fileName
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    path = [path stringByAppendingPathComponent: fileName];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    if (data.length == 0) {
        return @[];
    }
    id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    return obj;
}
-(NSMutableAttributedString *)attributedStr:(NSString *)content
                                   hightStr:(NSString *)highlighted
{
    NSString *contenStr = [NSString stringWithFormat:@"%@ %@",content,highlighted];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:contenStr];
    NSRange range = [contenStr rangeOfString:highlighted];
    
    [attStr addAttributes:@{
        NSForegroundColorAttributeName : KHexAlphaColor(@"#2D3132", 0.6),
        NSFontAttributeName : KRegularFont(12.0)
    } range:NSMakeRange(0, contenStr.length)];
    
    //添加下划线
    [attStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
    //添加图片
    if ([highlighted isNotBlank]) {
        NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
        attchImage.image = [UIImage imageNamed:@"orderMsgArrow"];
        attchImage.bounds = CGRectMake(0, -5, 16, 16);
        NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
        [attStr insertAttributedString:stringImage atIndex:contenStr.length];
    }
    
    //段落间距
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    paragraphStyle.lineBreakMode   = NSLineBreakByTruncatingTail;
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [contenStr length])];

    return attStr;
}
@end
