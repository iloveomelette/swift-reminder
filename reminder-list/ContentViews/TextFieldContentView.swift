import UIKit

class TextFieldContentView: UIView {
    let textField = UITextField()

    /*
     * Setting this property allows a custom view to communicate its preferred size to the layout system.
     */
    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 44)
    }

    init() {
        super.init(frame: .zero)
        addPinnedSubview(textField, insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        /*
         * This property directs the text field to display a Clear Text button on its trailing side
         * when it has contents, providing a way for the user to remove text quickly.
         */
        textField.clearButtonMode = .whileEditing
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
