//___FILEHEADER___

import SwiftUI

struct ContentView: View {
    @State private var friends:[Friends]=[
        Friends(name: "aaa", birthDay: .now),
        Friends(name: "bbb", birthDay: Date(timeIntervalSince1970: 100))
        
    ]
    var body: some View {
        NavigationStack{
        List(friends,id:\.name){
            friend in
                HStack{
                    Text(friend.name)
                    Spacer()
                    Text(friend.birthDay,format: .dateTime.month(.wide).day().year())

                }
            }
        .navigationTitle("Birthdays")
        }
    }
}

#Preview {
    ContentView()
}
