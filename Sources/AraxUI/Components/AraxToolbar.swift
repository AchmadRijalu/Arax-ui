//
//  AraxToolbar.swift
//  Arax
//
//  Created by Achmad Rijalu  A on 08/10/26.
//

import SwiftUI

struct AraxToolbar: View {
    var action: () -> Void = {}
    var title: String
    var foregroundColor: Color?
    var backgroundColor: Color?

    var body: some View {
        ZStack {
            HStack {
                Button {
                    action()
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.blue)
                }
                Spacer()
            }
            Text(title)
                .foregroundStyle(Color("SecondaryColor"))
                .font(.system(size: 17, weight: .semibold))
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: 55)
        .background(.gray)
    }
}


#Preview {
    AraxToolbar(title: "Title")
}
