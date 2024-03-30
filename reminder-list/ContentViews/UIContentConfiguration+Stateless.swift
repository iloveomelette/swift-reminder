import UIKit

extension UIContentConfiguration {
    /*
     * The updated(for:) method allows a UIContentConfiguration to provide a specialized configuration for a given state.
     * In Today, you’ll use the same configuration for all states, including normal, highlighted, and selected.
     */
    func updated(for state: UIConfigurationState) -> Self {
        return self
    }
}
