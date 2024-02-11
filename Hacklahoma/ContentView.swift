//
//  ContentView.swift
//  Hacklahoma
//
//  Created by Ananya Vangoor on 2/10/24.
//

import SwiftUI
import RealityKit



struct ContentView: View {
    let buttonColor : Color = Color(red: 230/255, green: 2/255, blue: 219/255)
    @Binding var Sprite: String
    var sprite: String // Declaring sprite as a global variable
    
    init(Sprite: Binding<String>) {
        self._Sprite = Sprite // ERROR: Cannot assign value of type 'Binding<String>' to type 'String'
        self.sprite = _Sprite.wrappedValue // Accessing the wrapped value of the binding
    }
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                ARViewContainer(sprite: sprite).edgesIgnoringSafeArea(.all)
                Button("Exit Game") {
                                    // Navigate back to the home screen
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .foregroundColor(.white)
                .background(buttonColor)
                .cornerRadius(10)
                .font(.system(size: 30))
            }
        }
    }
}


struct ARViewContainer: UIViewRepresentable{
    
    var sprite: String // Declare sprite as a property in ARViewContainer
    
    init(sprite: String) {
        self.sprite = sprite
        print(self.sprite)
    }
    

    func makeUIView(context: Context) -> some ARView {
        let arview = ARView(frame: .zero)
        
        if (self.sprite == "Bowling"){
            let spriteAnchor = try! Game.loadBox()
            arview.scene.anchors.append(spriteAnchor)
        } else if (self.sprite == "Walk"){
            let spriteAnchor = try! Dart.loadBox()
            arview.scene.anchors.append(spriteAnchor)
        } else if (self.sprite == "Hunting"){
            let spriteAnchor = try! Spaceship.loadBox()
            arview.scene.anchors.append(spriteAnchor)
        }
        
        return arview
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
    
}

struct ContentView_Previews: PreviewProvider {
    @State static var object : String = ""
    static var previews: some View {
        ContentView(Sprite: $object)
    }
}
