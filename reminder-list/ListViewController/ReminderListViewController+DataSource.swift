import UIKit

extension ReminderListViewController {
  /*
   * Type aliases are helpful for referring to an existing type with a name that’s more expressive.
   * UICollectionViewDiffableDataSource: Manage `UICollectionView` data.
   */
  typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
  typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
  
  func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
    let reminder = Reminder.sampleData[indexPath.item]
    var contentConfiguration = cell.defaultContentConfiguration() // This func creates a content configuration with the predefined system style.
    contentConfiguration.text = reminder.title
    contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
    contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
    cell.contentConfiguration = contentConfiguration
    
    var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
    backgroundConfiguration.backgroundColor = .todayListCellBackground
    cell.backgroundConfiguration = backgroundConfiguration
  }
}
