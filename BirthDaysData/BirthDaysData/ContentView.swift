//___FILEHEADER___

import SwiftUI
import SwiftData

struct ContentView: View {
    //初期データ
    @Query private var friends:[Friends]
    // Friends の model が context となる
    @Environment(\.modelContext) private var context
    
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
        .task{
            context.insert(Friends(name: "John", birthDay: .now))
            // 先に日にちの形式を決定しないと日付が入れられない
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            // エルビス関数を使うことが求められる
            context.insert(Friends(name:"hiro tanaka",birthDay: dateFormatter.date(from: "2021-01-11") ?? Date(timeIntervalSince1970:0)))
        }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for:Friends.self,inMemory:true)
}
