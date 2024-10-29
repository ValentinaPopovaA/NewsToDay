import Foundation

enum ListSection {
    case category([ListItem])
    case newsPreview([ListItem])
    case recommended([ListItem])
    
    
    var items: [ListItem] {
        switch self {
        case .category(let items):
            return items
        case .newsPreview(let items):
            return items
        case .recommended(let items):
            return items
        }
    }
    
    var count: Int {
        items.count
    }
    
    var title: String {
        switch self {
        case .category(_):
            return ""
        case .newsPreview(_):
            return ""
        case .recommended(_):
            return "Recommended for you"
        }
    }
}
