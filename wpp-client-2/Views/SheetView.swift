//
//  SheetView.swift
//  wpp-client-2
//
//  Created by Luiz Sena on 05/09/24.
//

import SwiftUI


struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var contactList: [Contact]
    @State private var name: String = ""
    @State private var id: String = ""
    var body: some View {
        TextField("Nome ou Apelido:", text: $name)
        TextField("Número:", text: $id)
        Button(action: {
            contactList.append(Contact(name: name, id: id))
            dismiss()
        }, label: {
            Text("Salvar")
        }).buttonStyle(.bordered)


    }
}

#Preview {
    SheetView(contactList: .constant([]))
}
