import SwiftUI
import Combine

struct Model: Identifiable, Decodable {
    let id: String
    let name: String
    let category: String
    let provider: String
    let useCases: [String]
    let link: String
    let pricing: String
    let specificity: String
    let apiDocs: String
    let rating: Double

    init(id: String, name: String, category: String, provider: String, useCases: [String], link: String, pricing: String, specificity: String, apiDocs: String, rating: Double) {
        self.id = id
        self.name = name
        self.category = category
        self.provider = provider
        self.useCases = useCases
        self.link = link
        self.pricing = pricing
        self.specificity = specificity
        self.apiDocs = apiDocs
        self.rating = rating

        // Validate URLs
        guard URL(string: link) != nil, URL(string: apiDocs) != nil else {
            fatalError("Invalid URL in model initialization: \(name)")
        }
    }
}

struct ChatMessage: Identifiable {
    let id = UUID()
    let content: String
    let isUser: Bool
    var isButtonMessage: Bool = false
}

class NeuroNexusViewModel: ObservableObject {
    @Published var chatMessages: [ChatMessage] = [
        ChatMessage(content: "🤖 Hi! I'm your AI assistant. Describe your project needs and I'll recommend the best models!\n🎯 Example: \"I need to generate product images\"", isUser: false)
    ]

    @Published var models = [
        Model(
            id: "gpt-4",
            name: "GPT-4",
            category: "Natural Language",
            provider: "OpenAI",
            useCases: ["Chatbots", "Content Generation", "Code Assistance"],
            link: "https://openai.com/gpt-4",
            pricing: "Paid",
            specificity: "General",
            apiDocs: "https://platform.openai.com/docs",
            rating: 4.8
        ),
        Model(
            id: "gemini-pro",
            name: "Gemini Pro",
            category: "Multimodal",
            provider: "Google",
            useCases: ["Text Analysis", "Image Recognition", "Data Synthesis"],
            link: "https://ai.google.dev/",
            pricing: "Free Tier",
            specificity: "General",
            apiDocs: "https://ai.google.dev/docs",
            rating: 4.7
        ),
        Model(
            id: "dall-e-3",
            name: "DALL-E 3",
            category: "Image Generation",
            provider: "OpenAI",
            useCases: ["Art Creation", "Design Prototyping", "Marketing Visuals"],
            link: "https://openai.com/dall-e-3",
            pricing: "Paid",
            specificity: "Specific",
            apiDocs: "https://platform.openai.com/docs/models/dall-e",
            rating: 4.9
        ),
        Model(
            id: "claude-3",
            name: "Claude 3",
            category: "Natural Language",
            provider: "Anthropic",
            useCases: ["Document Analysis", "Legal Review", "Research Assistance"],
            link: "https://anthropic.com/claude",
            pricing: "Paid",
            specificity: "General",
            apiDocs: "https://docs.anthropic.com",
            rating: 4.7
        ),
        Model(
            id: "stable-diffusion-3",
            name: "Stable Diffusion 3",
            category: "Image Generation",
            provider: "Stability AI",
            useCases: ["Concept Art", "Product Visualization", "Social Media Content"],
            link: "https://stability.ai/sd3",
            pricing: "Free Tier",
            specificity: "General",
            apiDocs: "https://api.stability.ai/docs",
            rating: 4.6
        ),
        Model(
            id: "llama-3",
            name: "Llama 3",
            category: "Natural Language",
            provider: "Meta",
            useCases: ["Conversational AI", "Content Moderation", "Language Translation"],
            link: "https://ai.meta.com/llama",
            pricing: "Open Source",
            specificity: "General",
            apiDocs: "https://llama.meta.com/docs",
            rating: 4.5
        ),
        Model(
            id: "microsoft-copilot",
            name: "Microsoft Copilot",
            category: "Code Generation",
            provider: "Microsoft",
            useCases: ["Code Completion", "Debugging", "API Integration"],
            link: "https://copilot.microsoft.com",
            pricing: "Paid",
            specificity: "Specific",
            apiDocs: "https://learn.microsoft.com/copilot",
            rating: 4.6
        ),
        Model(
            id: "midjourney-v6",
            name: "Midjourney v6",
            category: "Image Generation",
            provider: "Midjourney",
            useCases: ["Concept Art", "Marketing Visuals", "UI/UX Design"],
            link: "https://midjourney.com",
            pricing: "Paid",
            specificity: "General",
            apiDocs: "https://docs.midjourney.com",
            rating: 4.8
        ),
        Model(
            id: "aws-titan",
            name: "AWS Titan",
            category: "Multimodal",
            provider: "Amazon",
            useCases: ["Document Processing", "Search Enhancement", "Personalization"],
            link: "https://aws.amazon.com/bedrock/titan",
            pricing: "Paid",
            specificity: "General",
            apiDocs: "https://docs.aws.amazon.com/bedrock",
            rating: 4.4
        ),
        Model(
            id: "nvidia-nemo",
            name: "NeMo",
            category: "Speech Recognition",
            provider: "NVIDIA",
            useCases: ["Voice Assistants", "Transcription", "Speech Synthesis"],
            link: "https://www.nvidia.com/nemo",
            pricing: "Enterprise",
            specificity: "Specific",
            apiDocs: "https://docs.nvidia.com/nemo",
            rating: 4.7
        ),
        Model(
            id: "cohere-command",
            name: "Cohere Command",
            category: "Natural Language",
            provider: "Cohere",
            useCases: ["Text Generation", "Classification", "Semantic Search"],
            link: "https://cohere.com/command",
            pricing: "Paid",
            specificity: "General",
            apiDocs: "https://docs.cohere.com",
            rating: 4.5
        ),
        Model(
            id: "openai-whisper",
            name: "Whisper",
            category: "Speech Recognition",
            provider: "OpenAI",
            useCases: ["Audio Transcription", "Translation", "Voice Commands"],
            link: "https://openai.com/whisper",
            pricing: "Free Tier",
            specificity: "General",
            apiDocs: "https://platform.openai.com/docs/whisper",
            rating: 4.6
        ),
        Model(
            id: "google-imagen",
            name: "Imagen 2",
            category: "Image Generation",
            provider: "Google",
            useCases: ["Product Visualization", "Ad Creation", "Prototyping"],
            link: "https://imagen.research.google",
            pricing: "Paid",
            specificity: "General",
            apiDocs: "https://cloud.google.com/imagen",
            rating: 4.7
        ),
        Model(
            id: "stability-video",
            name: "Stable Video",
            category: "Video Generation",
            provider: "Stability AI",
            useCases: ["Ad Creation", "Social Media Content", "Prototyping"],
            link: "https://stability.ai/video",
            pricing: "Paid",
            specificity: "Specific",
            apiDocs: "https://api.stability.ai/video-docs",
            rating: 4.3
        ),
        Model(
            id: "huggingface-llama",
            name: "HuggingChat",
            category: "Natural Language",
            provider: "Hugging Face",
            useCases: ["Conversational AI", "Text Summarization", "Research"],
            link: "https://huggingface.co/chat",
            pricing: "Free Tier",
            specificity: "General",
            apiDocs: "https://huggingface.co/docs",
            rating: 4.2
        ),
        Model(
            id: "deepmind-gato",
            name: "Gato",
            category: "General AI",
            provider: "DeepMind",
            useCases: ["Multitask Learning", "Robotics", "Game Playing"],
            link: "https://deepmind.com/gato",
            pricing: "Research",
            specificity: "General",
            apiDocs: "https://deepmind.com/docs/gato",
            rating: 4.8
        ),
        Model(
            id: "tesla-optimus",
            name: "Optimus AI",
            category: "Robotics",
            provider: "Tesla",
            useCases: ["Industrial Automation", "Service Robots", "Logistics"],
            link: "https://tesla.com/optimus",
            pricing: "Enterprise",
            specificity: "Specific",
            apiDocs: "https://developer.tesla.com/optimus",
            rating: 4.5
        ),
        Model(
            id: "ibm-watsonx",
            name: "watsonx",
            category: "Enterprise AI",
            provider: "IBM",
            useCases: ["Business Analytics", "Risk Management", "Supply Chain"],
            link: "https://ibm.com/watsonx",
            pricing: "Enterprise",
            specificity: "General",
            apiDocs: "https://developer.ibm.com/watsonx",
            rating: 4.4
        ),
        Model(
            id: "salesforce-einstein",
            name: "Einstein GPT",
            category: "Business AI",
            provider: "Salesforce",
            useCases: ["CRM Automation", "Sales Forecasting", "Customer Service"],
            link: "https://salesforce.com/einstein",
            pricing: "Paid",
            specificity: "Specific",
            apiDocs: "https://developer.salesforce.com/einstein",
            rating: 4.3
        ),
        Model(
            id: "baidu-ernie",
            name: "ERNIE 4.0",
            category: "Natural Language",
            provider: "Baidu",
            useCases: ["Chinese NLP", "Search Engine", "Content Moderation"],
            link: "https://ernie.baidu.com",
            pricing: "Paid",
            specificity: "Regional",
            apiDocs: "https://developer.baidu.com/ernie",
            rating: 4.5
        ),
        Model(
            id: "alibaba-tongyi",
            name: "Tongyi Qianwen",
            category: "Enterprise AI",
            provider: "Alibaba",
            useCases: ["E-commerce", "Supply Chain", "Customer Service"],
            link: "https://alibaba.com/tongyi",
            pricing: "Enterprise",
            specificity: "Specific",
            apiDocs: "https://developer.alibaba.com/tongyi",
            rating: 4.4
        ),
        Model(
            id: "nvidia-clara",
            name: "Clara Imaging",
            category: "Healthcare",
            provider: "NVIDIA",
            useCases: ["Medical Imaging", "Drug Discovery", "Patient Monitoring"],
            link: "https://www.nvidia.com/clara",
            pricing: "Enterprise",
            specificity: "Medical",
            apiDocs: "https://developer.nvidia.com/clara",
            rating: 4.7
        ),
        Model(
            id: "huggingface-codegen",
            name: "CodeGen 2.5",
            category: "Code Generation",
            provider: "Hugging Face",
            useCases: ["Auto-completion", "Code Refactoring", "Documentation"],
            link: "https://huggingface.co/codegen",
            pricing: "Free Tier",
            specificity: "General",
            apiDocs: "https://hf.co/docs/codegen",
            rating: 4.4
        ),
        Model(
            id: "tesla-optimus-prime",
            name: "Optimus Prime",
            category: "Robotics",
            provider: "Tesla",
            useCases: ["Manufacturing", "Warehouse Automation", "Hazardous Environments"],
            link: "https://tesla.com/optimus",
            pricing: "Enterprise",
            specificity: "Industrial",
            apiDocs: "https://developer.tesla.com/robotics",
            rating: 4.6
        ),
        Model(
            id: "deepmind-alphafold3",
            name: "AlphaFold 3",
            category: "Biology",
            provider: "DeepMind",
            useCases: ["Protein Folding", "Drug Design", "Disease Research"],
            link: "https://deepmind.com/alphafold",
            pricing: "Research",
            specificity: "Scientific",
            apiDocs: "https://alphafold.api",
            rating: 4.9
        ),
        Model(
            id: "ibm-watson-health",
            name: "Watson Health",
            category: "Medical",
            provider: "IBM",
            useCases: ["Diagnostics", "Treatment Plans", "Clinical Trials"],
            link: "https://ibm.com/watson-health",
            pricing: "Enterprise",
            specificity: "Healthcare",
            apiDocs: "https://developer.ibm.com/wh",
            rating: 4.5
        ),
        Model(
            id: "amazon-rekognition",
            name: "Rekognition",
            category: "Image Analysis",
            provider: "Amazon",
            useCases: ["Facial Recognition", "Content Moderation", "Object Detection"],
            link: "https://aws.amazon.com/rekognition",
            pricing: "Paid",
            specificity: "General",
            apiDocs: "https://docs.aws.amazon.com/rekognition",
            rating: 4.3
        ),
        Model(
            id: "microsoft-azure-speech",
            name: "Azure Speech",
            category: "Speech Processing",
            provider: "Microsoft",
            useCases: ["Real-time Translation", "Voice Commands", "Audio Transcription"],
            link: "https://azure.microsoft.com/speech",
            pricing: "Paid",
            specificity: "General",
            apiDocs: "https://learn.microsoft.com/speech",
            rating: 4.6
        ),
        Model(
            id: "salesforce-einstein-analytics",
            name: "Einstein Analytics",
            category: "Business Intelligence",
            provider: "Salesforce",
            useCases: ["Sales Forecasting", "Customer Insights", "Market Trends"],
            link: "https://salesforce.com/einstein/analytics",
            pricing: "Paid",
            specificity: "Business",
            apiDocs: "https://developer.salesforce.com/einstein",
            rating: 4.4
        ),
        Model(
            id: "facebook-blenderbot",
            name: "BlenderBot 3",
            category: "Conversational AI",
            provider: "Meta",
            useCases: ["Customer Service", "Social Companionship", "Information Retrieval"],
            link: "https://ai.facebook.com/blenderbot",
            pricing: "Free Tier",
            specificity: "General",
            apiDocs: "https://developers.facebook.com/blenderbot",
            rating: 4.2
        ),
        Model(
            id: "adobe-firefly",
            name: "Firefly",
            category: "Creative Tools",
            provider: "Adobe",
            useCases: ["Graphic Design", "Video Editing", "3D Modeling"],
            link: "https://adobe.com/firefly",
            pricing: "Paid",
            specificity: "Creative",
            apiDocs: "https://developer.adobe.com/firefly",
            rating: 4.7
        ),
        Model(
            id: "tencent-miiing",
            name: "Miying",
            category: "Healthcare",
            provider: "Tencent",
            useCases: ["Medical Diagnosis", "Radiology", "Telemedicine"],
            link: "https://medical.tencent.com/miying",
            pricing: "Enterprise",
            specificity: "Medical",
            apiDocs: "https://developer.tencent.com/miying",
            rating: 4.5
        ),
        Model(
            id: "samsung-gauss",
            name: "Gauss Edge",
            category: "Edge AI",
            provider: "Samsung",
            useCases: ["On-device Processing", "IoT Automation", "Mobile AI"],
            link: "https://samsung.com/gauss",
            pricing: "Device-bound",
            specificity: "Mobile",
            apiDocs: "https://developer.samsung.com/gauss",
            rating: 4.4
        ),
        Model(
            id: "intel-gaudi3",
            name: "Gaudi 3",
            category: "AI Training",
            provider: "Intel",
            useCases: ["Model Training", "Neural Architecture Search", "Optimization"],
            link: "https://intel.com/gaudi",
            pricing: "Enterprise",
            specificity: "Developer",
            apiDocs: "https://developer.intel.com/gaudi",
            rating: 4.6
        ),
        Model(
            id: "cerebras-cs3",
            name: "CS-3",
            category: "Large Models",
            provider: "Cerebras",
            useCases: ["Exascale Training", "Climate Modeling", "Genomics"],
            link: "https://cerebras.net/cs3",
            pricing: "Research",
            specificity: "Scientific",
            apiDocs: "https://docs.cerebras.net",
            rating: 4.8
        ),
        Model(
            id: "openai-jukebox",
            name: "Jukebox",
            category: "Music Generation",
            provider: "OpenAI",
            useCases: ["Song Composition", "Audio Remixing", "Sound Design"],
            link: "https://openai.com/jukebox",
            pricing: "Research",
            specificity: "Audio",
            apiDocs: "https://platform.openai.com/jukebox",
            rating: 4.3
        ),
        Model(
            id: "deepmind-wavenet",
            name: "WaveNet",
            category: "Speech Synthesis",
            provider: "DeepMind",
            useCases: ["Text-to-Speech", "Voice Cloning", "Audiobook Narration"],
            link: "https://deepmind.com/wavenet",
            pricing: "Paid",
            specificity: "Audio",
            apiDocs: "https://developer.deepmind.com/wavenet",
            rating: 4.7
        ),
        Model(
            id: "stability-audio",
            name: "Stable Audio",
            category: "Audio Generation",
            provider: "Stability AI",
            useCases: ["Music Production", "Sound Effects", "Podcast Editing"],
            link: "https://stability.ai/audio",
            pricing: "Freemium",
            specificity: "Creative",
            apiDocs: "https://api.stability.ai/audio",
            rating: 4.5
        ),
        Model(
            id: "cohere-generate",
            name: "Cohere Generate",
            category: "Content Creation",
            provider: "Cohere",
            useCases: ["Marketing Copy", "Product Descriptions", "Blog Writing"],
            link: "https://cohere.com/generate",
            pricing: "Paid",
            specificity: "Marketing",
            apiDocs: "https://docs.cohere.com/generate",
            rating: 4.4
        ),
        Model(
            id: "ai21-jurassic2",
            name: "Jurassic-2",
            category: "Multilingual NLP",
            provider: "AI21 Labs",
            useCases: ["Translation", "Content Localization", "Multilingual Chat"],
            link: "https://ai21.com/jurassic2",
            pricing: "Paid",
            specificity: "Language",
            apiDocs: "https://developer.ai21.com",
            rating: 4.6
        ),
        Model(
            id: "aleph-alpha-luminous",
            name: "Luminous",
            category: "Compliance",
            provider: "Aleph Alpha",
            useCases: ["Legal Documents", "GDPR Compliance", "Contract Analysis"],
            link: "https://aleph-alpha.com/luminous",
            pricing: "Enterprise",
            specificity: "Legal",
            apiDocs: "https://developer.aleph-alpha.com",
            rating: 4.5
        ),
        Model(
            id: "lg-brain",
            name: "LG Brain",
            category: "Home Automation",
            provider: "LG",
            useCases: ["Smart Homes", "Appliance Control", "Energy Optimization"],
            link: "https://lg.com/brain",
            pricing: "Device-bound",
            specificity: "IoT",
            apiDocs: "https://developer.lg.com/brain",
            rating: 4.3
        ),
        Model(
            id: "qualcomm-aimet",
            name: "AIMET",
            category: "Model Optimization",
            provider: "Qualcomm",
            useCases: ["Model Quantization", "Edge Deployment", "Performance Tuning"],
            link: "https://qualcomm.com/aimet",
            pricing: "Free",
            specificity: "Developer",
            apiDocs: "https://developer.qualcomm.com/aimet",
            rating: 4.4
        )
    ]

