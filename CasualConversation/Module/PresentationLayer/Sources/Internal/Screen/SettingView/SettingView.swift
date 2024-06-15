//
//  SettingView.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/09.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

struct SettingView: View {
	
	@Environment(\.colorScheme) private var systemColorScheme
	
	@ObservedObject var viewModel: SettingViewModel
	
	@State private var isPresentedTutorial: Bool = false
	@State private var isShowingMailView: Bool = false
	@State private var isShowingActivityView: Bool = false
	
    var body: some View {
		VStack {
			Form {
                NavigationLink(
                    destination: {
                        Form {
                            VStack(alignment: .center) {
                                Image(viewModel.titleImageName(by: systemColorScheme), bundle: .module)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 100)
                                Text("프린서플어학원 CC Time 프로그램")
                                    .font(.headline)
                            }
                            VStack(alignment: .leading) {
                                Text("언제 어디서나 가벼운 인사부터 다양한 주제의 대화를 나누는 영어회화 학습방법입니다")
                                    .font(.subheadline)
                                Text("주제 및 발음기호 등 학습 정보는 PSE에서 제공합니다")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            Group {
                                Link("🔍 프린서플어학원 알아보기", destination: viewModel.mainURL)
                                Link("☕️ 네이버카페", destination: viewModel.cafeURL)
                                Link("🖥 e-Learning", destination: viewModel.eLearningURL)
                                Link("👀 정규반 맛보기 강의", destination: viewModel.tasteURL)
                                Link("📄 온라인 레벨테스트", destination: viewModel.testURL)
                                Button("📞 문의전화") {
                                    UIApplication.shared.open(viewModel.receptionTel)
                                }
                            }
                            .tint(.logoDarkGreen)
                        } // AcademyInfos
                    }, label: {
                        HStack {
                            Image(viewModel.logoImageName(by: systemColorScheme), bundle: .module)
                                .resizable()
                                .frame(width: 41.7, height: 48)
                            Text("What is Casual Conversation?")
                                .font(.headline)
                        }
                    }
                ) // InfomationSection
                Section(
                    content: {
                        Button(
                            action: {
                                self.isPresentedTutorial.toggle()
                            }, label: {
                                Text("앱 사용방법 보기")
                            }
                        ) // Tutorial
                        .tint(.primary)
                        .fullScreenCover(isPresented: $isPresentedTutorial) {
                            TutorialView()
                        }
                        HStack {
                            Toggle("화면잠금 해제", isOn: $viewModel.isLockScreen)
                                .tint(.ccTintColor)
                        } // LockScreen
                        Picker("건너뛰기 시간 설정", selection: $viewModel.skipTime) {
                            ForEach(SkipTime.allCases, id: \.self) { time in
                                Text("\(time.description) 초")
                                    .tag(time)
                            }
                        } // SkipTimeSelection
                    }, header: {
                        Text("일반")
                    }
                ) // GeneralSection
                Section(
                    content: {
                        Picker("디스플레이 모드 설정", selection: $viewModel.displayMode) {
                            ForEach(DisplayMode.allCases, id: \.self) { condition in
                                Text(condition.description)
                                    .tag(condition)
                            }
                        } // DarkMode
                    }, header: {
                        Text("테마")
                    }
                ) // ThemeSection
                Section(
                    content: {
                        Link(
                            destination: .init(
                                string: "https://www.instagram.com/casualconversation_ccrecorder/")!,
                            label: {
                                Label("인스타그램 소통하기", systemImage: "hand.thumbsup")
                            }
                        )
                        Button(
                            action: {
                                self.isShowingMailView.toggle()
                            }, label: {
                                Label("문의하기", systemImage: "envelope.open")
                            }
                        )
                        .sheet(isPresented: $isShowingMailView) {
                            MailView(
                                isShowing: $isShowingMailView,
                                result: $viewModel.mailSendedResult
                            )
                        }
                        Button(
                            action: {
                                viewModel.requestReview()
                            }, label: {
                                Label("별점주기", systemImage: "star.leadinghalf.filled")
                            }
                        )
                        Button(
                            action: {
                                self.isShowingActivityView.toggle()
                            }, label: {
                                Label("공유하기", systemImage: "square.and.arrow.up")
                            }
                        )
                        .background {
                            ActivityView(isPresented: $isShowingActivityView)
                        }
                    }, header: {
                        Text("소통")
                    }
                ) // FeedbackSection
                .tint(.primary)
                Section(
                    content: {
                        //            NavigationLink(destination: {
                        //                Text("오픈소스 라이선스")
                        //            }, label: {
                        //                Text("오픈소스 라이선스")
                        //            })
                        
                        HStack {
                            Text("버전")
                            Spacer()
                            Text(viewModel.version)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        NavigationLink(destination: {
                            TeamMateInfoView()
                        }, label: {
                            Text("개발자 정보")
                        })
                    }, header: {
                        Text("앱 정보")
                    }
                ) // UnclassifiedSection
			}
			.listStyle(.grouped)
			
			Text("@2022. All rights reserved by Team Marcoda.")
				.foregroundColor(.gray)
				.font(.caption)
		}
		.navigationTitle("Setting")
		.navigationBarTitleDisplayMode(.inline)
    }
	
}

#if DEBUG
#Preview {
    SettingView(viewModel: .preview)
        .preferredColorScheme(.light)
}
#Preview {
    SettingView(viewModel: .preview)
        .preferredColorScheme(.dark)
}
#endif
