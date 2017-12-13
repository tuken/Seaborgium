import Foundation
import Aphid

class Client: Aphid, MQTTDelegate {
    
    init(clientId: String) {
        super.init(clientId: clientId)
        super.delegate = self
    }
    
    func didConnect() {
        print("I connected!")
    }
    
    func didLoseConnection() {
        print("connection lost")
    }
    
    func didCompleteDelivery(token: String) {
        print(token)
    }
    
    func didReceiveMessage(topic: String, message: String) {
        print(topic, message)
    }

    func didLoseConnection(error: Error?) {
        
    }
}

let clientId = "Foo"

let client = Client(clientId: clientId)

try client.connect()

client.subscribe(topic: ["city/+/temperature", "status/lastWill", "universe/+/+/planet"], qoss: [.atMostOnce, .atLeastOnce, .exactlyOnce])

try client.ping()

client.unsubscribe(topics: ["city/+/temperature", "universe/+/+/planet"])

client.publish(topic: "city/austin/temperature", withMessage: "90 degrees")

client.disconnect()

while config.status == ConnectionStatus.connected {
    sleep(60)
}
