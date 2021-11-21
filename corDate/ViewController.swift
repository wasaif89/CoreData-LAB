//
//  ViewController.swift
//  corDate
//
//  Created by Abu FaisaL on 11/04/1443 AH.
//

import UIKit
import CoreData

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    


    @IBOutlet weak var textStudentName: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    // Handel for the whole data model to interact with
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var result = [Student]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        fechDataFrromDB()
//        //creete an obj for student
//        let usman = Student(context: context)
//
//
//        //fill it with some data
//        usman.name = "Usman iban Affaan"
//
//        // save to DB
//        do {
//           try context.save()
//        } catch {
//            print("Unable to save")
//        }
//        //get the saved info from DB
//
//        //Make Request to context - Fatching
//        let request = Student.fetchRequest() as NSFetchRequest<Student>
//        do {
//        let result = try context.fetch(request)
//        // print the result
//            for taalib in result{
//                print(taalib.name)
//            }
//
//        } catch {
//            print("Unble to get data from DB")
//        }
//
    }
    @IBAction func addNames(_ sender: Any) {
        for n in 1...20 {
            let newStudent = Student(context: context)
            newStudent.name = "name\(n)"
            
            do { try! context.save() }
            
             fechDataFrromDB()
            
        }
            
            
        }
    
    @IBAction func removeLast10(_ sender: Any) {
        for _ in 1...10 {
            if (result.last != nil){
                let itemDlt = result.last!
                self.context.delete(itemDlt)
            }
            do {
                try!
                context.save()
                fechDataFrromDB()
            }
        }
    }
    
    
    
    
    
    

    @IBAction func onPressAdd(_ sender: UIButton) {
        
        // Add the text from textFaild to DB
        let newStudent = Student(context: context)
        newStudent.name = textStudentName.text
        
        // save Context
        
        do { try! context.save() }
        // Fetch data from DB again
         fechDataFrromDB()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = result[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Edit", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        let textBox = alert.textFields![0]
        textBox.text = self.result[indexPath.row].name
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {action in
            
            self.result[indexPath.row].name = textBox.text
            do {try!
                self.context.save()
                self.fechDataFrromDB()
        }
            
         
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert,animated: true, completion: nil)
        
        }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete"){ _, _, handler in
            
            let itemDelete = self.result[indexPath.row]
            self.context.delete(itemDelete)
            do {
               try!
                self.context.save()
                self.fechDataFrromDB()
            }
        }
        return UISwipeActionsConfiguration(actions: [actionDelete])
        }
    
    
    func fechDataFrromDB(){
        //get the context
        //configure the request - NSFetchRequest
        let request = Student.fetchRequest() as! NSFetchRequest<Student>
        //storing
        let sorting = NSSortDescriptor(key: "name", ascending: false)
        request.sortDescriptors = [sorting]
        //Filtering
//let filterByA = NSPredicate(format: "name CONTAINS 'Abu'")
//request.predicate = filterByA
        //fetchRequst
        //assign the result of fetchRequst to array
        do {
      try!  result = context.fetch(request)
            tableView.reloadData()
        }
    }
}

/*
   let itemToDelete = result[indexPath.row]
   self.context.delete(itemToDelete)
   do { try!
    self.context.save()
    self.fechDataFrromDB()
 */