    @Published var currentModel: Model?
    @Published var activeSection: AppSection = .explore
    @Published var showModelDetail = false
    @Published var chatState = ChatState()
    @Published var generationOutput = ""
    @Published var inputPrompt = ""

    
    let GEMINI_API_KEY = "AIzaSyAEXITDDzX4yOoHl4tOuFEaxkqtniph1NY"

    func handleChatQuery(_ query: String) {
        guard !query.isEmpty else { return }

        chatMessages.append(ChatMessage(content: query, isUser: true))

        switch chatState.step {
        case 0:
            chatState.useCase = query
            chatState.step += 1
            showBudgetOptions()
        case 1:
            chatState.budget = query
            chatState.step += 1
            showSpecificityOptions()
        case 2:
            chatState.specificity = query
            showRecommendations()
        default: break
        }
    }

    private func showBudgetOptions() {
        let message = ChatMessage(
            content: "💰 What's your budget preference?",
            isUser: false,
            isButtonMessage: true
        )
        chatMessages.append(message)
    }

    private func showSpecificityOptions() {
        let message = ChatMessage(
            content: "🎯 How specific are your requirements?",
            isUser: false,
            isButtonMessage: true
        )
        chatMessages.append(message)
    }

    private func showRecommendations() {
        let recommendations = models.filter {
            $0.useCases.contains { $0.localizedCaseInsensitiveContains(chatState.useCase) } &&
            $0.pricing.localizedCaseInsensitiveContains(chatState.budget) &&
            $0.specificity.localizedCaseInsensitiveContains(chatState.specificity)
        }.prefix(3)

        var messageContent = "🚀 Recommended Models:\n"
        for model in recommendations {
            messageContent += "\n\(model.name) (\(model.provider)) ⭐ \(model.rating)"
        }

        chatMessages.append(ChatMessage(content: messageContent, isUser: false))
        chatState = ChatState()
    }

