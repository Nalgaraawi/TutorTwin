import SwiftUI

struct ReadingDiscoveryView: View {
    let mode: String

    @State private var answerOne = ""
    @State private var answerTwo = ""
    @State private var answerThree = ""
    @State private var aiAnalysis = ""
    @State private var isLoading = false
    @State private var showAnalysisSheet = false

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 18) {
                    Text("Literacy Discovery")
                        .font(AppTheme.gotu(30))
                        .minimumScaleFactor(0.7)
                        .lineLimit(1)
                        .padding(.top, 25)

                    Text("Short Passage")
                        .font(AppTheme.gotu(24))

                    Text(instructionText)
                        .font(.system(size: 16))
                        .foregroundStyle(AppTheme.primaryBlue)
                        .lineLimit(2)

                    PassageCard(showText: true, showSpeaker: mode == "Audio")
                        .frame(height: 300)

                    Text("Questions")
                        .font(AppTheme.gotu(24))

                    VStack(spacing: 14) {
                        TextField("What happened first?", text: $answerOne)
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))

                        TextField("Why did the character do that?", text: $answerTwo)
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))

                        TextField("What might happen next?", text: $answerThree)
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }

                    Button {
                        analyzeAnswers()
                    } label: {
                        PrimaryCapsuleButton(title: isLoading ? "Analyzing..." : "Analyze Answers")
                    }
                    .buttonStyle(.plain)
                    .disabled(isLoading)

                    Spacer(minLength: 120)
                }
                .padding(.horizontal, 28)
                .padding(.bottom, 130)
            }

            TabBar(selectedTab: .current)
                .padding(.horizontal, 18)
                .padding(.bottom, 8)
        }
        .background(AppTheme.background.ignoresSafeArea())
        .sheet(isPresented: $showAnalysisSheet) {
            AnalysisSheetView(aiAnalysis: aiAnalysis)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }

    var instructionText: String {
        mode == "Audio"
        ? "Student: Begin listening to short passage, then answer questions."
        : "Student: Begin reading short passage, then answer questions."
    }

    func analyzeAnswers() {
        isLoading = true
        aiAnalysis = ""

        Task {
            do {
                let prompt = """
                You are TutorTwin's literacy AI assistant.

                Analyze this student's reading comprehension answers.

                Passage:
                Maya woke up early because she was excited for the school science fair. She helped Jordan fix his project before judging started.

                Student answers:
                1. \(answerOne)
                2. \(answerTwo)
                3. \(answerThree)

                Give short, supportive feedback on comprehension, vocabulary, and what the student should practice next.
                """

                aiAnalysis = try await WatsonXService.shared.generate(prompt: prompt)
            } catch {
                aiAnalysis = "AI connection error: \(error.localizedDescription)"
            }

            isLoading = false
            showAnalysisSheet = true
        }
    }
}

struct AnalysisSheetView: View {
    let aiAnalysis: String

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("AI Analysis")
                .font(AppTheme.gotu(28))
                .padding(.top)

            ScrollView {
                Text(aiAnalysis.isEmpty ? "No analysis available." : aiAnalysis)
                    .font(.system(size: 18))
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(AppTheme.background)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }

            Spacer()
        }
        .padding(24)
    }
}
