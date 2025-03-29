//
//  QuestionTableCell.swift
//  assignment-3-quiz-app
//
//  Created by James Chard on 2025/3/28.
//

import UIKit

class QuestionTableCell: UITableViewCell {
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var incorrectAnswer1Label: UILabel!
    @IBOutlet weak var incorrectAnswer2Label: UILabel!
    @IBOutlet weak var incorrectAnswer3Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

