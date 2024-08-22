//
//  UICollectionView+Extensions.swift
//  WallpaperApp
//
//  Created by Şükrü on 22.08.2024.
//

import Foundation
import UIKit

// MARK: - UICollectionView Dequeue Reusable Extension
extension UICollectionView {
    private func reuseIndentifier<T>(for type: T.Type) -> String {
        return String(describing: type)
    }
    
    func register<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    public func register<T: UICollectionReusableView>(supplementaryView: T.Type, forSupplementaryViewOfKind kind: String) {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: reuseIndentifier(for: supplementaryView))
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(for type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: reuseIndentifier(for: type), for: indexPath) as? T else {
            fatalError("Failed to dequeue cell.")
        }
        return cell
    }
    
    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: String, for type: T.Type, for indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: reuseIndentifier(for: type), for: indexPath) as? T else {
            fatalError("Failed to dequeue supplementary view.")
        }
        return view
    }
}

// MARK: - UICollectionViewCell
extension UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
