import UIKit
import RealmSwift

var EventText = [String]()

public class CellBuilderMultiScroll {
    public static func getFeaturedCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "featured", for: indexPath) as? MultiScrollVCFeatured {
            let realm = try! Realm()
            //        var btc: Results<BitCoinObject>!
            let btcrate = realm.objects(BitCoinObject.self)
            cell.setup(title: "Курс BitCoin", subtitle:
                        "\(btcrate.last!.When)\nUSD: \(btcrate.last!.USD)\nEUR: \(btcrate.last!.EUR)\nRUB: \(btcrate.last!.RUB)")
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    public static func getTextCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "text", for: indexPath) as? MultiScrollVCText {
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    public static func getListCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let CellIndex = indexPath.row
        let minicell = MiniCells[CellIndex]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MultiScrollVCCell {
            cell.cellTitle.text = minicell.title
            cell.cellDescription.text = minicell.description
            cell.iconView.backgroundColor = UIColor(rgb: minicell.color)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
