//
//  ViewController.swift
//  DZNEmptyDataSet_Swift
//
//  Created by 祁志远 on 2017/6/28.
//  Copyright © 2017年 祁志远. All rights reserved.
//

import UIKit
import DZNEmptyDataSet


let MineHeaderImageHeight = 200.0

class ViewController: UIViewController {

    var cellCount = 0
    
    var isLoading: Bool?  = false {
        didSet {
            
            reloadTableView()

        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        setupTableView()
    }

    fileprivate lazy var tableView: UITableView = {[weak self] in
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.delegate = self;
        tableView.dataSource = self;
        return tableView
        }()
    
    
    /// 创建 tableView
    fileprivate func setupTableView() {
        
        view.addSubview(tableView)
        tableView.tableFooterView = UIView()
        tableView.frame = self.view.bounds


    }

}



extension ViewController: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    //MARK: -- DZNEmptyDataSetSource Methods
    //标题为空的数据集
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "没有数据";
        let attributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: CGFloat(18.0)), NSForegroundColorAttributeName: UIColor.blue]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    //描述为空的数据集
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        paragraph.lineSpacing = CGFloat(NSLineBreakMode.byWordWrapping.rawValue)
        let attributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: CGFloat(15.0)), NSForegroundColorAttributeName: UIColor.red, NSParagraphStyleAttributeName: paragraph]
        return NSAttributedString(string: "真的没有数据！", attributes: attributes)
    }
    ////空数据按钮图片
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        if isLoading! { //加载动画图片
            return UIImage(named: "youku_refreshing")
        } else {
            return UIImage(named: "placeholder_instagram")
        }
    }
    
    //数据集加载动画
    func imageAnimation(forEmptyDataSet scrollView: UIScrollView!) -> CAAnimation! {
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        animation.toValue = NSValue(caTransform3D: CATransform3DMakeRotation(CGFloat(Double.pi / 2), 0.0, 0.0, 1.0))
        animation.duration = 0.25
        animation.isCumulative = true
        animation.repeatCount = MAXFLOAT
        return animation as CAAnimation
    }
    //按钮标题为空的数据集
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> NSAttributedString! {
        let attributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: CGFloat(16.0)), NSForegroundColorAttributeName: (state == UIControlState.normal) ? UIColor.brown : UIColor.green]
        return NSAttributedString(string: "重新加载", attributes: attributes)
    }
    
    ////重新加载按钮背景图片
    func buttonBackgroundImage(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> UIImage! {
        let image = UIImage(named: state == UIControlState.normal ? "button_background_foursquare_normal" : "button_background_foursquare_highlight")
        return image?.resizableImage(withCapInsets: UIEdgeInsetsMake(25.0, 25.0, 25.0, 25.0), resizingMode: .stretch).withAlignmentRectInsets(UIEdgeInsetsMake(0.0, 10.0, 0.0, 10.0))
        
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 0
    }
    
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 10
    }
    
    //MARK: -- DZNEmptyDataSetDelegate
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView!) -> Bool {
        return self.isLoading!
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap view: UIView!) {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.isLoading = false
            self.reloadTableView()


        }
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.isLoading = false
            self.cellCount = 10
            self.reloadTableView()
            
        }
    }
    
    fileprivate func reloadTableView(){
        self.tableView.reloadData()
        self.tableView.reloadEmptyDataSet()
    }
    
}
