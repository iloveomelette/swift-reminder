import UIKit

class ReminderViewController: UICollectionViewController {
  /*
   * <Int, Row>: Data sources are generic.
   * By specifying Int and Row generic parameters,
   * you instruct the compiler that your data source uses instances of Int for the section numbers
   * and instances of Row—the custom enumeration that you defined in the previous section—for the list rows.
   */
  private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
  private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>

    var reminder: Reminder
    var workingReminder: Reminder
    private var dataSource: DataSource!

    init(reminder: Reminder) {
        self.reminder = reminder
        self.workingReminder = reminder
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false
        listConfiguration.headerMode = .firstItemInSection
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
    if #available(iOS 16, *) {
      navigationItem.style = .navigator
    }
    navigationItem.title = NSLocalizedString("Reminder", comment: "Reminder view controller title")
    navigationItem.rightBarButtonItem = editButtonItem

    updateSnapshotForViewing()
  }

  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    if editing {
      prepareForEditing()
    } else {
      prepareForViewing()
    }
  }

    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        let section = section(for: indexPath)
        switch (section, row) {
        /*
         * This case configures the title for every section.
         */
        case (_, .header(let title)):
                cell.contentConfiguration = headerConfiguration(for: cell, with: title)
        /*
         * The underscore character (_) is a wildcard that matches any row value.
         */
        case (.view, _):
                cell.contentConfiguration = defaultConfiguration(for: cell, at: row)
        case (.title, .editableText(let title)):
                cell.contentConfiguration = titleConfiguration(for: cell, with: title)
        case(.date, .editableDate(let date)):
            cell.contentConfiguration = dateConfiguration(for: cell, with: date)
        case (.notes, .editableText(let notes)):
            cell.contentConfiguration = notesConfiguration(for: cell, with: notes)
        default: fatalError("Unexpected combination of section and row.")
        }
        cell.tintColor = .todayPrimaryTint
    }

    private func prepareForEditing() {
        updateSnapshotForEditing()
    }

    private func updateSnapshotForEditing() {
        var snapshot = Snapshot()
        snapshot.appendSections([.title, .date, .notes])
        snapshot.appendItems([.header(Section.title.name), .editableText(reminder.title)], toSection: .title)
        snapshot.appendItems([.header(Section.date.name), .editableDate(reminder.dueDate)], toSection: .date)
        snapshot.appendItems([.header(Section.notes.name), .editableText(reminder.notes)], toSection: .notes)
        dataSource.apply(snapshot)
    }

    private func prepareForViewing() {
        if workingReminder != reminder {
            reminder = workingReminder
        }
        updateSnapshotForViewing()
    }

  private func updateSnapshotForViewing() {
    var snapShot = Snapshot()
    /*
     * `[0]` represents an array of section identifiers, in this case only one section has been added.
     */
    snapShot.appendSections([.view])
    snapShot.appendItems([Row.header(""), Row.title, Row.date, Row.time, Row.notes], toSection: .view)
    /*
     * This snapshot must be applied to the data source in order for the changes to be reflected in the view.
     */
    dataSource.apply(snapShot)
  }

  private func section(for indexPath: IndexPath) -> Section {
    /*
     * In view mode, all items are displayed in section 0.
     * In editing mode, the title, date, and notes are separated into sections 1, 2, and 3, respectively.
     */
    let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section
    guard let section = Section(rawValue: sectionNumber) else {
      fatalError("Unable to find matching section")
    }
    return section
  }
}
