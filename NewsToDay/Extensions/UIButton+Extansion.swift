import UIKit

extension UIButton {
    enum buttonColor {
        case purplePrimary
        case greyLighter
        
        var color: UIColor {
            switch self {
            case .purplePrimary:
                return .purplePrimary ?? .purple
            case .greyLighter:
                return .grayLighter ?? .systemGray
            }
        }
    }
    
    enum textColor {
        case grayDark
        case white
        
        var color: UIColor {
            switch self {
            case .white:
                return .white
            case .grayDark:
                return .grayDark ?? .systemGray
            }
        }
    }
    
    func makeButtonwithLabel(label: String, buttonColor: buttonColor, textColor: textColor, target: Any?, action: Selector) -> UIButton {
        let button = UIButton()
        button.backgroundColor = buttonColor.color
        button.setTitle(label, for: .normal)
        button.setTitleColor(textColor.color, for: .normal)
        button.titleLabel?.font = .interMedium
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(target, action: action, for: .touchUpInside)
        
    
        return button
    }
   
}