    func handleGeneration() async {
        guard !inputPrompt.isEmpty else {
            generationOutput = "💡 Please enter a prompt"
            return
        }

        let prompt = """
        Based on: \(inputPrompt)
        Recommend the best AI model from: \(models)

        Format:
        🏆 Best Model: [Model Name]
        💡 Reason: [Detailed analysis]
        🛠️ Implementation Steps:
        - [Step 1]
        - [Step 2]
        - [Step 3]
        """

        do {
            let response = try await fetchGeminiResponse(prompt: prompt)
            generationOutput = response
        } catch {
            generationOutput = "⚠️ Error: \(error.localizedDescription)"
        }
    }

    private func fetchGeminiResponse(prompt: String) async throws -> String {
        guard let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=\(GEMINI_API_KEY)") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody: [String: Any] = [
            "contents": [["parts": [["text": prompt]]]],
            "safetySettings": [
                ["category": "HARM_CATEGORY_DANGEROUS_CONTENT", "threshold": "BLOCK_ONLY_HIGH"]
            ],
            "generationConfig": [
                "temperature": 0.2,
                "topK": 20,
                "topP": 0.9,
                "maxOutputTokens": 1500
            ]
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        guard let candidates = json?["candidates"] as? [[String: Any]],
              let content = candidates.first?["content"] as? [String: Any],
              let parts = content["parts"] as? [[String: Any]],
              let text = parts.first?["text"] as? String else {
            throw URLError(.cannotParseResponse)
        }

        return text
    }
}

