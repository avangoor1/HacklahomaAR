//
//  Home_Screen.swift
//  Hacklahoma
//
//  Created by Ananya Vangoor on 2/10/24.
//

import SwiftUI

import Foundation


struct Home_Screen: View {
    var activities = ["Bowling", "Walk", "Hunting"]
    let solidColor : Color = Color(red: 21/255, green: 128/255, blue: 211/255)
    let buttonColor : Color = Color(red: 230/255, green: 2/255, blue: 219/255)

    @State var colors: [Color] = [.blue, .cyan, .gray, .green, .indigo, .mint, .orange, .pink, .purple, .red]
    @State private var selected = "Bowling"
    @State var moveBowling = false
    @State var moveDart = false
    @State var moveShip = false
    @State private var id = 1
    

    var body: some View {

        VStack{
            Text("Available Games")
                .font(.system(size: 40))
                .foregroundColor(.white)
                .bold()
                .underline()
            Spacer()
            VStack {
                Circle()
                    .fill(solidColor)
                    .padding()
                    .overlay(
                        Image(systemName: "figure.\(selected.lowercased())")
                            .font(.system(size: 144))
                            .foregroundColor(.white)
                    )
                    .shadow(color: buttonColor, radius: 15, y: 5)
                /* Button with Shadow */
                Button(action: {
                    if (selected == "Bowling"){
                        self.moveBowling = true
                        self.moveDart = false
                        self.moveShip = false
                    } else if (selected == "Walk") {
                        self.moveDart = true
                        self.moveBowling = false
                        self.moveShip = false
                    } else if (selected == "Hunting"){
                        self.moveShip = true
                        self.moveDart = false
                        self.moveBowling = false
                    } else {
                        self.moveDart = false
                        self.moveBowling = false
                        self.moveShip = false
                    }
                    getRequest(message: selected)
                }) {
                    Text("\(selected)")
                        .padding()
                        .foregroundColor(.white)
                        .background(buttonColor)
                        .cornerRadius(10)
                        .font(.system(size: 40))
                        .fullScreenCover(isPresented: $moveBowling) {
                            ContentView(Sprite: $selected)
                        }
                        .fullScreenCover(isPresented: $moveDart) {
                            ContentView(Sprite: $selected)
                        }
                        .fullScreenCover(isPresented: $moveShip) {
                            ContentView(Sprite: $selected)
                        }
                }
                .padding()
                .shadow(color: .red, radius: 15, y: 5)
            }
            .transition(.slide) //transition is not working properly
            .id(id)
            

            Spacer()
            
            Button("Explore More Games") {
                // change activity
                withAnimation(.easeInOut(duration: 1)){
                    selected = activities[id % activities.count]
                    id += 1
                }
            }
                .buttonStyle(.borderedProminent)
        }
        .background(Image("background"))
    }
    
    // Function to get request
    func getRequest(message: String) {
        // Define the URL endpoint to which you want to send data
        var components = URLComponents(string: "http://192.168.90.31/message")!
        components.queryItems = [URLQueryItem(name: "message", value: message.lowercased())]
        
        // Create a URLRequest with the URL
        var request = URLRequest(url: components.url!)
        
        // Set the HTTP method to GET
        request.httpMethod = "GET"
        
        // Create a URLSession instance
        let session = URLSession.shared
        
        // Create a data task to send the request
        let task = session.dataTask(with: request) { data, response, error in
            // Handle the response
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response status code: \(response.statusCode)")
            }
            
            if let data = data {
                // Handle the response data
                print("Response data: \(String(data: data, encoding: .utf8) ?? "No data")")
            }
        }
        
        // Resume the task to initiate the request
        task.resume()
    }

    
    // Function to send the network request
    func sendRequest() {
        // Define the URL endpoint to which you want to send data
        let urlString = "http://192.168.90.31"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Create a URLRequest with the URL
        var request = URLRequest(url: url)
        
        // Set the HTTP method to POST
        request.httpMethod = "POST"
        
        // Set the request body data
        let message = "Hello from my Swift app!" // Your message here
        let bodyData = message.data(using: .utf8)
        request.httpBody = bodyData
        
        // Create a URLSession instance
        let session = URLSession.shared
        
        // Create a data task to send the request
        let task = session.dataTask(with: request) { data, response, error in
            // Handle the response
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response status code: \(response.statusCode)")
            }
            
            if let data = data {
                // Handle the response data
                print("Response data: \(String(data: data, encoding: .utf8) ?? "No data")")
            }
        }
        
        // Resume the task to initiate the request
        task.resume()
    }

    
}

struct Home_Screen_Previews: PreviewProvider {
    static var previews: some View {
        Home_Screen()
    }
}
