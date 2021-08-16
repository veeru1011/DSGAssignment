//
//  ViewController.swift
//  DSGAssignment
//
//  Created by VEER BAHADUR TIWARI on 15/08/21.
//

import UIKit

class ViewController: UIViewController {
    
    ///Initilize searchController
    let searchController = UISearchController(searchResultsController: nil)
     
    ///tableview object connect to IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    ///ActivityIndicator object connect to IBOutlet
    @IBOutlet weak var activityIndicater: UIActivityIndicatorView!
    
    ///View Model
    var viewModel: SearchViewModel =  SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup tableview
        setUpTableView()
        
        //setup searchviewController
        setUpSearchViewControllor()
        
        // Notifier for Error message
        viewModel.errorMessage.bind { [unowned self] in
            showAlert($0)
        }
        
        // Notifier for dataChane
        viewModel.dataChange.bind { [weak self] _ in
            self?.updateUI()
        }
        
        // Notifier for Loading message
        viewModel.isLoading.bind { isLoading in
            DispatchQueue.main.async {
                isLoading ? self.activityIndicater.startAnimating() : self.activityIndicater.stopAnimating()
            }
        }
        
        viewModel.queryString = ""
        
    }
    
    // MARK: - UI Helper
    ///  Set up setUpTableView
    func setUpTableView() {
        
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0.01))
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(EventViewCell.self, forCellReuseIdentifier: CellIdentifier)
    }
    /**
     Set up  SearchView Controller
     
     Set up Ui for search view controller and update stayle and tint color
    */
    func setUpSearchViewControllor() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barStyle = .black
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.03137254902, blue: 0.07058823529, alpha: 1)
        searchController.searchBar.searchTextField.textColor = .white
        definesPresentationContext = true
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.white
        }
        
        navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
    }
    
    /**
     Update Ui
     
     this function user to reload tableview data when data change in view model
    */
    
    @objc func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - AlertMessage UI
    /**
     This method show AlertViewController.

     this is used to diaplay error message .

     - parameter message: this is user to set message for UIAlertController .
     - parameter title: this is use to set title for UIAlertController.

     # Notes: #
     1. Parameters message should be **String** type
     2. Bydefault title is **Alert**

     # Example #
    ```
     showAlert("No Internet Connection")
     
     ```
    */

    func showAlert(_ message: String, title: String = AlertTitle) {
        guard message.count > 0 else { return }
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message:
                                                        message, preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: DismissButtonTitle, style: UIAlertAction.Style.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

// MARK: UITableViewDelegate,UITableViewDataSource
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! EventViewCell
        let locData = self.viewModel.getItemAtIndex(indexPath.row)
        cell.event = locData
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailViewController.laodViewController()
        detailVC.delegate = self
        detailVC.event = self.viewModel.getItemAtIndex(indexPath.row)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MARK: UISearchResultsUpdating

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        ///Check if old string is not eqaul to  new string
        if (!(viewModel.queryString?.elementsEqual(text) ?? true)) {
            viewModel.queryString = text
        }
    }
}

//MARK: DetailViewControllerDelegate
extension ViewController : DetailViewControllerDelegate {
    /**
     This function get called from DetailViewController for updating the tableview
     */
    func favourateButtonTapped() {
        self.perform(#selector(updateUI), with: nil, afterDelay: 0.1)
    }
}

