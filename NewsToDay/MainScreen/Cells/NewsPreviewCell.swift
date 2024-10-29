import UIKit

class NewsPreviewCell: UICollectionViewCell {
    
    static var identifier: String { return String(describing: self) }
    
    let label = UILabel()
    let subLabel = UILabel()
    let imageView = UIImageView()
   // let bookmarkButton = UIButton()
    
    private lazy var  bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setBackgroundImage(UIImage(named: "bookmarks"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(self, action: #selector("closeButtonTapped"), for: .touchUpInside)
        return button
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        setupElements()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupElements() {
        label.translatesAutoresizingMaskIntoConstraints = false
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        label.numberOfLines = 0
        subLabel.numberOfLines = 0
        
        addSubview(imageView)
        addSubview(bookmarkButton)
        addSubview(label)
        addSubview(subLabel)
        
    }
    
    func configure(item: ListItem) {
        label.text = item.title
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 24)
        subLabel.text = item.subtitle
        subLabel.textColor = .white
        subLabel.font = .boldSystemFont(ofSize: 18)
        imageView.image = UIImage(named: item.image)
    }
    
    
}

extension NewsPreviewCell {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            bookmarkButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            bookmarkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 24),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 24),
            
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 160),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            label.heightAnchor.constraint(equalToConstant: 16),
            
            subLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            subLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            subLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 24)
            
            ])
    }
}
