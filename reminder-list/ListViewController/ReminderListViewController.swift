import UIKit

class ReminderListViewController: UICollectionViewController {
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

    let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)

    dataSource = DataSource(collectionView: collectionView) {
      (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
      return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
    }

    var snapshot = Snapshot()
    snapshot.appendSections([0])
    var reminderTitles = [String]()
    /*
     *  for reminder in Reminder.sampleData {
     *    reminderTitles.append(reminder.title)
     *  }
     * Shorten the code you added above.
     */
    snapshot.appendItems(Reminder.sampleData.map { $0.title })
    /*
     * Applying the snapshot reflects the changes in the user interface.
     */
    dataSource.apply(snapshot)

    /*
     * Assign the data source to the collection view.
     */
    collectionView.dataSource = dataSource
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