struct ChatState {
    var step = 0
    var useCase = ""
    var budget = ""
    var specificity = ""
}

enum AppSection: String, CaseIterable {
    case explore = "🔍 Explore"
    case categories = "🗂️ Categories"
    case trending = "🚀 Trending"
}

struct NeuroNexusApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}


struct ContentView: View {
    @StateObject private var vm = NeuroNexusViewModel()
    @FocusState private var isInputFocused: Bool

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    NavigationHeader(vm: vm)
                    ChatView(vm: vm, isInputFocused: _isInputFocused)
                    MainContentView(vm: vm)
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
        }
    }
}

struct NavigationHeader: View {
    @ObservedObject var vm: NeuroNexusViewModel

    var body: some View {
        HStack {
            if vm.showModelDetail {
                Button("← Back") {
                    withAnimation {
                        vm.showModelDetail = false
                        vm.currentModel = nil
                    }
                }
                .buttonStyle(SecondaryButtonStyle())
                .transition(.opacity)
            }

            Spacer()

            ForEach(AppSection.allCases, id: \.self) { section in
                Button {
                    withAnimation {
                        vm.activeSection = section
                        vm.showModelDetail = false
                    }
                } label: {
                    Text(section.rawValue)
                        .font(.system(size: 14, weight: .medium))
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(vm.activeSection == section ? Color.blue : Color.clear)
                        .foregroundColor(vm.activeSection == section ? .white : .primary)
                        .cornerRadius(8)
                }
                .disabled(vm.showModelDetail)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 4)
    }
}

struct ChatView: View {
    @ObservedObject var vm: NeuroNexusViewModel
    @FocusState var isInputFocused: Bool
    @State private var message = ""

