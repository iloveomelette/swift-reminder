import UIKit

extension UIView {
    func addPinnedSubview(_ subview: UIView, height: CGFloat? = nil, insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)) {
        addSubview(subview)
        /*
         * You’ll provide constraints that dynamically lay out the view for any size or orientation.
         */
        subview.translatesAutoresizingMaskIntoConstraints = false
        /*
         * Pin the subview to the top of the superview by adding and activating a top anchor constraint.
         * Assigning true to isActive adds the constraint to the common ancestor in the view hierarchy and then activates it.
         */
        subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top).isActive = true
        /*
         * Auto Layout determines a view’s neighbors along the horizontal axis using leading and trailing instead of left and right.
         * This approach allows Auto Layout to automatically correct a view’s appearance in both right-to-left and left-to-right languages.
         */
        subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left).isActive = true
        subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1.0 * insets.right).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0 * insets.bottom).isActive = true

        /*
         * Because the subview is pinned to the top and bottom of the superview,
         * adjusting the height of the subview forces the superview to also adjust its height.
         */
        if let height {
            subview.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
