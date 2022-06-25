import UIKit

enum TabbarItem {
    case home
    case calendar
    case profile
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .profile: return "Profile"
        case .calendar: return "Calender"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .home: return UIImage(systemName: "pawprint")
        case .profile: return UIImage(systemName: "person")
        case .calendar: return UIImage(systemName: "calendar")
        }
    }
}
