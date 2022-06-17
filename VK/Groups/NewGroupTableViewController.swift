//
//  NewGroupTableViewController.swift
//  VK_A
//
//  Created by Ahmed App iOS Dev - 1 on 10/06/22.
//

import UIKit

class NewGroupTableViewController: UITableViewController {


    // MARK: - ATTRIBUTES
    var groupsList: [Groupp] = []
    var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    func setupSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Введите запрос для поиска"
        //searchController.searchBar.text = "Swift"
        tableView.tableHeaderView = searchController.searchBar
        searchController.obscuresBackgroundDuringPresentation = false // не скрывать таблицу под поиском (размытие), иначе не будет работать сегвей из поиска

        //автоматическое открытие клавиатуры для поиска
        searchController.isActive = true
        DispatchQueue.main.async {
          self.searchController.searchBar.becomeFirstResponder()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsList.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)


        return cell
    }



    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */


}

extension NewGroupTableViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        if let searchedText = searchController.searchBar.text {
//            searchgroup
        }
    }

    func searchGroupVK(searchText: String) {
        SearchGroup().loadData(searchText: searchText) { [weak self] (complition) in
            DispatchQueue.main.async {
                //print(complition)
//                self?.GroupsList = complition
                self?.tableView.reloadData()
            }
        }
    }
}