    var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(vm.chatMessages) { message in
                            ChatBubble(message: message, vm: vm)
                                .id(message.id)
                        }
                    }
                    .padding()
                }
                .frame(height: 200)
                .background(Color.white)
                .cornerRadius(12)
                .onChange(of: vm.chatMessages) { _ in
                    proxy.scrollTo(vm.chatMessages.last?.id, anchor: .bottom)
                }
            }

            HStack {
                TextField("💬 Describe your project needs...", text: $message, axis: .vertical)
                    .focused($isInputFocused)
                    .textFieldStyle(ChatTextFieldStyle())
                    .onSubmit(sendMessage)

                Button(action: sendMessage) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 4)
        }
    }

    private func sendMessage() {
        vm.handleChatQuery(message)
        message = ""
        isInputFocused = false
    }
}

struct MainContentView: View {
    @ObservedObject var vm: NeuroNexusViewModel

    var body: some View {
        Group {
            if vm.showModelDetail, let model = vm.currentModel {
                ModelDetailView(vm: vm, model: model)
            } else {
                switch vm.activeSection {
                case .explore:
                    ModelGridView(models: vm.models, vm: vm)
                case .categories:
                    CategoryView(models: vm.models, vm: vm)
                case .trending:
                    TrendingView(models: vm.models, vm: vm)
                }
            }
        }
    }
}

