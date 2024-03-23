import UIKit

class ReminderViewController: UICollectionViewController {
  /*
   * <Int, Row>: Data sources are generic.
   * By specifying Int and Row generic parameters,
   * you instruct the compiler that your data source uses instances of Int for the section numbers
   * and instances of Row—the custom enumeration that you defined in the previous section—for the list rows.
   */
  private typealias DataSource = UICollectionViewDiffableDataSource<Int, Row>
  private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Row>

  var reminder: Reminder
  private var dataSource: DataSource!
  
  init(reminder: Reminder) {
    self.reminder = reminder
    var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
    listConfiguration.showsSeparators = false
    let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
    super.init(collectionViewLayout: listLayout)
  }
  
  required init?(coder: NSCoder) {
    fatalError("Always initialize ReminderViewController using init(reminder:)")
  }
  
  /*
   * You’ll intervene in the view controller’s life cycle to register the cell with the collection view
   * and create the data source after the view loads.
   * When you override a view controller’s life cycle method,
   * you first give the superclass a chance to perform its own tasks prior to your custom tasks.
   */
  override func viewDidLoad() {
    super.viewDidLoad()
    /*
     * Assign the result to a constant named cellRegistration.
     */
    let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
    /*
     * Lists in your app can potentially hold many more items than can fit onscreen.
     * To avoid unnecessary cell creation, the system maintains a queue of collection cells to recycle after they go offscreen.
     */
    dataSource = DataSource(collectionView: collectionView) {
      (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Row) in
      return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
    }
    
    updateSnapshot()
  }
  
  func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
    var contentConfiguration = cell.defaultContentConfiguration()
    contentConfiguration.text = text(for: row)
    contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
    contentConfiguration.image = row.image
    cell.contentConfiguration = contentConfiguration
    cell.tintColor = .todayPrimaryTint
  }
  
  func text(for row: Row) -> String? {
    switch row {
    case .date: return reminder.dueDate.dayText
    case .notes: return reminder.notes
    case .time: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
    case .title: return reminder.title
    }
  }
  
  private func updateSnapshot() {
    var snapShot = Snapshot()
    /*
     * `[0]` represents an array of section identifiers, in this case only one section has been added.
     */
    snapShot.appendSections([0])
    snapShot.appendItems([Row.title, Row.date, Row.time, Row.notes], toSection: 0)
    /*
     * This snapshot must be applied to the data source in order for the changes to be reflected in the view.
     */
    dataSource.apply(snapShot)
  }
}
