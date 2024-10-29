import UIKit

class CategoryCell: UICollectionViewCell {
    static var identifier: String { return String(describing: self) }
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool
    {
        didSet {
            if isSelected {
               backgroundColor = .purplePrimary
                label.textColor = .white
            } else {
                backgroundColor = .grayLighter
                label.textColor = .grayPrimary
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layer.cornerRadius = 12
        clipsToBounds = true
        addSubview(label)
        setupConstraints()
    }
    
    func configureCell(categoryName: String) {
        label.text = categoryName
    }
    
    
}

extension CategoryCell {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
}
