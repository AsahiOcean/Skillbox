import UIKit

class GridDelegate: ItemsDefGridDelegate {
    private let itemsPerRow: CGFloat = 2
    private let space: CGFloat = 1
    
    func collectionView(_ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath) -> CGSize {
        
    let itemSize: CGSize
    if indexPath.item % 3 == 0 {
    let itemWidth = collectionView.bounds.width - (sectionInsets.left + sectionInsets.right)
    itemSize = CGSize(width: itemWidth, height: 125)
    } else {
    // размеры между промежуточных картинок
    let indent = sectionInsets.left + sectionInsets.right + space * (itemsPerRow - 2)
    let availableWidth = collectionView.bounds.width - indent
    let widthPerItem = availableWidth / itemsPerRow
    itemSize = CGSize(width: availableWidth/2-itemsPerRow, height: widthPerItem)
    }
    return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 20
    }
    
    func collectionView(_ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
    return space
    }
}
