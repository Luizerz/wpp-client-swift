//
//  ContactList.swift
//  wpp-client-2
//
//  Created by Luiz Sena on 05/09/24.
//

import SwiftUI

struct ContactList: View {
    let id: String
    @State private var contactList: [Contact] = []
    @State private var isSheetPresented: Bool = false
    @StateObject private var  wsClient: WebSocket = WebSocket()
    @State private var allDisabled: Bool = false
    var body: some View {
        VStack {
            Button {
                allDisabled ? wsClient.connect() : wsClient.disconnect()
                allDisabled.toggle()
            } label: {
                Text(allDisabled ? "Conectar ao servidor" : "Desconectar ao servidor")
            }
            .padding(.bottom, 250)
            
            ScrollView{
                VStack(alignment: .center) {
                    if contactList.isEmpty {
                        Text("Você não tem contatos!!")
                    } else {
                        ForEach(contactList, id: \.self) { contact in
                            NavigationLink {
                                ChatView(id: id, contactId: contact.id, chatMessages: self.$wsClient.messages, onSend: { message in
                                    self.wsClient.sendData(DataContainer(contentType: .message, content: message.toData()))
                                })
                            } label: {
                                Text(contact.name)
                            }
                            .contextMenu {
                                Button {
                                    self.contactList.removeAll {
                                        $0.id == contact.id
                                    }
                                } label: {
                                    Text("Remover")
                                }
                                
                            }
                        }
                    }
                }
            }
            .disabled(allDisabled)
            Button(action: {
                self.isSheetPresented.toggle()
            }, label: {
                Text("Adicionar Contato")
            })
            
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $isSheetPresented) {
            SheetView(contactList: $contactList)
        }
        .onAppear {
            self.wsClient.id = self.id
            self.wsClient.connect()
        }
        
    }
    
    func addContact() {
        
    }
}
//
//#Preview {
//    ContactList(wsClient: WebSocket(id: "aa"))
//}
