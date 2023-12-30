import UIKit

struct UIHelper {
    static func createThreeColumnFlowLayout(width: CGFloat) -> UICollectionViewFlowLayout {
        let padding             = 12.0
        let spacing             = 10.0
        let availableWidth      = width - (padding + spacing) * 2
        let itemWidth           = availableWidth / 3
        let flowLayout          = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize     = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
    }
}