struct ModelGridView: View {
    let models: [Model]
    @ObservedObject var vm: NeuroNexusViewModel

    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 300)), GridItem(.adaptive(minimum: 300))], spacing: 20) {
            ForEach(models) { model in
                ModelCardView(model: model, vm: vm)
            }
        }
    }
}

struct ModelCardView: View {
    let model: Model
    @ObservedObject var vm: NeuroNexusViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(model.name)
                    .font(.title3)
                    .bold()

                Spacer()

                TagView(text: "⭐ \(model.rating)", systemImage: "star.fill")
            }

            Text(model.useCases.joined(separator: " • "))
                .font(.subheadline)
                .foregroundColor(.gray)

            HStack {
                TagView(text: model.category, systemImage: "tag")
                TagView(text: model.provider, systemImage: "building.2")
            }

            HStack {
                Button {
                    withAnimation {
                        vm.currentModel = model
                        vm.showModelDetail = true
                    }
                } label: {
                    Label("Try", systemImage: "bolt.fill")
                }
                .buttonStyle(PrimaryButtonStyle())

                Button {
                    if let url = URL(string: model.apiDocs) {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    Label("Docs", systemImage: "doc.text.fill")
                }
                .buttonStyle(SecondaryButtonStyle())
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.05), radius: 4, y: 3)
    }
}

