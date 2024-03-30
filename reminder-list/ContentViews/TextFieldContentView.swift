import UIKit

/*
 * Adopting this protocol signals that this view renders the content and styling that you define within a configuration.
 * The content view’s configuration provides values for all supported properties and behaviors to customize the view.
 */
class TextFieldContentView: UIView, UIContentView {
    struct Configuration: UIContentConfiguration {
        var text: String? = ""

        func makeContentView() -> UIView & UIContentView {
            return TextFieldContentView(self)
        }
    }

    let textField = UITextField()
    /*
     * `: UIContentConfiguration` is called the type annotation and specifies the type of the variable.
     * Here, it is declared to be of type UIContentConfiguration.
     * The type annotation defines the type of values the variable can hold.
     * However, specific values have not yet been set at this time.
     */
    var configuration: UIContentConfiguration

    /*
     * Setting this property allows a custom view to communicate its preferred size to the layout system.
     */
    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 44)
    }

    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
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
