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
    @State  var isUploading = false
    @StateObject var viewModel = ImageTagScreenViewModel()
    @State var showErrorNotification = false
    @State var messageErrorNotification = ""
    
    
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
                    TagView(imageTags: Binding(get: { viewModel.imageTags ?? ImageTags(tagGroups: []) },
                                               set: { viewModel.imageTags = $0 }),
                            simpleTags: Binding(get: { viewModel.simpleTags ?? [] },
                                                set: { viewModel.simpleTags = $0 })
                    )
                    .padding()
                    .onAppear {viewModel.fetchImageTags()}
                    
                }
                
                Spacer()
                if isUploading {
                    ProgressView()
                } else {
                    Button(action: {
                        isUploading=true
                        guard let image = selectedImage,
                              let imageData = image.jpegData(compressionQuality: 1.0)
                        else {return}
                        
                        let body = UploadImageRequest(structuredTags: viewModel.imageTags,tags: viewModel.simpleTags)
                        
                        uploadImage(imageData: imageData, request: body) { response in
                            switch response {
                            case .success(_):
                                messageErrorNotification = String("OK")
                            case .failure(let failure):
                                messageErrorNotification = String("Error: \(failure)")
                            }
                            showErrorNotification.toggle()
                            print(response)
                            isUploading=false
                        }
                        isUploading=false
                        
                    })
                    {
                        Text("Send image")
                            .foregroundColor(.black)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.green.opacity( 0.5))
                            )
                    }
                }
            }
            .overlay(TopNotificationView(isShowing: $showErrorNotification,
                                         message: messageErrorNotification,
                                         type: .error))
            
        }
    }
}

#Preview {
    ImageLoadScreen(showImagePicker: false, selectedImage: UIImage())
}
