//
//  data.swift
//  HYEasyLife
//
//  Created by Sekorm on 2017/3/21.
//  Copyright © 2017年 YL. All rights reserved.
//

import Foundation


// MARK: - 首页的数据请求
/**
 获取所有的主题分类	http://m.htxq.net/servlet/SysCategoryServlet?action=getList
 
 
 /**
 获取首页的文章列表
 
 - parameter paramters: 参数字典
 - 必传:currentPageIndex,pageSize(当currentPageIndex=0时,该参数无效, 但是必须传)
 - 根据情景传:
 - isVideo	true (是否是获取视频列表)
 - cateId	a56aa5d0-aa6b-42b7-967d-59b77771e6eb(专题的类型, 不传的话是默认)
 http://m.htxq.net/servlet/SysArticleServlet?action=mainList?currentPageIndex=1?pageSize=10
 
 // MARK: - 每周TOP10的获取
 /**
 获取每周TOP10
 
 - parameter action:   具体获取"专栏"还是"作者"
 - parameter finished: 返回的block
 */

http://ec.htxq.net/servlet/SysArticleServlet?currentPageIndex=0&pageSize=10



// MARK: - 文章详情
/**
 获取文章详情
 
 - parameter paramters: 参数
 - parameter finished:  返回的闭包
 
 
 http://m.htxq.net/servlet/SysArticleServlet?action=getArticleDetail
 
 /**
 获取评论列表
 
 - parameter parameters: 参数
 - parameter finished:   评论列表
 */


http://m.htxq.net/servlet/UserCommentServlet

// MARK: -  商城相关网络请求
/**
 获取商城的分类
 
 - parameter finished: 结果的闭包
 */
http://ec.htxq.net/rest/htxq/item/tree


/**
 获得置顶的商品
 
 - parameter finished: 回调的闭包
 */
http://ec.htxq.net/rest/htxq/index/carousel


/**
 获取商城的商品列表(GET)
 
 - parameter identify:   标记符, 精选:jingList/1 商城:theme
 - parameter parameters: 参数
 - parameter finished:   回调的闭包
 */

http://ec.htxq.net/rest/htxq/index/?jingList=1

/**
 商场搜索(POST)
 参数:"fnName": "花"
 - parameter keyword:  搜索关键字
 - parameter finished: 返回的闭包
 */
http://ec.htxq.net/rest/htxq/goods/search


/**
 选择商城的分类
 
 - parameter itemID: 分类id
 */
http://ec.htxq.net/rest/htxq/goods/itemGoods

/**
 获得商品详情
 
 - parameter goodsId: 商品id
 */

http://ec.htxq.net/rest/htxq/goods/detail/



/**
 获得订单详情
 http://ec.htxq.net/rest/htxq/goods/orderConfirm/041a470b-79ee-4c0b-b870-9356f15f6a8b/df277edb-a0c6-43fb-919a-cf2a9ac7e952
 前面是用户id(由于没有做登录, 所以id直接写死), 后面是商品id
 - parameter goodsId: 商品id
 */
http://ec.htxq.net/rest/htxq/goods/orderConfirm/041a470b-79ee-4c0b-b870-9356f15f6a8b/



/**
 获取收货地址列表
 http://ec.htxq.net/rest/htxq/address/list/041a470b-79ee-4c0b-b870-9356f15f6a8b
 */
http://ec.htxq.net/rest/htxq/address/list/041a470b-79ee-4c0b-b870-9356f15f6a8b


/**
 删除地址
 
 - parameter addressID: 地址ID
 
 - returns: 是否删除成功
 */

http://ec.htxq.net/rest/htxq/address/delete/


/**
 设置默认的收货地址
 
 - parameter addressID: 地址id
 */

http://ec.htxq.net/rest/htxq/address/setDefault/041a470b-79ee-4c0b-b870-9356f15f6a8b/

/**
 新增/修改地址(同一个接口)
 
 - parameter parameters: 参数
 */

http://ec.htxq.net/rest/htxq/address/add



// MARK: - profile相关网络请求
// http://m.htxq.net/servlet/UserCenterServlet?action=getMyContents&currentPageIndex=1&pageSize=15&userId=4a3dab7f-1168-4a61-930c-f6bc0f989f32

func columnistDetails(_ parameters:[String : AnyObject]?, finished:@escaping (_ articles: [Article]?, _ error: NSError?, _ loadAll: Bool)->()) {
    request(.GET, "http://m.htxq.net/servlet/UserCenterServlet?action=getMyContents&pageSize=15",
            
    /**
     获取用户详情
     
     - parameter userID:   用户id
     - parameter finished: 完成之后的回调
     */
            func getUserDetail(_ userID: String, finished:@escaping (_ author: Author?, _ error: NSError?)->()) {
                request(.GET, "http://m.htxq.net/servlet/UserCustomerServlet?action=getUserDetail", parameters: ["userId": userID], encoding: .url, headers: nil).responseJSON(queue: DispatchQueue.main, options: []) { (response) in
                    
                    
