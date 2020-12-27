import UIKit

class SingleProductViewController: UIViewController {
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var UIViewScroll: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var attributesStackView: UIStackView!
    @IBOutlet weak var attributesStackViewLine: UIStackView!
    @IBOutlet weak var attributeName: UILabel!
    @IBOutlet weak var attributeData: UILabel!
    @IBOutlet weak var deletepopover: UIButton!
    
    @IBAction func buyAction(_ sender: Any) {
        let popoverSizes = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopoverSize") as! PopoverSizeViewController
        guard let product = self.product else { return }
        self.addChild(popoverSizes)
        popoverSizes.view.frame = CGRect(x: .zero, y: self.view.frame.midY+200, width: self.view.frame.width, height: view.frame.height)
        popoverSizes.product = product
        self.view.addSubview(popoverSizes.view)
        popoverSizes.didMove(toParent: self)
        self.deletepopover.isHidden = false
    }
    
    @IBAction func deletePop(_ sender: Any) {
        if self.children.count > 0 {
            let viewControllers:[UIViewController] = self.children
            for viewContoller in viewControllers{
                viewContoller.willMove(toParent: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParent()
            }
        }
    }
    
    var product: Product?
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scroll); addImage()
        self.refactorDescription()
        buyButton.layer.cornerRadius = 10
        guard let product = self.product else {return}
        addAttributes(product: product)
        pageControl.numberOfPages = 1 + (product.arrayImageLinks?.count ?? 0)
        descriptionLabel.text = product.description
        nameLabel.text = product.name
        priceLabel.text = product.price + " ₽"
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
    }
    
    @objc func timerFunc() {
        if self.children.count == 0 {
            self.deletepopover.isHidden = true
        }}
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        // ни больше, ни меньше
        scroll.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + self.descriptionLabel.frame.height)
    }
    
    private func addImage(){
        guard let product = self.product, let arrayLinks = product.arrayImageLinks else { return }
        for value in arrayLinks {
            Loader().loadImage(link: value) { gotImage in
                self.product?.gallery.append(gotImage)
            }}
    }
    
    private func refactorDescription() {
        guard let string = self.product?.description
        else { return }
        self.product?.description = string.replacingOccurrences(of: "&nbsp;", with: " ")
    }
    
    private func addAttributes(product: Product) {
        var attributes = product.productAttributes
        
        let firstData = attributes.removeFirst()
        attributeName.text = firstData.first!.key + ":"
        attributeData.text = firstData.first?.value
        
        for dictinory in attributes {
            for (key, value) in dictinory {
                let newStack = UIStackView()
                newStack.frame = attributesStackViewLine.frame
                let newAttributeName = UILabel()
                newAttributeName.text = key + ":"
                if (newAttributeName.text?.hasPrefix("Уход"))! {
                    newAttributeName.text = "Уход:"
                }
                
                let newAttributeData = UILabel()
                newAttributeData.textColor = UIColor.lightGray
                newAttributeData.text = value
                
                newStack.addArrangedSubview(newAttributeName)
                newStack.addArrangedSubview(newAttributeData)
                
                newStack.distribution = .equalSpacing
                attributesStackView.addArrangedSubview(newStack)
            }
        }
    }
}

extension SingleProductViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let array = self.product?.arrayImageLinks else { return 0 }
        return array.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as! SliderCollectionViewCell
        guard let product = self.product else { return cell }
        
        if indexPath.row == 0 {
            cell.sliderImage.image = product.mainImage
        } else {
            cell.sliderImage.image = product.gallery[indexPath.row - 1]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / view.frame.width
        pageControl.currentPage = Int(scrollPos)
    }
}
