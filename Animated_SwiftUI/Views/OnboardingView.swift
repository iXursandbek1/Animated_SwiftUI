//
//  OnboardingView.swift
//  Animated_SwiftUI
//
//  Created by Xursandbek Qambaraliyev on 02/11/23.
//

import SwiftUI
import RiveRuntime

struct OnboardingView: View {
    
    let buttonAnimated = RiveViewModel(fileName: "button")
    @State var showModal = false
    
    var body: some View {
        ZStack {
            background
            
            content
                .offset(y: showModal ? -50 : 0)
            
            Color("Shadow")
                .opacity(showModal ? 0.4 : 0)
                .ignoresSafeArea()
            
            if showModal {
                SingInView(showModal: $showModal)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .overlay(
                        Button {
                            withAnimation(.spring()) {
                                showModal = false
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .frame(width: 36, height: 35)
                                .foregroundColor(.black)
                                .background(.white)
                                .mask(Circle())
                                .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
                        }
                            .frame(maxHeight: .infinity, alignment: .bottom)
                    )
                    .zIndex(1)
            }
        }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Learn design & code")
                .font(.custom("Poppins Bold",
                              size: 60, relativeTo: .largeTitle))
                .frame(width: 260,
                       alignment: .leading)
            
            Text("Don’t skip design. Learn design and code, by building real apps with React and Swift. Complete courses about the best tools.")
                .customFont(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            buttonAnimated.view()
                .frame(width: 236,
                       height: 64)
                .overlay(
                    Label("Start the coures",
                          systemImage: "arrov.forward")
                        .offset(x: 4, y: 4)
                        .font(.headline))
                .background(
                    Color.black
                        .blur(radius: 10)
                        .opacity(0.3)
                        .offset(y: 10))
                .onTapGesture {
                    buttonAnimated.play(animationName: "active")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        withAnimation(.spring()) {
                            showModal = true
                        }
                    }
            }
            
            Text("Purchase includes accsess to 30+ courses, 240+ premium tutorials, 120+ hours of videos, sours file and certificates.")
                .customFont(.footnote)
        }
        .padding(40)
        .padding(.top, 40)
    }
    
    var background: some View {
        RiveViewModel(fileName: "shapes").view()
            .ignoresSafeArea()
            .blur(radius: 30)
            .background(
                Image("Spline")
                    .blur(radius: 50)
                    .offset(x: 200, y: 100)
        )
    }
}

#Preview {
    OnboardingView()
}
