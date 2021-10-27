import UIKit

class NewsCollectionViewAdapter: NSObject {
    
    private let collectionView: UICollectionView
    private var dataSource: [DataModel]
    var cellTapCallback: (DataModel) -> ()  = { _ in }
    
    init(with collectionView: UICollectionView, dataSource: [DataModel]) {
        collectionView.registerCell(NewsCollectionViewCell.self)
        self.collectionView = collectionView
        self.dataSource = dataSource
    }
    
    private func configureCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.nameOfClass, for: indexPath) as? NewsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.descriptionLabel.text = dataSource[indexPath.row].description
        cell.headLineLabel.text = dataSource[indexPath.row].headLineText
        NetworkManager.shared.getImage(url: dataSource[indexPath.row].imageUrl) { image in
            DispatchQueue.main.async {
                cell.postImageView.image = image
            }
        }
        return cell
    }
    
}

extension NewsCollectionViewAdapter: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        configureCell(collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return NewsCollectionViewFlowLayoutType(frame: collectionView.frame).sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return NewsCollectionViewFlowLayoutType(frame: collectionView.frame).sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return NewsCollectionViewFlowLayoutType(frame: collectionView.frame).sizeForItem
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return NewsCollectionViewFlowLayoutType(frame: collectionView.frame).sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellTapCallback(dataSource[indexPath.row])
    }
    
}
