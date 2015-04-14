import UIKit
import DATAStack

class ViewController: UITableViewController {
  let dataStack: DATAStack

  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  init(dataStack: DATAStack) {
    self.dataStack = dataStack

    super.init(nibName: nil,
      bundle: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")

    let request: NSFetchRequest = NSFetchRequest(entityName: "User")
    request.sortDescriptors = [NSSortDescriptor(key: "name",
      ascending: true)]

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC))),
      dispatch_get_main_queue(), {
        self.tableView.dataSource = DATASource(
          tableView: self.tableView,
          fetchRequest: request,
          cellIdentifier: "Cell",
          mainContext: self.dataStack.mainContext,
          configuration: { (cell, item, indexPath) -> Void in
            let cell = cell as! UITableViewCell
            cell.textLabel!.text = "Hi"
        })
      })
  }
}

