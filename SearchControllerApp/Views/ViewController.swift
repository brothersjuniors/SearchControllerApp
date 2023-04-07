//
//  ViewController.swift
//  SearchControllerApp
//
//  Created by 近江伸一 on 2023/03/25.
//
import UIKit
import RealmSwift
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var id = ""
    var box = Int()
    var data: Results<Products>!
    let realm = try! Realm()
    var lists = List<Products>()
    var searching = false
    var searchedItem = [Products]()
    let searchController = UISearchController(searchResultsController: nil)
    var editIndexPath: IndexPath?
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
        table.delegate = self
        table.dataSource = self
        table.register(UINib(nibName:"CustomsTableViewCell",bundle: nil), forCellReuseIdentifier: "cell")
        data = realm.objects(Products.self).sorted(byKeyPath: "maker",ascending: true)
        searchController.searchResultsUpdater = self
        configureRefreshControl()
        configulation()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedItem.count
        } else {
            return data.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomsTableViewCell
        box = indexPath.row
        let item = data[box]
        if searching {
            cell.accessoryType = .none
            cell.makerLabel.text = searchedItem[indexPath.row].maker
            cell.product.text = searchedItem[indexPath.row].name
            cell.capacity.text = "容量:　\(searchedItem[indexPath.row].capa)"
            cell.jan.text = "JAN: \(searchedItem[indexPath.row].janID)"
        
        } else {
            cell.accessoryType = .detailButton
            
            cell.makerLabel.text = item.maker
            cell.product.text = item.name
            cell.capacity.text = "容量:　\(item.capa)"
            cell.jan.text = "JAN: \(item.janID)"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        _ = CommitView()
        box = indexPath.row
        CommitView.box = box
        
        performSegue(withIdentifier: "segue", sender: indexPath)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        searchController.dismiss(animated: false)
        guard let vc = storyboard?.instantiateViewController(identifier: "detail") as? DetailViewController else { return }
      
            let item = data[indexPath.row]
            vc.item = item
            vc.navigationItem.largeTitleDisplayMode = .never
            vc.navigationItem.title = item.name
//        searchController.dismiss(animated: false)
//           dismiss(animated: true)
            navigationController?.pushViewController(vc, animated: true)
            table.reloadData()
        }
 //くるくる回ってリロード処理
    func configureRefreshControl () {
        table.refreshControl = UIRefreshControl()
        table.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    @objc func handleRefreshControl() {
        DispatchQueue.main.async {
            self.table.reloadData()  //リロード処理
            self.table.refreshControl?.endRefreshing()
        }
    }
    //SearchBarで検索機能
    private func configulation(){
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search"
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Helper().deleteItem(item: data[indexPath.row])
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}

extension ViewController: UISearchResultsUpdating,UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty {
            searching = true
            searchedItem.removeAll()
            for i in data {
                if i.name.lowercased().contains(searchText.lowercased()) {
                    searchedItem.append(i)
                }
            }
            table.reloadData()
        } else {
            searching = false
            searchedItem.removeAll()
        }
        table.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        
        searchedItem.removeAll()
        table.reloadData()
        
    }
    }
