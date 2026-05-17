//import SwiftUI
//import Foundation
////
////  AdaptivePillGrid.swift
////  TutorTwin
////
////  Created by Sukeina Ammar on 5/17/26.
////
//
//
//struct AdaptivePillGrid: View {
//    let items: [String]
//    @Binding var selectedItem: String
//
//    private let columns = [
//        GridItem(.adaptive(minimum: 96), spacing: 14)
//    ]
//
//    var body: some View {
//        LazyVGrid(columns: columns, spacing: 14) {
//            ForEach(items, id: \.self) { item in
//                Text(item)
//                    .font(.system(size: 20))
//                    .minimumScaleFactor(0.65)
//                    .lineLimit(2)
//                    .multilineTextAlignment(.center)
//                    .foregroundStyle(isSelected(item) ? .white : .gray)
//                    .frame(minWidth: 92, minHeight: 54)
//                    .padding(.horizontal, 10)
//                    .background(
//                        isSelected(item)
//                        ? AppTheme.primaryBlue
//                        : Color.white
//                    )
//                    .clipShape(Capsule())
//                    .contentShape(Capsule())
//                    .onTapGesture {
//                        selectedItem = cleaned(item)
//                    }
//            }
//        }
//    }
//
//    private func cleaned(_ item: String) -> String {
//        item.replacingOccurrences(of: "\n", with: "")
//    }
//
//    private func isSelected(_ item: String) -> Bool {
//        selectedItem == cleaned(item)
//    }
//}
