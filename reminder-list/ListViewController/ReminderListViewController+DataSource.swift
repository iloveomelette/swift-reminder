import UIKit

extension ReminderListViewController {
  /*
   * Type aliases are helpful for referring to an existing type with a name that’s more expressive.
   * UICollectionViewDiffableDataSource: Manage `UICollectionView` data.
   */
  typealias DataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID>
  typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Reminder.ID>
  
  func updateSnapshot(reloading ids: [Reminder.ID] = []) {
    var snapshot = Snapshot()
    snapshot.appendSections([0])
    /*
     *  for reminder in Reminder.sampleData {
     *    reminderTitles.append(reminder.title)
     *  }
     * Shorten the code you added above.
     */
    snapshot.appendItems(reminders.map { $0.id })
    /*
     * If the array isn’t empty, instruct the snapshot to reload the reminders for the identifiers.
     */
    if !ids.isEmpty {
      snapshot.reloadItems(ids)
    }
    /*
     * Applying the snapshot reflects the changes in the user interface.
     */
    dataSource.apply(snapshot)
  }
  
  func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID) {
    let reminder = reminder(withId: id)
    var contentConfiguration = cell.defaultContentConfiguration() // This func creates a content configuration with the predefined system style.
    contentConfiguration.text = reminder.title
    contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
    contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
    cell.contentConfiguration = contentConfiguration

    var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
    doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint
    cell.accessories = [
      .customView(configuration: doneButtonConfiguration),
      .disclosureIndicator(displayed: .always)
    ]

    var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
    backgroundConfiguration.backgroundColor = .todayListCellBackground
    cell.backgroundConfiguration = backgroundConfiguration
  }

  /*
   * `for`: keyword argument.
   */
  private func doneButtonConfiguration(for reminder: Reminder) -> UICellAccessory.CustomViewConfiguration {
    let symbolName = reminder.isComplete ? "circle.fill" : "circle"
    let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
    let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
    let button = ReminderDoneButton()
    /*
     * During compilation, the system checks that the target,
     * `ReminderListViewController`, has a `didPressDoneButton(_:)` method.
     */
    button.addTarget(self, action: #selector(didPressDoneButton(_:)), for: .touchUpInside)
    button.id = reminder.id
    button.setImage(image, for: .normal)
    return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
  }
  
  func reminder(withId id: Reminder.ID) -> Reminder {
    let index = reminders.indexOfReminder(withId: id)
    return reminders[index]
  }
  
  func updateReminder(_ reminder: Reminder) {
    let index = reminders.indexOfReminder(withId: reminder.id)
    reminders[index] = reminder
  }
  
  func completeReminder(withId id: Reminder.ID) {
    var reminder = reminder(withId: id)
    reminder.isComplete.toggle()
    updateReminder(reminder)
    updateSnapshot(reloading: [id])
  }
}
