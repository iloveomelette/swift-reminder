import UIKit

extension ReminderListViewController {
  /*
   * The @objc attribute makes this method available to Objective-C code.
   * You’ll use an Objective-C API to attach the method to your custom button.
   */
  @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
    guard let id = sender.id else { return }
    completeReminder(withId: id)
  }
}