struct ModelDetailView: View {
    @ObservedObject var vm: NeuroNexusViewModel
    let model: Model

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    Text(model.name)
                        .font(.largeTitle.bold())

                    HStack {
                        TagView(text: model.provider, systemImage: "building.2")
                        TagView(text: model.category, systemImage: "tag")
                        TagView(text: model.rating, systemImage: "star.fill")
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("⚙️ Technical Specs")
                        .font(.title3.bold())

                    HStack {
                        TagView(text: model.pricing, systemImage: "dollarsign.circle")
                        if let url = URL(string: model.apiDocs) {
                            Link(destination: url) {
                                TagView(text: "API Docs", systemImage: "doc.text")
                            }
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("🎯 Use Cases")
                        .font(.title3.bold())

                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(model.useCases, id: \.self) { useCase in
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text(useCase)
                            }
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("🛠️ Model Playground")
                        .font(.title3.bold())

                    TagView(text: "🔑 API Key Integrated", systemImage: "key.fill")

                    TextEditor(text: $vm.inputPrompt)
                        .frame(minHeight: 100)
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(8)
                        .shadow(color: .gray.opacity(0.1), radius: 2)

                    HStack {
                        Button {
                            Task { await vm.handleGeneration() }
                        } label: {
                            Label("Generate", systemImage: "sparkles")
                        }
                        .buttonStyle(PrimaryButtonStyle())

                        Button {
                            if let url = URL(string: model.link) {
                                UIApplication.shared.open(url)
                            }
                        } label: {
                            Label("Visit Site", systemImage: "globe")
                        }
                        .buttonStyle(SecondaryButtonStyle())
                    }

                    if !vm.generationOutput.isEmpty {
                        Text(vm.generationOutput)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.systemGroupedBackground))
                            .cornerRadius(8)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(14)
            .shadow(color: .black.opacity(0.05), radius: 4, y: 3)
        }
    }
}

