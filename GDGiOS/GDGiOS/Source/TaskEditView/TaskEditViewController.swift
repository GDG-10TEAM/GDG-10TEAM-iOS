//
//  TaskEditViewController.swift
//  GDGiOS
//
//  Created by 김민창 on 2022/06/25.
//

import UIKit

protocol TaskEditViewControllerDelegate: AnyObject {
    
}


final class TaskEditViewController: BaseViewController {
    
    static func taskEditInitializer() -> TaskEditViewController {
        let storyboard = UIStoryboard(name: StoryBoard.taskEdit, bundle: .main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: Self.className) as? TaskEditViewController else {
            return TaskEditViewController()
        }
        return viewController
    }
    
    weak var delegate: TaskEditViewControllerDelegate? = nil
}
