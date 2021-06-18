//
//  Launcher.swift
//  WebsocketLauncher
//
//  Created by Tushar Kalra on 16/06/21.
//

import Foundation
import UIKit

public class Launcher: NSObject, URLSessionWebSocketDelegate {
    
    public override init(){
    }
    
    
    static let url = URL(string: "wss://echo.websocket.org/")
    static let session = URLSession(configuration: .default)
    let websocketTask = session.webSocketTask(with: url!)
    
    public var recievedMessage = ""
    
    public enum OutputType {
        case success(String), failure(Error)
    }
    
    public func launch(){
        print("Connecting")
        websocketTask.resume()
    }
    
    public func sendMessage(message: String, completion: @escaping (OutputType) -> ()){
        let message = URLSessionWebSocketTask.Message.string(message)
        websocketTask.send(message) { error in
            
            guard error == nil else {completion(.failure(error!))
                return
            }
            print("Sending")
        }
        print("Sent \(message)")
        completion(.success(""))

    }
    
    public func recieveMessage(completion: @escaping (OutputType) -> ()) {
        
        websocketTask.receive { result in
            
            print("recieving...")
            switch result {
            case .failure(let error):
                completion(.failure(error))
                print("unable to recieve msg: \(error)")
                
            case .success(let message):
                switch message {
                case .string(let msgString):
                    
                    completion(.success(msgString))
                    print("msg string: ",msgString)
                    
                case .data(let msgData):
                    print("msg data: \(msgData)")
                    
                @unknown default:
                    print("unknown error")
                }
                
            }
        }
        
    }
    
    public func disconnect(){
        websocketTask.cancel(with: .goingAway, reason: nil)
    }
    
    
}
