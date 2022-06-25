import UIKit

final class CalendarViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
    }
    
    private func configureView() {
        
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        TaskEditViewController.taskEditInitializer(viewController: self)
    }
}
