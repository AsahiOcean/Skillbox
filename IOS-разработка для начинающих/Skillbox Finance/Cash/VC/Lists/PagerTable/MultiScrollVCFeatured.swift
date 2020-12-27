import UIKit

public class MultiScrollVCFeatured: UICollectionViewCell {
    
    var container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.cornerRadius = 20
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(26)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var subtitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.container)
        self.container.addSubview(self.titleLabel)
        self.container.addSubview(self.subtitleLabel)
        
        NSLayoutConstraint.activate([
            self.container.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.container.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.container.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 20),
            self.titleLabel.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 20),
            self.titleLabel.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            self.subtitleLabel.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 20),
            self.subtitleLabel.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) не реализован")
    }
    
    public func setup(title: String, subtitle: String) {
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
    }
}
