//
//  HYSysCategoryServletModel.h
//  Floral
//
//  Created by Sekorm on 2017/3/27.
//  Copyright © 2017年 YL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYSysCategoryServletModel : NSObject
//"createDate": "2016-08-26 18:58:09.0",
//"enName": "Class",
//"fnImgNew": "http://static.htxq.net/UploadFiles/2017/03/11/20170311131335821369.jpg",
//"fnParentId": "0",
//"fnStatus": 1,
//"id": "8dba5958-7da0-4ce9-b1e9-5b92343519a7",
//"img": "http://static.htxq.net/UploadFiles/2016/08/26/20160826192049498465.jpg",
//"name": "花艺学堂",
//"order": 10

@property (nonatomic,copy) NSString *createDate;
@property (nonatomic,copy) NSString *enName;
@property (nonatomic,copy) NSString *fnImgNew;
@property (nonatomic,copy) NSString *fnParentId;
@property (nonatomic,copy) NSString *fnStatus;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *order;
@end
