//
//  DetailTaskView.swift
//  WidgetAPP
//
//  Created by MRX on 10/30/23.
//
import UIKit
import SwiftUI
import PhotosUI


struct DetailTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var coreData: CoreDataManager
    @State private var isShowImagePicker: Bool = false
    @State private var imagePicker: UIImage = UIImage(systemName: "photo")!
    @State private var isEditing: Bool = false
    @Binding var task: ToDoEntity
    @Binding var indexOfItem: Int
    let arraysImage: [String] = ["a", "b", "c", "d", "e", "g", "h"]
    var colunms: [GridItem] = [
        GridItem(.adaptive(minimum: 50, maximum: 50))
    ]
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                HeaderView()
                    .padding()
                ComponetsView()
                    .padding()
            }
        }
        .onDisappear(perform: {
            coreData.fetchDataFromToDoEntities()
        })
    }
    
    @ViewBuilder
    func ComponetsView() -> some View {
        VStack(spacing: 30) {
            HStack {
                VStack {
                    Text(task.creationDate?.format("EEE, MM, d") ?? "")
                    Text(task.creationDate?.format("h:mm a") ?? "")
                }
                
                Spacer()
                Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
                Spacer()
                VStack {
                    Text(task.endDate?.format("EEE, MM, d") ?? "")
                    Text(task.endDate?.format("h:mm a") ?? "")
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 10, x: 2, y: 2)
            VStack(alignment: .leading, spacing: 35) {
                CustomVSatck("doc.fill", taskTitile: task.taskTitle ?? "", taskDesciption: task.taskDescription ?? "")
                CustomVSatck("bell.fill", taskTitile: "Nhac nho", taskDesciption: "Task Description")
                CustomVSatck("repeat", taskTitile: "lap lai", taskDesciption: "Task Description")
                CustomVSatck("personalhotspot", taskTitile: "URL", taskDesciption: "Task Description")
                CustomVSatck("mappin.and.ellipse", taskTitile: "Vi Tri", taskDesciption: "Chua thiet lap")
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 10, x: 5, y: 5)
        }
    }
    
    @ViewBuilder
    func CustomVSatck(_ imageString: String, taskTitile: String, taskDesciption: String) -> some View {
        HStack {
            ZStack {
                Rectangle()
                    .frame(width: 45, height: 45)
                    .foregroundColor(Color.green.opacity(1))
                    .cornerRadius(10)
                Image(systemName: imageString)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading) {
                Text(taskTitile)
                    .font(.title)
                Text(taskDesciption)
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        HStack {
            Button(action: {
                backButton()
            }, label: {
                Image(systemName: "arrow.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
            })
            Spacer()
            Text(task.taskType ?? "")
            Spacer()
            ZStack {
                Button(action: {
                    editButton()
                    isEditing.toggle()
                }, label: {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                })
                
                if isEditing {
                    CreatAction(with: "Delete")
                        .padding(.top, 50)
                }
            }
        }
    }
    private func backButton() {
        presentationMode.wrappedValue.dismiss()
    }
    
    private func editButton() {
        
    }
    private func selectedImage() {
        
    }
    @ViewBuilder
    func CreatAction(with text: String) -> some View {
        VStack {
            Button(action: {
                coreData.deleteTask(with: indexOfItem)
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text(text)
            })
        }
    }
}

struct DetailTaskView_Previews: PreviewProvider {
    static var previews: some View {
        DetailTaskView(task: .constant(ToDoEntity()), indexOfItem: .constant(0))
    }
}



