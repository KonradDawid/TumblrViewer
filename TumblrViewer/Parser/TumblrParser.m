//
//  TumblrParser.m
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import "TumblrParser.h"
#import "GDataXMLNode.h"
#import "Post.h"
#import "PhotoPost.h"
#import "RegularPost.h"
#import "TumblrInfo.h"


@implementation TumblrParser

+ (TumblrInfo *)infoFromData:(NSData *)data {
    
    NSError *error;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:data error:&error];
    if (document == nil || error!= nil) {
        return nil;
    }
    
    GDataXMLElement *logElement = [document.rootElement elementsForName:@"tumblelog"].firstObject;
    GDataXMLNode *titleAttribute = [logElement attributeForName:@"title"];
    NSString *titleString = titleAttribute.stringValue;
    
    GDataXMLElement *postsElement = [document.rootElement elementsForName:@"posts"].firstObject;
    GDataXMLNode *totalPostsAttribute = [postsElement attributeForName:@"total"];
    NSInteger totalPosts = [totalPostsAttribute.stringValue integerValue];
    
    TumblrInfo *info = [[TumblrInfo alloc]initWithTitle:titleString postsCount:totalPosts];
    return info;
}

+ (NSArray<Post*> *)postsFromData:(NSData *)data {
    
    NSError *error;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:data error:&error];
    if (document == nil || error!= nil) {
        return nil;
    }
    
    NSMutableArray *posts = [NSMutableArray array];
    
    NSArray *postElements = [document nodesForXPath:@"//posts/post" error:nil];
    for (GDataXMLElement *postElement in postElements) {
        Post *post = [self postFromXmlElement:postElement];
        if (post != nil) {
            [posts addObject:post];
        }
    }
    
    return [posts copy];
}

+ (Post *)postFromXmlElement:(GDataXMLElement *)xmlElement {
    GDataXMLNode *postTypeAttribute = [xmlElement attributeForName:@"type"];
    NSString *typeName = postTypeAttribute.stringValue;
    
    if ([typeName isEqualToString:@"photo"]) {
        return [self photoPostFromXmlElement:xmlElement];
    } else if ([typeName isEqualToString:@"regular"]) {
        return [self regularPostFromXmlElement:xmlElement];
    } else {
        return [[Post alloc]initWithIdentifier:nil postType:PostTypeOther postedAt:0];
    }
}

+ (RegularPost *)regularPostFromXmlElement:(GDataXMLElement *)xmlElement {
    
    NSString *identifierString = [self identifierFromXmlElement:xmlElement];
    if (identifierString == nil) {
        return nil;
    }
    
    NSTimeInterval postedAtTimestamp = [self postedAtTimestampFromXmlElement:xmlElement];
    
    GDataXMLElement* titleElement = [xmlElement elementsForName:@"regular-title"].firstObject;
    NSString *titleString = titleElement.stringValue;
    
    GDataXMLNode *bodyElement = [xmlElement elementsForName:@"regular-body"].firstObject;
    NSString *bodyString = bodyElement.stringValue;
    
    NSArray *tagStrings = [self tagStringFromXmlElement:xmlElement];
    
    RegularPost *post = [[RegularPost alloc] initWithIdentifier:identifierString postedAt:postedAtTimestamp title:titleString body:bodyString tags:tagStrings];
    return post;
}

+ (PhotoPost *)photoPostFromXmlElement:(GDataXMLElement *)xmlElement {
    
    NSString *identifierString = [self identifierFromXmlElement:xmlElement];
    if (identifierString == nil) {
        return nil;
    }
    
    NSTimeInterval postedAtTimestamp = [self postedAtTimestampFromXmlElement:xmlElement];
    
    GDataXMLElement *captionElement = [xmlElement elementsForName:@"photo-caption"].firstObject;
    NSString *captionString = captionElement.stringValue;
    
    NSMutableArray *photos = [NSMutableArray array];
    NSArray *photoElements = [xmlElement elementsForName:@"photo-url"];
    for (GDataXMLElement *photoElement in photoElements) {
        NSString *photoString = photoElement.stringValue;
        if (photoString != nil) {
            [photos addObject:photoString];
        }
    }
    
    NSArray *tagStrings = [self tagStringFromXmlElement:xmlElement];
    
    PhotoPost *post = [[PhotoPost alloc] initWithIdentifier:identifierString postedAt:postedAtTimestamp caption:captionString photos:photos tags:tagStrings];
    return post;
}

#pragma mark - Helper methods

+ (NSString *)identifierFromXmlElement:(GDataXMLElement *)xmlElement {
    GDataXMLNode *identifierAttribute = [xmlElement attributeForName:@"id"];
    return identifierAttribute.stringValue;
}

+ (NSTimeInterval)postedAtTimestampFromXmlElement:(GDataXMLElement *)xmlElement {
    GDataXMLNode *postedTimestampAttribute = [xmlElement attributeForName:@"unix-timestamp"];
    return [postedTimestampAttribute.stringValue doubleValue];
}

+ (NSArray<NSString*> *)tagStringFromXmlElement:(GDataXMLElement *)xmlElement {
    NSMutableArray *tagStrings = [NSMutableArray array];
    NSArray *tagElements = [xmlElement elementsForName:@"tag"];
    for (GDataXMLElement *tagElement in tagElements) {
        NSString *tagString = tagElement.stringValue;
        if (tagString != nil) {
            [tagStrings addObject:tagString];
        }
    }
    return [tagStrings copy];
}

@end

