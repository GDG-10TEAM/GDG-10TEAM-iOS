import UIKit

final class CalendarViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
    }
    
    private func configureView() {
        let calendarTitleAttrs = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 21, weight: .bold)
        ]
        
        UINavigationBar.appearance().titleTextAttributes = calendarTitleAttrs
        
        self.title = "LOGO"
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        TaskEditViewController.taskEditInitializer(viewController: self)
    }
}
