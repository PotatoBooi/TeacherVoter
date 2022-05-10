//
//  AddTeacherViewController.swift
//  TeacherVoter
//
//  Created by Damian on 02/05/2022.
//

import UIKit

class AddTeacherViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var coursesField: UITextField!
    
    weak var refreshDelegate: RefreshTableDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Dodaj nauczyciela"
    }
    
    @IBAction func addTeacherPressed(_ sender: Any) {
        guard let nameText = nameField.text, !nameText.isEmpty else {
            return
        }
        
        guard let surnameText = surnameField.text, !surnameText.isEmpty else {
            return
        }
        
        guard let coursesText = coursesField.text, !coursesText.isEmpty else {
            return
        }
        
        
        let newTeacher = Teacher(context: self.context)
        newTeacher.firstName = nameText
        newTeacher.lastName = surnameText
        newTeacher.courses = coursesText
        
        
        do {
            try self.context.save()
            self.refreshDelegate?.refreshTable()
            self.navigationController?.popViewController(animated: true)
        } catch {
            print(error)
        }
    }
    
}
