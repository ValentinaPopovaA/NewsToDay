
import UIKit

class RecommendenCell: UICollectionViewCell {
    
    static var identifier: String { return String(describing: self) }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubview(imageView)
        addSubview(label)
        addSubview(subLabel)
        setupConstraints()
    }
    
    func configure (item: ListItem) {
        label.text = item.title
        subLabel.text = item.subtitle
        imageView.image = UIImage(named: item.image)
        
    }
    
}

extension RecommendenCell {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 96),
            imageView.widthAnchor.constraint(equalToConstant: 96),
            
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            subLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            subLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            subLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            subLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
            
            ])
    }
    
}
