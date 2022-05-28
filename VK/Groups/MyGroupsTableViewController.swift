//
//  SecondItemTableViewController.swift
//  VK
//
//  Created by Aurelica Apps iOS Dev - 1 on 24/03/22.
//

import UIKit
import RealmSwift

class MyGroupsTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - ATTRIBUTES
    var myGroups: [Group] = []

    var groupNames = User.allMates[0].groups
    var displayedGroups: [Group] = []

    var searchGroup = [String]()
    var isSearching = false

    var groups = [String]()
    let allGroups = Group.allGroups

    // contains section title
    var sectionTitle = [String]()
    //contains key and group array
    var groupDict = [String:[String]]()


    // MARK: - Table view data source
    override func viewDidLoad() {
        super.viewDidLoad()
        groups = allGroups.compactMap({ $0.name }).sorted(by: <)

        if let firstGroup = Group.allGroups.first {
            myGroups.append(firstGroup)
        }

        displayedGroups = myGroups
        searchBar.delegate = self

        sectionTitle = Array(Set(groups.compactMap({String($0.prefix(1))})))
        sectionTitle.sort()
        sectionTitle.forEach({groupDict[$0] = [String]()})
        groups.forEach({groupDict[String($0.prefix(1))]?.append($0)})


        // load from Realm new objects
        GetGroupsList().loadData() {
            [weak self] () in self?.loadGroupsFromRealm()
        }

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayedGroups.count
//        displayedGroups[sectionTitle[section]]?.count ?? 0
//        groupDict[sectionTitle[section]]?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as? SecondCellTableViewCell
//        let group = allGroups[indexPath.row]
        let group = displayedGroups[indexPath.row]
        cell?.groupName.text = group.name

        cell?.groupPhoto.image = UIImage(named: group.avatar)
        cell?.textLabel?.textColor = .black
        return cell ?? UITableViewCell()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitle.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitle[section]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let allGroupsVC = segue.destination as? AllGroupsViewController {
            allGroupsVC.myGroups = myGroups
            allGroupsVC.delegate = self

        }
    }
    // MARK: - CUSTOM FUNCTIONS
    func loadGroupsFromRealm() {
        do {
            let realm = try Realm()
            let groupsFromreal = realm.objects(Groupp.self)
            // check whether group exists or not
            guard groupsFromreal.count != 0 else {return}
            //
            tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
}

extension MyGroupsTableViewController: AllGroupsViewControllerDelegate {
    func userUnsubscribe(group: Group) {
        myGroups.removeAll(where: { $0.id == group.id})
        updateFilteredResult(searchText: searchBar.text ?? "")
    }

    func userSubscribe(group: Group) {
        myGroups.append(group)
        updateFilteredResult(searchText: searchBar.text ?? "")
    }

}

extension MyGroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateFilteredResult(searchText: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        tableView.reloadData()
    }

    func updateFilteredResult(searchText: String) {

        guard !searchText.isEmpty else {
            displayedGroups = myGroups
            tableView.reloadData()
            return
        }
        displayedGroups = myGroups.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        isSearching = true
        tableView.reloadData()
    }
}

