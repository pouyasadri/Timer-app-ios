//
//  ContentView.swift
//  TimerApp
//
//  Created by Pouya Sadri on 21/12/2023.
//

import SwiftUI

struct ContentView: View {
	//MARK: - Propertis
	@ObservedObject var timerViewModel : TimerViewModel
	@State var isPaused = false
	@State private var rotation = 0
	
	//MARK: - Initializer
	init(seconds: TimeInterval = 0 ){
		timerViewModel = TimerViewModel(seconds: seconds, goalTime: 20)
	}
	//MARK: - View body
	var body: some View {
		ZStack{
			backgroundColor
			ProgressBarView(progress: $timerViewModel.seconds, goal: $timerViewModel.goalTime)
			centerTitle
			bottomButtons
				.onAppear{
					timerViewModel.startSession()
					timerViewModel.viewDidLoad()
				}
		}
	}
	
	//MARK: - Private Views
	private var backgroundColor: some View{
		Color(red: 63/255, green: 68/255, blue: 3/255)
			.ignoresSafeArea()
	}
	private var centerTitle: some View{
		VStack{
			Text(timerViewModel.progress >= 1 ? "Done" : timerViewModel.displayTime)
				.font(.system(size: 50,weight: .bold))
				.foregroundStyle(.white)
			Text("\(timerViewModel.goalTime.asString(style: .short))")
				.foregroundStyle(.white.opacity(0.6))
		}
	}
	private var bottomButtons: some View{
		VStack{
			Text("Timer App")
				.font(.title)
				.foregroundStyle(Color(red: 180/255, green: 187/255, blue: 62/255))
			Spacer()
			buttonView
		}
	}
	private var buttonView: some View{
		HStack{
			resetButton
			startPauseButton
		}
		.padding(.bottom,40)
		.padding(.horizontal,20)
	}
	private var resetButton: some View{
		Button{
			reset()
		}label: {
			HStack(spacing:8){
				Image(systemName: "arrow.clockwise")
					.rotationEffect(.degrees(Double(rotation)))
				Text("Reset")
			}
			.padding()
			.tint(.black)
			.frame(maxWidth: .infinity)
			.font(.system(size: 18,weight: .bold))
		}
		.background(Color(red: 236/255, green: 230/255, blue: 0/255))
		.cornerRadius(15)
	}
	private var startPauseButton: some View{
		Button{
			if timerViewModel.progress < 1 {
				isPaused.toggle()
				isPaused ? timerViewModel.pauseSession() : timerViewModel.startSession()
			}
		}label: {
			HStack(spacing:8){
				Image(systemName: isPaused ? "play.fill" : "pause.fill")
				Text(isPaused ? "Start" : "Pause")
			}
			.padding()
			.tint(.black)
			.frame(maxWidth: .infinity)
			.font(.system(size: 18,weight: .bold))
		}
		.background(Color(red: 236/255, green: 230/255, blue: 0/255))
		.cornerRadius(15)
	}
	//MARK: - Private Methods
	private func reset(){
		withAnimation(.easeInOut(duration:0.4)){
			rotation += 360
		}
		if timerViewModel.progress >= 1{
			timerViewModel.reset()
			timerViewModel.startSession()
		}
		else{
			timerViewModel.reset()
			timerViewModel.displayTime = "00:00"
		}
	}
}

#Preview {
    ContentView()
}
