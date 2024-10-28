import UIKit

class CategoryCell: UICollectionViewCell {
    static var identifier: String { return String(describing: self) }
    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
