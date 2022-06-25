//
//  TabBarController.swift
//  GDGiOS
//
//  Created by Sujin Jin on 2022/06/25.
//

import UIKit



class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
         super.viewDidLoad()
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: .main)
        let mainViewController = mainStoryBoard.instantiateViewController(withIdentifier: "MainViewController")
        let homeTabbarItem = TabbarItem.home
        mainViewController.title = homeTabbarItem.title
        mainViewController.tabBarItem = UITabBarItem(title: nil, image: homeTabbarItem.image, tag: 0)
        
        
        let calendarStoryboard = UIStoryboard(name: StoryBoard.calendar, bundle: .main)
        let calenderViewController = calendarStoryboard
            .instantiateViewController(withIdentifier: CalendarViewController.className)
        let calendarTabbarItem = TabbarItem.calendar
        calenderViewController.title = calendarTabbarItem.title
        calenderViewController.tabBarItem = UITabBarItem(title: nil, image: calendarTabbarItem.image, tag: 1)
        
        self.viewControllers = [mainViewController, calenderViewController]
    }
}

