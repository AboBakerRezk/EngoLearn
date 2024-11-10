import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProgressState {
  final int reading;
  final int listening;
  final int writing;
  final int grammar;
  final int bottleLevel;

  ProgressState({
    required this.reading,
    required this.listening,
    required this.writing,
    required this.grammar,
    required this.bottleLevel,
  });
}

class ProgressInitial extends ProgressState {
  ProgressInitial()
      : super(reading: 0, listening: 0, writing: 0, grammar: 0, bottleLevel: 0);
}

class ProgressLoaded extends ProgressState {
  ProgressLoaded({
    required int reading,
    required int listening,
    required int writing,
    required int grammar,
    required int bottleLevel,
  }) : super(
    reading: reading,
    listening: listening,
    writing: writing,
    grammar: grammar,
    bottleLevel: bottleLevel,
  );
}



class ProgressCubit extends Cubit<ProgressState> {
  ProgressCubit() : super(ProgressInitial()) {
    loadProgressIndicators();
  }

  Future<void> loadProgressIndicators() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emit(ProgressLoaded(
      reading: prefs.getInt('progressReading') ?? 0,
      listening: prefs.getInt('progressListening') ?? 0,
      writing: prefs.getInt('progressWriting') ?? 0,
      grammar: prefs.getInt('progressGrammar') ?? 0,
      bottleLevel: prefs.getInt('bottleLevel') ?? 0,
    ));
  }

  Future<void> saveProgressIndicators({
    required int reading,
    required int listening,
    required int writing,
    required int grammar,
    required int bottleLevel,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('progressReading', reading);
    await prefs.setInt('progressListening', listening);
    await prefs.setInt('progressWriting', writing);
    await prefs.setInt('progressGrammar', grammar);
    await prefs.setInt('bottleLevel', bottleLevel);

    emit(ProgressLoaded(
      reading: reading,
      listening: listening,
      writing: writing,
      grammar: grammar,
      bottleLevel: bottleLevel,
    ));
  }

  void updateProgress(int completedTasks) {
    int reading = (completedTasks ~/ 300).clamp(0, 5);
    int listening = (completedTasks ~/ 300).clamp(0, 5);
    int writing = (completedTasks ~/ 300).clamp(0, 5);
    int grammar = (completedTasks ~/ 300).clamp(0, 5);
    int bottleLevel = (completedTasks ~/ 300);

    saveProgressIndicators(
      reading: reading,
      listening: listening,
      writing: writing,
      grammar: grammar,
      bottleLevel: bottleLevel,
    );
  }
}
