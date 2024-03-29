import UIKit

protocol Reusable: AnyObject {}

extension Reusable {
    
    public static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController: Reusable {}
extension UIView: Reusable {}

protocol NibLoadable: AnyObject {
    
    static var nib: UINib { get }
}

extension NibLoadable where Self: UIViewController {
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

extension NibLoadable where Self: UIView {
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type) {
        
        self.register(T.classForCoder(), forCellWithReuseIdentifier: T.identifier)
    }
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: NibLoadable {
        
        self.register(T.nib, forCellWithReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError(">>> Could not dequeue cell with identifier: \(T.identifier)")
        }
        
        return cell
    }
}

extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) {
        
        self.register(T.classForCoder(), forCellReuseIdentifier: T.identifier)
    }
    
    func register<T: UITableViewCell>(_: T.Type) where T: NibLoadable {
        
        self.register(T.nib, forCellReuseIdentifier: T.identifier)
    }
}
