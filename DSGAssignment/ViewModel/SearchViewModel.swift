//
//  SearchViewModel.swift
//  DSGAssignment
//
//  Created by VEER BAHADUR TIWARI on 15/08/21.
//

import UIKit

class SearchViewModel: NSObject {
    
    var queryString: String? {
        didSet {
            guard let q = queryString else { return }
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(fetchSearchResult(_:)), object: nil)
            self.perform(#selector(fetchSearchResult(_:)), with: q, afterDelay: 0.1)
        }
    }
    var eventsList :[Event]
    var errorMessage: Dynamic<String> = Dynamic("")
    var dataChange: Dynamic<Int> = Dynamic(0)
    var isLoading: Dynamic<Bool> = Dynamic(false)
    
    override init() {
        self.queryString = ""
        self.eventsList = []
    }
    
    /** This function use to get the row for tableview .
    - Returns: numbers of row i.e eventsList array size
    */
    
    func numberOfRowsInSection() -> Int {
        return eventsList.count
    }
    
    /** This function return event at `index` .
    - Parameter index: Integr less than eventList cpunt
    - Returns: A Optional value of Event at index
    */
    
    func getItemAtIndex(_ index:Int) -> Event?  {
        if eventsList.count > index {
            return eventsList[index]
        }
        else {
            return nil
        }
    }
    
    //Fetch Search resrult
    /** This function search for  query `q` .
    - Parameter q: String value that should not be empty
    */
    @objc func fetchSearchResult(_ q:String) {
        self.isLoading.value = true
        guard !q.isEmpty else {
            self.eventsList.removeAll()
            self.dataChange.value = Int.random(in: 1..<99999)
            self.isLoading.value = false
            return
        }
        APIManager.shared().getSearchResult(query: q) { (success, info, error) in
            switch success {
            case true :
                if let i = info as? Events, let list = i.list {
                    self.eventsList = list
                    self.dataChange.value = Int.random(in: 1..<99999)
                    self.isLoading.value = false
                }
            case false:
                self.errorMessage.value = error
                self.isLoading.value = false
            }
        }
    }

}
