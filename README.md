# DSGAssignment
Technology Assessment

**What am I building?**

The final result of this task is to have an ViewConroller for displaying Item List in a tableView after getting in a seach api and DeatailViewController which display the simple discription of item after tapping of tableview cell.

**In this project:**

  **Structural Design Pattern**
   - MVVM - Model View ViewModel use for Better UI design


  **Models:**
  - From API data four type of datamodel created those are Events,Event, Venue, Performer 
  
  
  **View /View Controllers:**
  - ViewController - A view controller that create SearchViewModel and have tableview and implement it’s data source 
  - DetailViewController - A view controller that showing basing information of event  
  - EventViewCell class for custom UITableViewCell
    
   **ViewModel:**
   - SearchViewModel - A ViewModel used to get the searched result and display in tableview  
  
   **API:**
   - APIManager - This is a singlton class use for network call and data parsing
  
   
   
### Test Cases: ###

   **iOSAssigmentTests:**
   - testSearchAPI() - this function use to test data validation which coming from API call
   - testSearchAPIwithViewModel() - this function use to test data validation using viewModel
   
   
   **iOSAssigmentUITests:** 
   
   - testPerformanceApp() - this function use to test app launching performace.
   
   
### Instructions: ###
  - Fork the project
  - Clone the forked project to you'r machine
  - navigation to project directory and run Pod install, 
  - after finishing Pod install open DSGAssignment.xcworkspace with latest Xcode, Build and run 
