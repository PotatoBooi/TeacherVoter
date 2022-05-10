//
//  TeacherDetailsViewController.swift
//  TeacherVoter
//
//  Created by Damian on 02/05/2022.
//

import UIKit

class TeacherDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RefreshTableDelegate {
    
    
    
    @IBOutlet weak var detailsTable: UITableView!
    
    var teacher: Teacher?
    
    var comments: [String] {
        let votes = teacher?.votes?.allObjects as? [Vote]
        return votes?.compactMap({ $0.comment }).filter({ !$0.isEmpty }) ?? []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsTable.delegate = self
        detailsTable.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Oceń", style: .plain, target: self, action: #selector(onVotePressed))
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? VoteOnTeacherViewController {
            destination.teacher = teacher
            destination.refreshDelegate = self
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : comments.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return comments.count > 0 ? 2 : 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailsHeader", for: indexPath)
            if let teacher = self.teacher, let cell = cell as? TeacherDetailsHeaderCell {
                cell.setup(with: teacher)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)
            (cell as? CommentCell)?.setup(with: comments[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Komentarze"
        } else { return nil }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .black
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    func refreshTable() {
        guard let teacher = self.teacher else { return }
        do {
            self.teacher = try context.existingObject(with: teacher.objectID) as? Teacher
            DispatchQueue.main.async {
                self.detailsTable.reloadData()
                if !self.comments.isEmpty {
                    self.detailsTable.reloadSections([1], with: .none)
                }
            }
        } catch {
            
            print(error)
        }
        
        
    }
    
    
    @objc private func onVotePressed() {
        performSegue(withIdentifier: "voteOnTeacher", sender: nil)
    }
    
}
