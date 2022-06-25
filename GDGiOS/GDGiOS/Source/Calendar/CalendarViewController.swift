import UIKit

final class CalendarViewController: BaseViewController {
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var calendarView: CustomCalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "LOGO"
    }
    
    private func configureView() {
        let calendarTitleAttrs = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 21, weight: .bold)
        ]
        
        UINavigationBar.appearance().titleTextAttributes = calendarTitleAttrs
        
        self.calendarView.delegate = self
        
        EditViewController.editInitializer(viewController: self)
    }
}


extension CalendarViewController: CustomCalenderViewDelegate {
    func didSelectedDate(date: Date) {
        CalendarDetailViewController.calendarDetailInitializer(viewController: self, currentDay: date)
    }
}