struct CategoryView: View {
    let models: [Model]
    @ObservedObject var vm: NeuroNexusViewModel

    var body: some View {
        let categories = Dictionary(grouping: models, by: { $0.category })

        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: 20) {
                ForEach(categories.keys.sorted(), id: \.self) { category in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(category)
                            .font(.title3.bold())

                        Text("\(categories[category]?.count ?? 0) models available")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        if let topProvider = categories[category]?
                            .reduce(into: [:]) { counts, model in 
                                counts[model.provider, default: 0] += 1 
                            }
                            .max(by: { $0.value < $1.value })?
                            .key {

                            TagView(text: "Top Provider: \(topProvider)", systemImage: "crown")
                        }

                        Button {
                            vm.currentModel = categories[category]?.first
                            vm.showModelDetail = true
                        } label: {
                            Label("Explore", systemImage: "magnifyingglass")
                        }
                        .buttonStyle(PrimaryButtonStyle())
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(14)
                    .shadow(color: .black.opacity(0.05), radius: 4, y: 3)
                }
            }
        }
    }
}

struct TrendingView: View {
    let models: [Model]
    @ObservedObject var vm: NeuroNexusViewModel

    var body: some View {
        let sortedModels = models.sorted { $0.rating > $1.rating }.prefix(3)

        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: 20) {
                ForEach(sortedModels) { model in
                    ModelCardView(model: model, vm: vm)
                }
            }
        }
    }
}

// MARK: - Components

struct TagView: View {
    let text: String
    let systemImage: String

    var body: some View {
        HStack {
            Image(systemName: systemImage)
            Text(text)
        }
        .font(.caption)
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .background(Color(.systemGray5))
        .cornerRadius(20)
    }
}

struct ChatBubble: View {
    let message: ChatMessage
    @ObservedObject var vm: NeuroNexusViewModel

    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
                Text(message.content)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            } else if message.isButtonMessage {
                ButtonOptionsView(content: message.content, vm: vm)
            } else {
                Text(message.content)
                    .padding()
                    .background(Color(.systemGray5))
                    .foregroundColor(.primary)
                    .cornerRadius(12)
                Spacer()
            }
        }
    }
}

struct ButtonOptionsView: View {
    let content: String
    @ObservedObject var vm: NeuroNexusViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(content)

            HStack {
                switch vm.chatState.step {
                case 1:
                    Button("🎁 Free Tier") { vm.handleChatQuery("Free Tier") }
                    Button("💳 Paid") { vm.handleChatQuery("Paid") }
                    Button("🏢 Enterprise") { vm.handleChatQuery("Enterprise") }
                case 2:
                    Button("🌐 General Purpose") { vm.handleChatQuery("General") }
                    Button("🎯 Domain Specific") { vm.handleChatQuery("Specific") }
                default: EmptyView()
                }
            }
            .buttonStyle(OptionButtonStyle())
        }
        .padding()
        .background(Color(.systemGray5))
        .cornerRadius(12)
    }
}

// MARK: - Styles

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .opacity(configuration.isPressed ? 0.8 : 1)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(Color(.systemGray5))
            .foregroundColor(.primary)
            .cornerRadius(8)
            .opacity(configuration.isPressed ? 0.8 : 1)
    }
}

struct ChatTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(8)
    }
}

struct OptionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(Color.white)
            .foregroundColor(.blue)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.blue, lineWidth: 1)
            )
            .opacity(configuration.isPressed ? 0.8 : 1)
    }
}