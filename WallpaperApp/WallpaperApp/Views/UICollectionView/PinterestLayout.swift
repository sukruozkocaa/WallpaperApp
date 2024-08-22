//
//  PinterestLayout.swift
//  WallpaperApp
//
//  Created by Şükrü on 22.08.2024.
//

import Foundation
import UIKit

// MARK: - PinterestLayoutDelegate
protocol PinterestLayoutDelegate: AnyObject {
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat
}

// MARK: - PinterestLayout
final class PinterestLayout: UICollectionViewLayout {
    
    // MARK: - Variables
    weak var delegate: PinterestLayoutDelegate?
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    fileprivate var contentHeight: CGFloat = .zero
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return .zero
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    var numberOfColumns: Int = 2 {
        didSet {
            invalidateLayout()
        }
    }
    var cellXMargin: CGFloat = 1.0 {
        didSet {
            invalidateLayout()
        }
    }
    var cellYMargin: CGFloat = 1.0 {
        didSet {
            invalidateLayout()
        }
    }
    
    // MARK: - CollectionViewContentSize
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    // MARK: - Prepare
    override func prepare() {
        guard cache.isEmpty, let collectionView = collectionView else { return }
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        let xOffset = (.zero..<numberOfColumns).map { CGFloat($0) * columnWidth }
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        var column: Int = .zero
        
        for item in .zero..<collectionView.numberOfItems(inSection: .zero) {
            let indexPath = IndexPath(item: item, section: .zero)
            let photoHeight = delegate?.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath) ?? .zero
            let height = cellYMargin * 2 + photoHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellXMargin, dy: cellYMargin)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] += height
            column = (column + 1) % numberOfColumns
        }
    }
    
    // MARK: - LayoutAttributesForElements
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.filter { $0.frame.intersects(rect) }
    }
    
    // MARK: - LayoutAttributesForItem
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
