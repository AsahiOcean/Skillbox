import UIKit

public class MultiScrollVCCell: UICollectionViewCell {
    var container: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var iconView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.cornerRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var cellTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var cellDescription: UILabel = {
        let label: UILabel = UILabel()
        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Разметка
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.container)
        self.container.addSubview(self.iconView)
        self.container.addSubview(self.cellTitle)
        self.container.addSubview(self.cellDescription)
        
        NSLayoutConstraint.activate([
            self.container.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.container.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.container.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
        NSLayoutConstraint.activate([
            self.iconView.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 10),
            self.iconView.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 10),
            self.iconView.widthAnchor.constraint(equalToConstant: 40),
            self.iconView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            self.cellTitle.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 8),
            self.cellTitle.leftAnchor.constraint(equalTo: self.iconView.rightAnchor, constant: 10),
            self.cellTitle.rightAnchor.constraint(equalTo: self.container.rightAnchor)
        ])
        NSLayoutConstraint.activate([
            self.cellDescription.topAnchor.constraint(equalTo: self.cellTitle.bottomAnchor, constant: 0),
            self.cellDescription.leftAnchor.constraint(equalTo: self.iconView.rightAnchor, constant: 10),
            self.cellDescription.rightAnchor.constraint(equalTo: self.container.rightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) не реализован")
    }
}
