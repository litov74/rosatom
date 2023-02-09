import Foundation
import UIKit

class AutorizationStorage {
    
    static let shared = AutorizationStorage()
    private let taskIdToOpenFromPush = "taskId"
    private let fcmToken = "fcmToken"
    
    func obtainTaskIdToOpenFromPush() -> UUID? {
        return UserDefaults.standard.value(forKey: self.taskIdToOpenFromPush) as? UUID
    }
    
    func obtainFcmToken() -> UUID? {
        return UserDefaults.standard.value(forKey: self.fcmToken) as? UUID
    }
    
    func putTaskIdToOpenFromPush(id: UUID) {
        UserDefaults.standard.set(id, forKey: self.taskIdToOpenFromPush)
        UserDefaults.standard.synchronize()
    }
    
    func putFcmToken(fcmToken: String) {
        UserDefaults.standard.set(fcmToken, forKey: self.fcmToken)
    }
    
    func removeTaskIdToOpenFromPush() {
        UserDefaults.standard.removeObject(forKey: self.taskIdToOpenFromPush)
        UserDefaults.standard.synchronize()
    }
    
    
}
