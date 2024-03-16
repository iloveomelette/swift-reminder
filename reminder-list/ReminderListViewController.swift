import UIKit

class ReminderListViewController: UICollectionViewController {
  /*
   * Type aliases are helpful for referring to an existing type with a name that’s more expressive.
   * UICollectionViewDiffableDataSource: Manage `UICollectionView` data.
   */
  typealias DataSource = UICollectionViewDiffableDataSource<Int, String>

  /*
   * Warning!!
   * Use implicitly unwrapped optionals only
   * **when you know that the optional will have a value.**
   * Otherwise, you risk triggering a runtime error
   * that immediately terminates the app.
   * You’ll initialize the data source in the next step
   * to guarantee that the optional has a value.
   */
  var dataSource: DataSource!

  /*
   * After the view controller loads its view hierarchy into memory,
   * the system calls viewDidLoad().
   */
  override func viewDidLoad() {
    super.viewDidLoad()

    let listLayout = listLayout()
    collectionView.collectionViewLayout = listLayout // Assign the list layout to the collection view layout.

    let cellRegistration = UICollectionView.CellRegistration {
      (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
      let reminder = Reminder.sampleData[indexPath.item]
      var contentConfiguration = cell.defaultContentConfiguration() // This func creates a content configuration with the predefined system style.
      contentConfiguration.text = reminder.title
      cell.contentConfiguration = contentConfiguration
    }

    dataSource = DataSource(collectionView: collectionView) {
      (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
      return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
    }
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
