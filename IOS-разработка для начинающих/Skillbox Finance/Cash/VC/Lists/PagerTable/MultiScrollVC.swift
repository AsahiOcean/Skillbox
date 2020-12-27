import UIKit

fileprivate let GALLERY_SECTION: [Int] = [0, 2]
fileprivate let TEXT_SECTION: [Int] = [3]
fileprivate let LIST_SECTION: [Int] = [1, 4]

class MultiScrollVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.makeLayout())
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MultiScrollVCCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(MultiScrollVCFeatured.self, forCellWithReuseIdentifier: "featured")
        collectionView.register(MultiScrollVCText.self, forCellWithReuseIdentifier: "text")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            if GALLERY_SECTION.contains(section) {
                return
                    
                    LayoutBuilderMultiScroll.buildGallerySectionLayout(size: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.25)))
            } else if TEXT_SECTION.contains(section) {
                return
                    LayoutBuilderMultiScroll.buildTextSectionLayout()
            } else {
                return
                    LayoutBuilderMultiScroll.buildTableSectionLayout()
            }
        }
        return layout
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if GALLERY_SECTION.contains(section) {
            return 3
        }
        if TEXT_SECTION.contains(section) {
            return 1
        }
        if LIST_SECTION.contains(section) {
            return 5
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if GALLERY_SECTION.contains(indexPath.section) {
            return
                CellBuilderMultiScroll.getFeaturedCell(collectionView: collectionView, indexPath: indexPath)
        }
        if TEXT_SECTION.contains(indexPath.section) {
            return
                CellBuilderMultiScroll.getTextCell(collectionView: collectionView, indexPath: indexPath)
        }
        if LIST_SECTION.contains(indexPath.section) {
            return
                CellBuilderMultiScroll.getListCell(collectionView: collectionView, indexPath: indexPath)
        }
        return UICollectionViewCell()
    }
}
