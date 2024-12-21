//___FILEHEADER___

import SwiftUI

struct ContentView: View {
    //初期データ
    @State private var friends:[Friends]=[
        Friends(name: "aaa", birthDay: .now),
        Friends(name: "bbb", birthDay: Date(timeIntervalSince1970: 100))
        
    ]
    @State private var newName = ""
    @State private var newBirthdayData = Date.now
    
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
            //ボトムバー
        .safeAreaInset(edge:.bottom){
            VStack(alignment:.center,spacing: 20){
                Text(" New Birthday Date.").font(.headline)
                // 未来の日付を選ぶことができない、表示は日にちまで
                DatePicker(selection:$newBirthdayData,in: Date.distantPast...Date.now,displayedComponents: .date){
                    //名前入力
                    TextField("Enter new name",text:$newName)
                        .textFieldStyle(.roundedBorder)
                    }
                Button("Save"){
                    let newFriend = Friends(name: newName, birthDay: newBirthdayData)
                    //保存してリストに追加
                    if(newFriend.name != ""){
                        friends.append(newFriend)
                    }
                    // 保存したら入力欄はリセット
                    newName=""
                    newBirthdayData = .now
                }.bold().foregroundColor(.blue)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
