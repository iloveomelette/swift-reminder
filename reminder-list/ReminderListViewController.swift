import UIKit

class ReminderListViewController: UICollectionViewController {

  /*
   * After the view controller loads its view hierarchy into memory,
   * the system calls viewDidLoad().
   */
  override func viewDidLoad() {
    super.viewDidLoad()

    let listLayout = listLayout()
    collectionView.collectionViewLayout = listLayout // Assign the list layout to the collection view layout.
  }

  /*
   * UICollectionViewCompositionalLayout:
   * It’s designed to be composable, flexible, and fast,
   * letting you build any kind of visual arrangement
   * for your content by combining — or compositing —
   * each smaller component into a full layout.
   * doc: https://developer.apple.com/documentation/uikit/uicollectionviewcompositionallayout
   */
  private func listLayout() -> UICollectionViewCompositionalLayout {
    /*
     * UICollectionLayoutListConfiguration:
     * A configuration for creating a list layout.
     * Use this configuration to create a list section for a compositional layout (UICollectionViewCompositionalLayout),
     * or a layout containing only list sections.
     */
    var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
    listConfiguration.showsSeparators = false
    listConfiguration.backgroundColor = .clear
    return UICollectionViewCompositionalLayout.list(using: listConfiguration)
  }
}
