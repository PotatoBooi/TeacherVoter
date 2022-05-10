//
//  ViewController.swift
//  TeacherVoter
//
//  Created by Damian on 02/05/2022.
//

import UIKit

protocol RefreshTableDelegate: AnyObject {
    func refreshTable()
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RefreshTableDelegate {
    
    @IBOutlet weak var teachersTableView: UITableView!
        
    private var teachers: [Teacher]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        teachersTableView.rowHeight = UITableView.automaticDimension
        teachersTableView.estimatedRowHeight = 120.00
        teachersTableView.delegate = self
        teachersTableView.dataSource = self
        
        title = "Nauczyciele"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddPressed))
        
        loadTeachers()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddTeacherViewController {
            destination.refreshDelegate = self
        }
        
        if let destination = segue.destination as? TeacherDetailsViewController, let teacher = sender as? Teacher {
            destination.teacher = teacher
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teachers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teacherCell", for: indexPath)
        if let cell = cell as? TeacherCell {
            if let teacher = teachers?[indexPath.row] {
                cell.setupWith(teacher: teacher)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let teacher = teachers?[indexPath.row] {
            performSegue(withIdentifier: "teacherDetails", sender: teacher)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @objc private func onAddPressed() {
        performSegue(withIdentifier: "addTeacher", sender: nil)
    }
    
    func refreshTable() {
        loadTeachers()
    }
    
    private func loadTeachers() {
        do {
            self.teachers = try context.fetch(Teacher.fetchRequest())
            DispatchQueue.main.async {
                self.teachersTableView.reloadData()
            }
            
        } catch {
            print(error)
        }
    }
    
    
}

