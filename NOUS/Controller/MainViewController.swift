//
//  MainViewController.swift
//  NOUS
//
//  Created by Mohammad Takbiri on 7/16/22.
//

import UIKit
import RxSwift
import MessageUI

class MainViewController: ThemedViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tableView: ThemedTableView!
    
    //MARK: - Properties
    let bag = DisposeBag()
    let viewModel = MainViewModel()
    var items = [Item]()
    var filteredItems = [Item]()
    var isFiltered: Bool = false
    
    //MARK: - Views
    var searchBar: UISearchBar!
    
    //MARK: - Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.fetchItems()
        self.viewModel.items.subscribe { items in
            DispatchQueue.main.async {
                if let items = items.element {
                    if self.isFiltered { self.filteredItems = items } else { self.items = items }
                    self.tableView.reloadData()
                }
            }
        }.disposed(by: self.bag)
    }
    
    func setupSearchBar(){
        self.searchBar = UISearchBar()
        self.searchBar.delegate = self
        self.searchBar.scopeButtonTitles = ["Titles", "Descriptions"]
        self.searchBar.placeholder = "What are you looking for?"
        self.searchBar.showsCancelButton = true
        self.navigationItem.titleView = searchBar
        self.view.layoutIfNeeded()
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isFiltered { return self.filteredItems.count }
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemTableViewCell
        if self.isFiltered {
            cell.configure(item: self.filteredItems[indexPath.row])
        }else {
            cell.configure(item: self.items[indexPath.row])
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isFiltered {
            self.presentEmailComposer(item: self.filteredItems[indexPath.row])
        }else {
            self.presentEmailComposer(item: self.items[indexPath.row])
        }
    }
}

//MARK: - MFMailComposeViewControllerDelegate
extension MainViewController: MFMailComposeViewControllerDelegate {
    func presentEmailComposer(item: Item) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([])
            mail.setSubject(item.title)
            mail.setMessageBody(item.description, isHTML: true)

            self.present(mail, animated: true)
        } else {
            print("Can't send an email")
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

//MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.isFiltered = true
        var basedOnDescription: Bool = false
        if self.searchBar.selectedScopeButtonIndex == 1 {
            basedOnDescription = true
        }
        self.viewModel.searchItem(searchedText: searchText, items: self.items, basedOnDescription: basedOnDescription)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.searchBar.showsScopeBar = true
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        self.searchBar.showsScopeBar = false
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isFiltered = false
        self.searchBar.showsScopeBar = false
        self.searchBar.text = ""
        self.searchBar.resignFirstResponder()
        self.tableView.reloadData()
    }
}
