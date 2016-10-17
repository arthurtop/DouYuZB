//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by songlei on 2016/9/29.
//  Copyright © 2016年 songlei. All rights reserved.
//

import UIKit

fileprivate let sTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {

    
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatuBarH+kNavigationBarH, width: kScreenW, height: sTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        
        titleView.delegate = self
        
        return titleView
    }()
    
    
    fileprivate lazy var pageContentView : PageContentView = {[weak self] in
        let contentH = kScreenH - kStatuBarH - kNavigationBarH - sTitleViewH
        let contentY = kStatuBarH + kNavigationBarH + sTitleViewH
        let contentFrame = CGRect(x: 0, y: contentY, width: kScreenW, height: contentH)
        
        var childVcs = [UIViewController]()
        
        childVcs.append(RecommendViewController())
        
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        print(childVcs.count)
        
        let contentView = PageContentView(frame: contentFrame, childVCs: childVcs, parentViewController: self)
        
        contentView.delegate = self
        
        return contentView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupUI()
        
        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: -- 设置UI界面
extension HomeViewController {
    fileprivate func setupUI(){
        
        ///不需要uiscrollView 调整内边距
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavgationBar()
        
        view.addSubview(pageTitleView)
        
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
        
    }
    
    
    private func setupNavgationBar(){
        
//        let btn = UIButton()
//        btn.setImage(UIImage(named: "logo"), for: .normal)
//        btn.sizeToFit()  ///自适应 图片大小
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        let size = CGSize(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", hightImageName: "image_my_history_click", size: size)
        
        
        let searchItem = UIBarButtonItem(imageName: "btn_search", hightImageName: "btn_search_clicked", size: size)
        
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", hightImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
        
        
        
    }
    
}

// MARK: -- 遵守代理
extension HomeViewController: PageTitleViewDelegate{
    
    
    func pageTitleView(titleView: PageTitleView, index: Int){
        
        pageContentView.setCurrentIndex(currentIndex: index)
        
    }
    
}

extension HomeViewController: PageContentViewDelegate {
    
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
}
