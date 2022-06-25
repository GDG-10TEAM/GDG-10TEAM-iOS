//
//  CalendarDetailViewController.swift
//  GDGiOS
//
//  Created by 김민창 on 2022/06/26.
//

import UIKit

final class CalendarDetailViewController: BaseViewController {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var calendarDetailTableView: UITableView!
    
    private var currentDay: Date = Date()
    private var dayFormatter = DateFormatter()
    
    static func calendarDetailInitializer(
        viewController: UIViewController,
        currentDay: Date
    ) {
        let storyboard = UIStoryboard(name: StoryBoard.calendarDetail, bundle: .main)
        guard let calendarDetailViewController = storyboard.instantiateViewController(withIdentifier: Self.className) as? CalendarDetailViewController else { return }
        
        calendarDetailViewController.currentDay = currentDay
        
        viewController.navigationController?.pushViewController(
            calendarDetailViewController, animated: true
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
    }
    
    private func configureView() {
        self.navigationController?.navigationBar.tintColor = .darkGray
        self.title = "LOGO"
        
        self.dayFormatter.dateFormat = "MM.dd"
        
        let dayString = dayFormatter.string(from: self.currentDay)
        self.dayLabel.text = dayString
    }
}
