//
//  ImageLoadScreen.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 27.01.2025.
// Экран добавления новых изображений

import SwiftUI

struct ImageLoadScreen: View {
    @State  var showImagePicker = true
    @State  var selectedImage: UIImage?
    @State private var isUploading = false
//    // URL сервера, куда отправляется изображение
//    let serverURL = URL(string: "http://144.21.37.189:35035/v1/images/upload")!
    
    @State  var imageTags = ImageTags()
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center){
                
                Image(uiImage: selectedImage ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width,
                           height: geometry.size.height / 2,
                           alignment: .center)
                    .scaledToFit()
                    .onTapGesture {
                        showImagePicker.toggle()
                    } .sheet(isPresented: $showImagePicker) {
                        ImagePicker(image: self.$selectedImage)
                    }
                
                
                if (selectedImage != nil){
                    
                }
                
                Spacer()
                if isUploading {
                    ProgressView()
                } else {
                    Button(action: {
                        guard let image = selectedImage,
                              let imageData = image.jpegData(compressionQuality: 1.0)
                        else {return}
                        
                        let body = UploadImageRequest(id: UUID().uuidString,
                                                      hashTags: ["body:arm"])
                        
                        uploadImage(imageData: imageData, request: body) { response in
                            print(response)
                        }})
                    {
                        Text("Send image")
                    }
                }
            }}
    }
    
    //    func uploadImage() {
    //        guard let image = selectedImage,
    //              let imageData = image.jpegData(compressionQuality: 1.0)
    //             else {
    //            return
    //        }
    //
    //        isUploading = true
    //
    //        var request = URLRequest(url: serverURL)
    //        request.httpMethod = "POST"
    //        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    //        let task = URLSession.shared.uploadTask(with: request, from: imageData) { data, response, error in
    //            if let error = error {
    //                print("Ошибка загрузки изображения: \(error.localizedDescription)")
    //                return
    //            }
    //
    //            if let response = response as? HTTPURLResponse,
    //               (200...299).contains(response.statusCode) {
    //                print("Успешная загрузка изображения!")
    //            } else {
    //                print("Сервер вернул ошибку.")
    //            }
    //            DispatchQueue.main.async {
    //                self.isUploading = false
    //            }
    //        }
    //
    //        task.resume()
    //    }
    
}

#Preview {
    ImageLoadScreen(showImagePicker: false)
}
