import UIKit

class ItemsViewController: UICollectionViewController {
    
    private enum PresentationStyle: String, CaseIterable {
        case table
        case defaultGrid
        case customGrid
        
        var buttonImage: UIImage {
            switch self {
            case .table: return #imageLiteral(resourceName: "table")
            case .defaultGrid: return #imageLiteral(resourceName: "default_grid")
            case .customGrid: return #imageLiteral(resourceName: "custom_grid")
            }
        }
    }
    
    private var selectedStyle: PresentationStyle = .table {
        didSet { updatePresentationStyle() }
    }
    private var styleDelegates: [PresentationStyle: CollectionItemDelegate] = {
        let result: [PresentationStyle: CollectionItemDelegate] = [
            .table: TableViewDelegate(),
            .defaultGrid: DefaultGridDelegate(),
            .customGrid: GridDelegate(),
        ]
        result.values.forEach { $0.didSelectItem = { _ in
        }}
        return result
    }()
    
    private var ItemsCell: [Items] = ItemsProvider.get()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = .red
        
        self.collectionView.register(ItemCollectionViewCell.nib,
            forCellWithReuseIdentifier: ItemCollectionViewCell.reuseID)
        collectionView.contentInset = .zero
        updatePresentationStyle()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: selectedStyle.buttonImage, style: .plain, target: self, action: #selector(changeContentLayout))
    }
    
    private func updatePresentationStyle() {
        collectionView.delegate = styleDelegates[selectedStyle]
        collectionView.performBatchUpdates({
            collectionView.reloadData()
        }, completion: nil)

        navigationItem.rightBarButtonItem?.image = selectedStyle.buttonImage
    }
    
    @objc private func changeContentLayout() {
        let allCases = PresentationStyle.allCases
        guard let index = allCases.firstIndex(of: selectedStyle) else { return }
        let nextIndex = (index + 1) % allCases.count
        selectedStyle = allCases[nextIndex]
    }
}


extension ItemsViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ItemsCell.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.reuseID,
    for: indexPath) as? ItemCollectionViewCell else {
        fatalError("Нет ячейки")
    }
    let cellitem = ItemsCell[indexPath.item]
    
    cell.update(title: cellitem.name, image: cellitem.img)
    return cell
    }
}
