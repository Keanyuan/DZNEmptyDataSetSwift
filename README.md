# DZNEmptyDataSetSwift
DZNEmptyDataSet占位图swift版本


在swift开发中，会遇到页面无数据的情况，当没有数据时，页面一片空白，顿时令用户心情很不好，在OC中自己定义的占位图View不免有点太low，于是采用第三方占位图框架DZNEmptyDataSet，如今在swift中也需要使用此此景，下面就介绍一下如何在swift中使用DZNEmptyDataSet。
1.新建swift工程，并导入第三方

$ pod init

在Podfile中添加  DZNEmptyDataSet三方框架
use_frameworks!
#占位图
pod 'DZNEmptyDataSet'

然后
$ pod install

2 创建一个OC转swift的桥接对象文件

3.新建一个viewController，添加tableView 设置emptyData代理

4.实现代理协议
简书地址： http://www.jianshu.com/p/77f6aca82564
