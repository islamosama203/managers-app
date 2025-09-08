//
//  BottomSheet.swift
//  MidManagers
//
//  Created by Khaled Rashed on 27/03/2023.
//

import SwiftUI

private struct Distances {
    static let hidden: CGFloat = 500
    static let maxUp: CGFloat = -5
    static let dismiss: CGFloat = 200
}
struct BottomSheetConstants {
    static let itemSpaces: CGFloat = 10
}
struct BottomSheet<Content: View>: View {
    @Binding var isPresented: Bool
    @Binding var gesturesEnabled: Bool
    @ViewBuilder let content: Content
    @State private var translation = Distances.hidden



    var body: some View {
        if isPresented {
            ZStack {
                Color.gray
                    .opacity(0.6)
                    .animation(.easeOut(duration: 2), value: isPresented)


                VStack {
                    Spacer()
                    contentView
                        .offset(y: translation)
                        .animation(.interactiveSpring(), value: isPresented)
                        .animation(.interactiveSpring(), value: translation)
                        .if(gesturesEnabled, transform: { view in
                            view.gesture(
                                DragGesture()
                                    .onChanged { value in
                                    guard translation > Distances.maxUp else { return }
                                    translation = value.translation.height
                                }
                                    .onEnded { value in
                                    if value.translation.height > Distances.dismiss {
                                        translation = Distances.hidden
                                        isPresented = false
                                    } else {
                                        translation = 0
                                    }
                                }
                            )
                        })
                       
                }

            }
                .ignoresSafeArea()
                .onAppear {
                withAnimation {
                    translation = 0
                }
            }.onDisappear {
                translation = Distances.hidden
            }
        }

    }

    private var contentView: some View {
        VStack(spacing: 0) {
            handle
                .padding(.top, 6)
            content
                .padding(20)
                .padding(.bottom, 30)
        }
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.main.bounds.height * 0.85)
            .background(Color.green)
            .clipShape(
            RoundCorner(
                cornerRadius: 20,
                maskedCorners: [.topLeft, .topRight]
            )//OUR CUSTOM SHAPE
        ).shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: -5)
    }

    private var handle: some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(Color.gray)
            .frame(width: 48, height: 5)
    }
}
struct RoundCorner: Shape {

    // MARK: - PROPERTIES

    var cornerRadius: CGFloat
    var maskedCorners: UIRectCorner


    // MARK: - PATH

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: maskedCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        return Path(path.cgPath)
    }
}


extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
}
