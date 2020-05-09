import UIKit

class SingleProductViewController: UIViewController {

    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var UIViewScroll: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBAction func buyAction(_ sender: Any) {
        let popoverSizes = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopoverSize") as! PopoverSizeViewController
        guard let product = self.product else { return }
        self.addChild(popoverSizes)
        popoverSizes.view.frame = self.view.frame
        popoverSizes.product = product
        self.view.addSubview(popoverSizes.view)
        popoverSizes.didMove(toParent: self)
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var attributesStackView: UIStackView!
    @IBOutlet weak var attributesStackViewLine: UIStackView!
    @IBOutlet weak var attributeName: UILabel!
    @IBOutlet weak var attributeData: UILabel!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scroll); addImage()
        self.refactorDescription()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
        
        buyButton.layer.cornerRadius = 10
        
        guard let product = self.product else {return}
        addAttributes(product: product)
        pageControl.numberOfPages = 1 + (product.arrayImageLinks?.count ?? 0)
        descriptionLabel.text = product.description
        nameLabel.text = product.name
        priceLabel.text = product.price + "₽"
    }
    
    override func viewWillLayoutSubviews(){
    super.viewWillLayoutSubviews()
    scroll.contentSize = CGSize(width: 375, height: 1000)
    }
    
    private func addImage(){
        guard let product = self.product, let arrayLinks = product.arrayImageLinks else { return }
        for value in arrayLinks {
            Loader().loadImage(link: value) {
                gotImage in
                self.product?.gallery.append(gotImage)
            }
        }
    }
    
    private func refactorDescription() {
        guard let string = self.product?.description else {return}
        self.product?.description = string.replacingOccurrences(of: "&nbsp;", with: " ")
    }
    
    private func addAttributes(product: Product) {
        var attributes = product.productAttributes
            
        guard attributes.count != 0 else {
            (attributeName.text,attributeData.text) = ("","")
            return
        }
        
        let firstData = attributes.removeFirst()
        attributeName.text = firstData.first!.key + ":"
        attributeData.text = firstData.first?.value
       
        for dictinory in attributes {
            for (key, value) in dictinory {
                let newStack = UIStackView()
                newStack.frame = attributesStackViewLine.frame

                let newAttributeName = UILabel()
                newAttributeName.frame = attributeName.frame
                newAttributeName.font = attributeName.font
                newAttributeName.text = key + ":"

                let newAttributeData = UILabel()
                newAttributeData.frame = attributeData.frame
                newAttributeData.font = attributeData.font
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
