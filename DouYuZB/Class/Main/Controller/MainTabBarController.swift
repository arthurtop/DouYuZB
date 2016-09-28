//
//  MainTabBarController.swift
//  DouYuZB
//
//  Created by songlei on 2016/9/29.
//  Copyright © 2016年 songlei. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC(storyboardName: "Home")
        addChildVC(storyboardName: "Live")
        addChildVC(storyboardName: "Follow")
        addChildVC(storyboardName: "Podfile")
        
        
        
    }
    
    private func addChildVC(storyboardName: String) {
        let childVc = UIStoryboard.init(name: storyboardName, bundle: nil).instantiateInitialViewController()!
        
        addChildViewController(childVc)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
