//
//  CustomAccordionButton.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/24/24.
//

import SwiftUI

struct CustomAccordionButton: View {
    let title: String
    var isSelected: Bool = true
    var hasBorder: Bool = false
    var selectedBackgroundColor: Color = .sMain
    var defaultBackgroundColor: Color = .clear
    var activeBorderColor: Color = .sMain
    var borderColor: Color = .sGray
    var textColor: Color = .white
    var items: [String]
    var dropdownWidth: CGFloat? = nil
    var action: (String) -> Void

    @State private var isDropdownVisible: Bool = false
    @State private var buttonFrame: CGRect = .zero
    @Binding var selectedItem: String
    @State private var highlightedIndex: Int? = nil

    var body: some View {
        ZStack {
            if isDropdownVisible {
                Color.black.opacity(0.01)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isDropdownVisible = false
                        }
                    }
            }
            
            Button(action: toggleDropdown) {
                mainButtonContent
            }
            .background(GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        buttonFrame = geometry.frame(in: .global)
                    }
            })
            
            if isDropdownVisible {
                dropdownContent
                    .background(.white)
                    .cornerRadius(5)
                    .offset(x: 0, y: buttonFrame.height + 23)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .shadow(color: .sGray3.opacity(0.4), radius: 2, x: 0, y: 2)
                    .zIndex(1)
                
            }
        }
    }

    // MARK: - Subviews

    private var mainButtonContent: some View {
        HStack(spacing: 4) {
            Text(selectedItem.isEmpty ? title : selectedItem)
                .font(.pretendard(.regular, size: 14))
                .foregroundColor(textColor)
            
            Image(systemName: isDropdownVisible ? "chevron.up" : "chevron.down")
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 10)
                .foregroundColor(textColor)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(isSelected ? selectedBackgroundColor : defaultBackgroundColor)
        .overlay(
            hasBorder ? RoundedRectangle(cornerRadius: 15)
                .stroke(isDropdownVisible ? activeBorderColor : borderColor, lineWidth: 1) : nil
        )
        .cornerRadius(16)
        .frame(maxWidth: .infinity, alignment: .leading)

    }

    private var dropdownContent: some View {
        VStack(alignment: .leading, spacing: 9) {
            ForEach(items.indices, id: \.self) { index in
                dropdownItem(for: items[index], at: index)
            }
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 7)
        .background(.white)
        .frame(width: dropdownWidth ?? buttonFrame.width)
  
    }

    private func dropdownItem(for item: String, at index: Int) -> some View {
        Text(item)
            .font(.pretendard(.light, size: 10))
            .background(
                highlightedIndex == index ? Color.sGray10P : Color.white
            )
            .cornerRadius(2)
            .onTapGesture {
                selectItem(at: index)
            }
            .onHover { isHovering in
                if isHovering {
                    highlightedIndex = index
                } else if highlightedIndex == index {
                    highlightedIndex = nil
                }
            }
    }

    // MARK: - Actions

    private func toggleDropdown() {
        withAnimation {
            isDropdownVisible.toggle()
        }
    }

    private func selectItem(at index: Int) {
        selectedItem = items[index]
        highlightedIndex = index
        withAnimation {
            isDropdownVisible = false
        }
        action(items[index])
    }
}


#Preview {
    @State var selectedSubject: String = ""
    
    ZStack {
        Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
        VStack(spacing: 20) {
            CustomAccordionButton(
                title: "과목",
                hasBorder: true,
                selectedBackgroundColor: .clear,
                textColor: .sGray2,
                items: ["컴퓨터시스템개론", "미디어제작및실습", "프로그래밍2및실습"],
                dropdownWidth: 95.06,
                action: { _ in print("과목 버튼 클릭") },
                selectedItem: $selectedSubject
            )
            
            CustomAccordionButton(
                title: "인기순",
                selectedBackgroundColor: .clear,
                textColor: .sGray,
                items: ["최신순", "인기순", "생성순"],
                dropdownWidth:46,
                action: { _ in print("영역 버튼 클릭") },
                selectedItem: $selectedSubject
            )
            
            CustomAccordionButton(
                title: "영역",
                isSelected: false,
                defaultBackgroundColor: .sGray10P,
                textColor: .sGray3,
                items: ["최신순", "인기순", "생성순"],
                action: { _ in print("영역 버튼 클릭") },
                selectedItem: $selectedSubject
            )
            
            CustomAccordionButton(
                title: "학과",
                isSelected: true,
                selectedBackgroundColor: .sMain,
                textColor: .white,
                items: ["최신순", "인기순", "생성순"],
                action: { _ in print("학과 버튼 클릭") },
                selectedItem: $selectedSubject
            )
        }
        .padding()
    }
}
