//
//  FromSecondItemTableViewController.swift
//  VK
//
//  Created by Aurelica Apps iOS Dev - 1 on 24/03/22.
//

import UIKit

struct GroupedGroup {
    let character: Character
    var groups: [Group]
}

protocol AllGroupsViewControllerDelegate {
    func userUnsubscribe(group: Group)
    func userSubscribe(group: Group)
}

class AllGroupsViewController: UITableViewController {

    var myGroups: [Group] = []
    let allGroups = Group.allGroups

    @IBOutlet weak var searchBar2: UISearchBar!
    var groupedGroups: [GroupedGroup] {
        var result = [GroupedGroup]()

        for group in allGroups {
            guard let character = group.name.first else {
                continue
            }
            if let groupedIndex = result.firstIndex(where: { $0.character == character}) {
                result[groupedIndex].groups.append(group)
            } else {
                let groupedGroup = GroupedGroup(character: character, groups: [group])
                result.append(groupedGroup)
            }
        }
        return result
    }

    var delegate: AllGroupsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar2.delegate = self

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupedGroups.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let groupedGroup = groupedGroups[section]
        return groupedGroup.groups.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let groupedGroup = groupedGroups[section]
        return String(groupedGroup.character)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AllGroupsTableViewCell
        let groupedGroup = groupedGroups[indexPath.section]
        let group = groupedGroup.groups[indexPath.row]
        cell?.allGroupsName.text = group.name
        cell?.detailTextLabel?.text = group.groupDescription
        cell?.allGroupsPhoto.image = UIImage(named: allGroups[indexPath.row].avatar)
//        cell?.groupPhoto.image = UIImage(named: allGroups[indexPath.row].avatar)
        return cell ?? UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let groupedGroup = groupedGroups[indexPath.section]
        let group = groupedGroup.groups[indexPath.row]
        let isSubscribe = myGroups.contains { myGroup in
            return myGroup.id == group.id
        }

        let action: UIContextualAction

        if isSubscribe {
            action = UIContextualAction(style: .normal, title: "????????????????????", handler: { [weak self] _,_, complete in
                guard let self = self else { return }

                self.myGroups.removeAll(where: {$0.id == group.id})
                self.delegate?.userUnsubscribe(group: group)
                complete(true)

            })

        } else {
            action = UIContextualAction(style: .normal, title: "??????????????????????", handler: {[weak self] _,_, complete in
                guard let self = self else {return}
                self.myGroups.append(group)
                self.delegate?.userSubscribe(group: group)
                complete(true)

            })
        }

        return UISwipeActionsConfiguration(actions: [action])
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

}
extension AllGroupsViewController: UISearchBarDelegate {
    
}
