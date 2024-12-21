//___FILEHEADER___

import SwiftUI
import SwiftData

struct ContentView: View {
    //誕生日が早い順に並べ替える
    @Query(sort:\Friends.birthDay) private var friends:[Friends]
    // Friends の model が context となる
    @Environment(\.modelContext) private var context
    
    @State private var newName = ""
    @State private var newBirthdayData = Date.now
    
    var body: some View {
        NavigationStack{
        List(friends){
            friend in
                HStack{
                    if(friend.isBirthday){
                        Image(systemName:"birthday.cake")
                    }
                    Text(friend.name).bold(friend.isBirthday).foregroundColor(friend.isBirthday ? .accentColor: nil)
                    Spacer()
                    Text(friend.birthDay,format: .dateTime.month(.wide).day().year())

                }
            }
        .navigationTitle("Birthdays")
            //ボトムバー
        .safeAreaInset(edge:.bottom){
            VStack(alignment:.center,spacing: 20){
                Text(" New Birthday Data").font(.headline)
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
                        context.insert(newFriend)
                    }
                    // 保存したら入力欄はリセット
                    newName=""
                    newBirthdayData = .now
                }.bold().foregroundColor(.blue)
                }
            .padding()
            .background(.bar)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for:Friends.self,inMemory:true)
}
