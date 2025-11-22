//
//  ContentView.swift
//  IterableSAMobileChallenge
//
//  Created by Rufino Cudia on 11/21/25.
//

import SwiftUI
import IterableSDK

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Iterable Mobile Challenge")
                .font(.title)
            
            // Part 1: Update User Profile
            Button("Update User Profile") {
                let data: [String: Any] = [
                    "firstName": "<redacted-for-public-repo>",
                    "isRegisteredUser": true,
                    "SA_User_Test_Key": "completed"
                ]

                IterableAPI.updateUser(data, mergeNestedObjects: true)
                print("User profile updated: \(data)")
            }
            .buttonStyle(.borderedProminent)
            
            // Part 2: Send Custom Event
            Button("Send Custom Event") {
                let eventName = "mobileSATestEvent"
                
                let data: [String: Any] = [
                    "platform": "iOS",
                    "isTestEvent": true,
                    "url": "<redacted-for-public-repo>",
                    "secret_code_key": "<redacted-for-public-repo>"
                ]
                
                IterableAPI.track(event: eventName, dataFields: data)
                print("Custom Event sent: \(eventName) with data: \(data)")

                // Embedded message attempt
                IterableAPI.embeddedManager.syncMessages {
                    print("Embedded messages sync complete")
                }
            }
            .buttonStyle(.bordered)
            
            // Part 3: Show In-App Message
            Button("Show In-App Message") {
                let messages = IterableAPI.inAppManager.getMessages()
                if let first = messages.first {
                    print("Showing in-app message: \(first.messageId)")
                    IterableAPI.inAppManager.show(
                        message: first,
                        consume: false,
                        callback: nil
                    )
                } else {
                    print("No in-app messages in queue")
                }
            }
            .buttonStyle(.borderless)
            
            // Embedded message attempt
            Divider()
                .padding(.vertical, 8)

            Text("Embedded Message Preview (bonus)")
                .font(.headline)

            EmbeddedMessageControllerWrapper()
                .frame(height: 320)

            Spacer()
        }
        .padding()
    }
}

// Embedded message attempt
struct EmbeddedMessageControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> EmbeddedMessageViewController {
        EmbeddedMessageViewController()
    }

    func updateUIViewController(_ uiViewController: EmbeddedMessageViewController, context: Context) {
        
    }
}

// Embedded message attempt
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
