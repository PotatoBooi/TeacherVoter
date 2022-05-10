//
//  TeacherCell.swift
//  TeacherVoter
//
//  Created by Damian on 02/05/2022.
//

import UIKit

class TeacherCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var teacherAvgRating: StarRatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupWith(teacher: Teacher) {
        nameLabel.text = "\(teacher.firstName!) \(teacher.lastName!)"
        
        courseLabel.text = teacher.courses
        teacherAvgRating.rating = teacher.avgRating
    }

}
