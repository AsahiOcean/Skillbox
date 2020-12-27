import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var Label: UILabel!
    
    static let reuseID = String(describing: ItemCollectionViewCell.self)
    static let nib = UINib(nibName: String(describing: ItemCollectionViewCell.self), bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        transitions()
    }
    
    func update(title: String, image: UIImage) {
        Image.image = image; Label.text = title
    }
    
    private func transitions() {
        let isHorizontalStyle = bounds.width > 3 * bounds.height
        let oldAxis = stackView.axis
        let newAxis: NSLayoutConstraint.Axis = isHorizontalStyle ? .horizontal : .vertical
        guard oldAxis != newAxis else { return }
        
        stackView.axis = newAxis
        stackView.spacing = isHorizontalStyle ? 16 : 4
        Label.textAlignment = isHorizontalStyle ? .left : .center
        
        let fontTransform: CGAffineTransform = isHorizontalStyle ? .identity : CGAffineTransform(scaleX: 0.75, y: 0.75)
        UIView.animate(withDuration: 0.25) {
            self.Label.transform = fontTransform
            self.layoutIfNeeded()
        }}
}
