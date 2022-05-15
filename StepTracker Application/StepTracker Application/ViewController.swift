

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet var displayLabel: UILabel!
    
    let activityManager = CMMotionActivityManager()
    let pedometer = CMPedometer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if CMMotionActivityManager.isActivityAvailable(){
            self.activityManager.startActivityUpdates(to:OperationQueue.main){ (Data)in
                DispatchQueue.main.async {
                    if let activity = Data{
                        if activity.running == true{
                            print("Running")
                        }else if activity.walking == true{
                            print("Walking")
                        }else if activity.automotive == true{
                            print("Automotive")
                        }
                    }
                }
                
            }
            
        }
        if CMPedometer.isStepCountingAvailable(){
            self.pedometer.startUpdates(from: Date()) { (data, error) in
                if error == nil {
                    if let response = data {
                        DispatchQueue.main.async {
                            print("Number Of Steps == \(response.numberOfSteps)")
                            
                            self.displayLabel.text = "Step Counter : \(response.numberOfSteps)"
                        }
                    }
                    
                }
            }
        }
    }
}
