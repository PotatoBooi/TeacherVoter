//
//  VoteOnTeacherViewController.swift
//  TeacherVoter
//
//  Created by Damian on 02/05/2022.
//

import UIKit

class VoteOnTeacherViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var meritsRating: StarRatingView!
    @IBOutlet weak var chillRating: StarRatingView!
    @IBOutlet weak var loudnessRating: StarRatingView!
    @IBOutlet weak var difficultyRating: StarRatingView!
    @IBOutlet weak var humorRating: StarRatingView!
    @IBOutlet weak var commentTextView: UITextView!
    
    weak var refreshDelegate: RefreshTableDelegate?
        
    var teacher: Teacher?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextView.layer.cornerRadius = 8.0
        commentTextView.layer.borderWidth = 1.0
        commentTextView.layer.borderColor = UIColor.gray.cgColor
        
        title = "Oceń"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Dodaj", style: .plain, target: self, action: #selector(onVotePressed))
        
        if let teacher = self.teacher {
            nameLabel.text = "\(teacher.firstName!) \(teacher.lastName!)"
        }
        
    }
    

    @objc private func onVotePressed() {
        guard let teacher = self.teacher else { return }
        

        let newVote = Vote(context: self.context)
        
        newVote.teacher = teacher
        newVote.merits = Int16(meritsRating.rating)
        newVote.chill = Int16(chillRating.rating)
        newVote.voiceLoundness = Int16(loudnessRating.rating)
        newVote.taskDifficulty = Int16(difficultyRating.rating)
        newVote.humor = Int16(humorRating.rating)
        let newRating = CGFloat(newVote.merits + newVote.chill + newVote.voiceLoundness + newVote.taskDifficulty + newVote.humor) / 5.0
        newVote.overall = Float(newRating)
        do {
            try self.context.save()
        } catch {
            print(error)
        }
        
        
        if let votes = teacher.votes?.allObjects as? [Vote] {
            teacher.avgMerits = Float(votes.compactMap({Int($0.merits)}).reduce(0,+) / votes.count)
            teacher.avgChill = Float(votes.compactMap({Int($0.chill)}).reduce(0,+) / votes.count)
            teacher.avgHumor =  Float(votes.compactMap({Int($0.humor)}).reduce(0,+) / votes.count)
            teacher.avgDifficulty =  Float(votes.compactMap({Int($0.taskDifficulty)}).reduce(0,+) / votes.count)
            teacher.avgLoudness =  Float(votes.compactMap({Int($0.voiceLoundness)}).reduce(0,+) / votes.count)
            teacher.avgRating = Float(votes.compactMap({$0.overall}).reduce(0.0,+) / Float(votes.count))
        }
        
        if let commentText = commentTextView.text, !commentText.isEmpty {
            newVote.comment = commentTextView.text
        }
        
        do {
            try self.context.save()
            self.refreshDelegate?.refreshTable()
            self.navigationController?.popViewController(animated: true)
        } catch {
            print(error)
        }
    }

}
