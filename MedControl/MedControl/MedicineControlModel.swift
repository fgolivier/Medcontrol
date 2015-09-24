//
//  MedicineControlModel.swift
//  WorkingWithFiles
//
//  Created by Marcio Moritz on 9/22/15.
//  Copyright © 2015 Training. All rights reserved.
//

import Foundation


struct MedicineControl {
    
    var medicineDescription : String
    var medicineDosage : String
    var medicineDosageInterval: String      // float
    var medicineDosageIntervalUnit : String
    var medicineStartDate : String           // date
    var medicineEndDate : String        // date
    var medicineNextTakeAt : String        // time
    var medicineTakeHistory : String      // array of datetime
    
    init(){
        
        medicineDescription = ""
        medicineDosage = ""
        medicineDosageInterval = ""      // float
        medicineDosageIntervalUnit = ""
        medicineStartDate = ""           // date
        medicineEndDate = ""        // date
        medicineNextTakeAt = ""        // time
        medicineTakeHistory = ""
        
    }
    
}


