//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Alexey Efimov on 19.02.2023.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var animalLabel: UILabel!
    @IBOutlet var definitionLabel: UILabel!
    
    // 1. Избавиться от кнопки возврата назад на экране результатов     DONE
    // 2. Передать массив с ответами на экран с результатами            DONE
    // 3. Определить наиболее часто встречающийся тип животного         DONE
    // 4. Отобразить результаты в соответствии с этим животным          DONE

    var answers: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide the default back buttons
        navigationItem.hidesBackButton = true
        
        updateResult()
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

// MARK: - Private Methods
extension ResultViewController {
    private func updateResult() {
        var frequencyOfAnimals = [Animal: Int]()
        let animals = answers.map { $0.animal }
        
        for animal in animals {
            if let animalTypeCount = frequencyOfAnimals[animal] {
                frequencyOfAnimals.updateValue(animalTypeCount + 1, forKey: animal)
            } else {
                frequencyOfAnimals[animal] = 1
            }
        }
        
        let sortedFrequencyOfAnimals = frequencyOfAnimals.sorted { $0.value > $1.value }
        guard let theMostFrequencyAnimal = sortedFrequencyOfAnimals.first?.key else { return }
        
        updateUI(with: theMostFrequencyAnimal)
        
    }
    
    private func updateUI(with animal: Animal) {
        animalLabel.text = "Вы - \(animal.rawValue)!"
        definitionLabel.text = animal.definition
    }
}
