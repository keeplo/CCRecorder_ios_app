//
//  PlayTabView.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/10.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

struct PlayTabView: View {
    
    // MARK: - Dependency
    
	@ObservedObject var viewModel: PlayTabViewModel
    
    // MARK: - View Render
    var content: some View {
        VStack(alignment: .center) {
            Slider(
                value: $viewModel.currentTime,
                in: .zero...viewModel.duration,
                onEditingChanged: { isEditing in
                    if isEditing {
                        viewModel.editingSliderPointer()
                    } else {
                        viewModel.editedSliderPointer()
                    }
                }
            )
            .padding([.leading, .trailing])
            HStack(alignment: .top) {
                Text(viewModel.currentTime.formattedToDisplayTime)
                Spacer()
                Text(viewModel.duration.formattedToDisplayTime)
            }
            .padding([.leading, .trailing])
            .foregroundColor(.gray)
            .font(.caption)
            .overlay {
                if viewModel.disabledPlaying {
                    Text("녹음 파일 없음")
                        .font(.headline)
                }
            }
            HStack(alignment: .center) {
                Menu(
                    content: {
                        ForEach(PlayTabViewModel.Speed.allCases, id: \.self) { item in
                            Button(action: {
                                viewModel.speed = item
                            }, label: {
                                Text(item.description)
                                    .foregroundColor(.logoDarkBlue)
                                    .font(.caption)
                            })
                        }
                    }, label: {
                        Spacer()
                        Text(viewModel.speed.description)
                            .foregroundColor(.logoDarkBlue)
                            .font(.headline)
                        Spacer()
                    }
                ) // SpeedMenu
                
                Button(
                    action: {
                        viewModel.skip(.back)
                    }, label: {
                        Spacer()
                        Image(systemName: "gobackward." + viewModel.skipTime)
                            .font(.system(size: 22))
                        Spacer()
                    }
                ) // BackwardButton
                .disabled(viewModel.disabledPlaying)
                .opacity(viewModel.disabledPlayingOpacity)
                
                Button(
                    action: {
                        if viewModel.isPlaying {
                            viewModel.pausePlaying()
                        } else {
                            viewModel.startPlaying()
                        }
                    }, label: {
                        Spacer()
                        Image(systemName: viewModel.isPlayingImageName)
                            .font(.system(size: 44))
                        Spacer()
                    }
                ) // PlayButton
                .disabled(viewModel.disabledPlaying)
                
                Button(
                    action: {
                        viewModel.skip(.forward)
                    }, label: {
                        Spacer()
                        Image(systemName: "goforward." + viewModel.skipTime)
                            .font(.system(size: 22))
                        Spacer()
                    }
                ) // GowardButton
                .disabled(viewModel.disabledPlaying)
                .opacity(viewModel.disabledPlayingOpacity)
                
                Button(
                    action: {
                        viewModel.skip(.next)
                    }, label: {
                        Spacer()
                        Image(systemName: "forward.end.alt.fill")
                            .font(.system(size: 16))
                        Spacer()
                    }
                ) // NextPinButton
                .foregroundColor(.logoDarkBlue)
                .disabled(viewModel.nextPin == nil)
                .opacity(viewModel.nextPinButtonOpacity)
            }
            .foregroundColor(.logoLightBlue)
        } // PlayControl
        .background(Color.ccGroupBgColor)
    }
    
    // MARK: - View Action
    var body: some View {
		content
            .onAppear {
                viewModel.setupPlaying()
            }
            .onDisappear {
                viewModel.finishPlaying()
            }
    }
	
}

//#if DEBUG // MARK: - Preview
//struct PlayTabView_Previews: PreviewProvider {
//    
//	static var container: PresentationDIContainer { .preview }
//	
//	static var previews: some View {
//		container.PlayTabView(with: .empty)
//			.previewLayout(.sizeThatFits)
//			.preferredColorScheme(.light)
//		container.PlayTabView(with: .empty)
//			.previewLayout(.sizeThatFits)
//			.preferredColorScheme(.dark)
//    }
//	
//}
//#endif
