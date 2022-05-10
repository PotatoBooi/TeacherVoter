//
//  TeacherDetailsHeaderCell.swift
//  TeacherVoter
//
//  Created by Damian on 02/05/2022.
//

import UIKit

class TeacherDetailsHeaderCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingsView: UIView!
    @IBOutlet weak var averageRating: StarRatingView!
    @IBOutlet weak var coursesLabel: UILabel!
    @IBOutlet weak var humorRating: StarRatingView!
    @IBOutlet weak var difficultyRating: StarRatingView!
    @IBOutlet weak var chillRating: StarRatingView!
    @IBOutlet weak var loundnessRating: StarRatingView!
    @IBOutlet weak var meritsRating: StarRatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(with teacher: Teacher) {
        nameLabel.text = "\(teacher.firstName!) \(teacher.lastName!)"
        coursesLabel.text = teacher.courses
        
        ratingsView.isHidden = teacher.votes == nil || teacher.votes?.count == 0
        
        averageRating.rating = teacher.avgRating
        difficultyRating.rating = teacher.avgDifficulty
        chillRating.rating = teacher.avgChill
        loundnessRating.rating = teacher.avgLoudness
        meritsRating.rating = teacher.avgMerits
        humorRating.rating = teacher.avgHumor
    }

}
