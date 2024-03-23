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
  var reminders: [Reminder] = Reminder.sampleData

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
      /*
       * `Reminder.ID` is the associated type of the Identifiable protocol.
       * It’s a type alias for String in the case of Reminder.
       */
      (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Reminder.ID) in
      return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
    }

    updateSnapshot()

    /*
     * Assign the data source to the collection view.
     */
    collectionView.dataSource = dataSource
  }
  
  /*
   * You aren’t showing the item that the user tapped as selected, so return false.
   * Instead, you’ll transition to the detail view for that list item.
   */
  override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    let id = reminders[indexPath.item].id
    /*
     * This method adds a detail view controller to the navigation stack,
     * causing a detail view to push onto the screen.
     * The detail view displays the reminder details for the provided identifier.
     * And a Back button appears automatically as the leading item in the navigation bar.
     */
    pushDetailViewForReminder(withId: id)
    return false
  }
  
  func pushDetailViewForReminder(withId id: Reminder.ID) {
    let reminder = reminder(withId: id)
    let viewController = ReminderViewController(reminder: reminder)
    /*
     * If a view controller is currently embedded in a navigation controller,
     * a reference to the navigation controller is stored in the optional navigationController property.
     */
    navigationController?.pushViewController(viewController, animated: true)
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
