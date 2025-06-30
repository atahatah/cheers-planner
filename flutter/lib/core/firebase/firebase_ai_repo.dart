import 'package:cheers_planner/core/firebase/app_check_repo.dart';
import 'package:cheers_planner/core/firebase/auth_repo.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_ai_repo.g.dart';

@riverpod
FirebaseAI firebaseAi(Ref ref) {
  final auth = ref.watch(firebaseAuthProvider);
  final appCheck = ref.watch(firebaseAppCheckProvider);
  return FirebaseAI.googleAI(auth: auth, appCheck: appCheck);
}

enum GenerativeAIModels {
  gemini20flush('gemini-2.0-flash-001', 'Gemini 2.0 Flash'),
  gemini20flushLite('gemini-2.0-flash-lite-001', 'Gemini 2.0 Flash-Lite'),
  gemini25Pro('gemini-2.5-pro-preview-05-06', 'Gemini 2.5 Pro'),
  gemini25Flash('gemini-2.5-flash-preview-04-17', 'Gemini 2.5 Flash'),
  gemini25FlashLite(
    'gemini-2.0-flash-live-preview-04-09',
    'Gemini 2.0 Flash-Live',
  );

  const GenerativeAIModels(this.fullName, this.displayName);
  final String fullName;
  final String displayName;
}

@riverpod
class GenerativeAIModel extends _$GenerativeAIModel {
  @override
  GenerativeAIModels build() {
    return GenerativeAIModels.gemini20flush;
  }

  void set(GenerativeAIModels model) {
    state = model;
  }
}

mixin GeminiModelRepo {
  Future<String?> generateResponse(String prompt);
  ChatSessionRepo startChat({List<Tool>? tools});
}

class _GeminiModelRepoImpl implements GeminiModelRepo {
  _GeminiModelRepoImpl({
    required FirebaseAI firebaseAI,
    required GenerativeAIModels model,
  }) : _firebaseAI = firebaseAI,
       _modelName = model,
       _model = firebaseAI.generativeModel(model: model.fullName);

  final FirebaseAI _firebaseAI;
  final GenerativeAIModels _modelName;
  final GenerativeModel _model;

  @override
  Future<String?> generateResponse(String prompt) {
    return _model
        .generateContent([Content.text(prompt)])
        .then((value) => value.text);
  }

  @override
  ChatSessionRepo startChat({List<Tool>? tools}) {
    final m = tools != null && tools.isNotEmpty
        ? _firebaseAI.generativeModel(model: _modelName.fullName, tools: tools)
        : _model;
    return _ChatSessionRepoImpl(m.startChat());
  }
}

class _GeminiEchoMockImpl implements GeminiModelRepo {
  @override
  Future<String?> generateResponse(String prompt) async => prompt;

  @override
  ChatSessionRepo startChat({List<Tool>? tools}) =>
      _ChatSessionRepoEchoMockImpl();
}

mixin ChatSessionRepo {
  Future<GenerateContentResponse> sendMessage(Content message);
  Stream<GenerateContentResponse> sendMessageStream(Content message);
}

class _ChatSessionRepoImpl implements ChatSessionRepo {
  _ChatSessionRepoImpl(this._session);

  final ChatSession _session;

  @override
  Future<GenerateContentResponse> sendMessage(Content message) =>
      _session.sendMessage(message);

  @override
  Stream<GenerateContentResponse> sendMessageStream(Content message) =>
      _session.sendMessageStream(message);
}

class _ChatSessionRepoEchoMockImpl implements ChatSessionRepo {
  _ChatSessionRepoEchoMockImpl();
  final responseDelay = 100;

  @override
  Future<GenerateContentResponse> sendMessage(Content message) async {
    return GenerateContentResponse([
      Candidate(message, null, null, null, null),
    ], null);
  }

  @override
  Stream<GenerateContentResponse> sendMessageStream(Content message) async* {
    final textMessage = message.parts.whereType<TextPart>().firstOrNull?.text;
    if (textMessage == null) {
      yield GenerateContentResponse([
        Candidate(
          Content.text('No text messages contained'),
          null,
          null,
          null,
          null,
        ),
      ], null);
      return;
    }

    for (final char in textMessage.split('')) {
      await Future<void>.delayed(Duration(milliseconds: responseDelay));
      yield GenerateContentResponse([
        Candidate(Content.text(char), null, null, null, null),
      ], null);
    }
  }
}

@riverpod
class IsGeminiEchoMock extends _$IsGeminiEchoMock {
  @override
  bool build() {
    return false;
  }

  void set(bool newState) {
    state = newState;
  }
}

@riverpod
GeminiModelRepo geminiModelRepo(Ref ref) {
  final firebaseAI = ref.watch(firebaseAiProvider);
  final model = ref.watch(generativeAIModelProvider);
  final isGeminiEchoMock = ref.watch(isGeminiEchoMockProvider);
  if (isGeminiEchoMock) {
    return _GeminiEchoMockImpl();
  }
  return _GeminiModelRepoImpl(firebaseAI: firebaseAI, model: model);
}
