//
//  StudentTableViewController.swift
//  StudentTableJuno
//
//  Created by мак on 05.02.2020.
//  Copyright © 2020 viktorsafonov. All rights reserved.
//

import UIKit


class StudentTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    // Create Add Action button
    @IBAction func pushAddAction(_ sender: Any) {
    
        let alertController = UIAlertController(title: "Add new student", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (textFieldName) in
            textFieldName.placeholder = "Student name"
            textFieldName.autocapitalizationType = .words
        }
        alertController.addTextField { (textFieldSurName) in
            textFieldSurName.placeholder = "Student Surname"
            textFieldSurName.autocapitalizationType = .words
        }
        alertController.addTextField { (textFieldRating) in
            textFieldRating.placeholder = "1...5"
            textFieldRating.keyboardType = .numberPad
        }
        
        alertController.addTextField { (textFieldGender) in
            textFieldGender.placeholder = "Male/Female"
            textFieldGender.autocapitalizationType = .words
        }
        
        let create = UIAlertAction(title: "Create", style: .default) { (alert) in
            let nameText = alertController.textFields?[0].text
            let surNameText = alertController.textFields?[1].text
            let rateText = alertController.textFields?[2].text
            let genderText = alertController.textFields?[3].text
            if nameText!.isEmpty || surNameText!.isEmpty || rateText!.isEmpty || genderText!.isEmpty {
                self.errorAlert()
                
            } else {
            
            addStudent(newStudent: Students(surName: surNameText ?? "nil", name: nameText ?? "nil", rate: rateText ?? "nil", gender: genderText ?? "nil"))
            
            sortedStudentSurName()
            
            self.tableView.reloadData()
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (alert) in
          // Cancel code
        }
        
        alertController.addAction(create)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
        
    }
    
    private var filteredStudent = [Students]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI Button input to footer Table
        
        let buttonActionAdd = UIButton()
        buttonActionAdd.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 40)
        buttonActionAdd.backgroundColor = UIColor.blue
        buttonActionAdd.setTitle("Add new student", for: .normal)
        buttonActionAdd.addTarget(self, action: #selector(pushAddAction(_:)), for: .touchUpInside)
        tableView.tableFooterView = buttonActionAdd
        
        // Setup the Search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Find Students"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    

    func errorAlert () {
        let errorAlert = UIAlertController(title: "Error", message: "Please, fill all text fields", preferredStyle: .alert)
        let errorAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        errorAlert.addAction(errorAction)
        present(errorAlert, animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if isFiltering {
            
            return filteredStudent.count
        } else {
        
            return studentList.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        var student : Students
        
        if isFiltering {
            student = filteredStudent[indexPath.row]
        } else {
            student = studentList[indexPath.row]
        }
        
        cell.textLabel?.text = student.surName + " " + student.name
        cell.detailTextLabel?.text = "Rating:" + " " + student.rate + " " + "Gender:" + " " + student.gender

        return cell
    }

   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if isFiltering {
                
                let selectedStudents = filteredStudent[indexPath.row]
                if let index = studentList.firstIndex(where: {$0.surName == selectedStudents.surName && $0.name == selectedStudents.name && $0.gender == selectedStudents.gender && $0.rate == selectedStudents.rate }) {
                    studentList.remove(at: index)
                }
                filteredStudent.remove(at: indexPath.row)
            } else {
                studentList.remove(at: indexPath.row)
            }
            
            
            tableView.deleteRows(at: [indexPath], with: .left)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filteredContentForSearchText (_ searchText: String) {
        
        filteredStudent = studentList.filter({ (student: Students) -> Bool in
            return student.surName.lowercased().contains(searchText.lowercased()) || student.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
