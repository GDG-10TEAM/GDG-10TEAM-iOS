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
        
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
         
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: .main)
        let mainViewController = mainStoryBoard.instantiateViewController(withIdentifier: "MainViewController")
        let mainNavigation = UINavigationController(rootViewController: mainViewController)
        let homeTabbarItem = TabbarItem.home
        mainNavigation.title = homeTabbarItem.title
        mainNavigation.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "icon_home"), tag: 0)
        
        let calendarStoryboard = UIStoryboard(name: StoryBoard.calendar, bundle: .main)
        let calenderViewController = calendarStoryboard
            .instantiateViewController(withIdentifier: CalendarViewController.className)
        let calenderNavigation = UINavigationController(rootViewController: calenderViewController)
        let calendarTabbarItem = TabbarItem.calendar
        calenderNavigation.title = calendarTabbarItem.title
        calenderNavigation.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "icon_calender"), tag: 1)
        
        self.viewControllers = [mainNavigation, calenderNavigation]
    }
}

