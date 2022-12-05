import 'package:bloc/bloc.dart';
import 'package:yo_app/bloc/user_event.dart';
import 'package:yo_app/bloc/user_state.dart';
import 'package:yo_app/services/user_api_provider.dart';
import 'package:yo_app/services/user_repo.dart';

import '../model/user.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc({required this.userRepository}) : super(UserEmptyState()) {
    on<UserLoadEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final List<User> userLoadedList = await userRepository.getAllUsers();
        emit(UserLoadedState(loadedUser: userLoadedList));
      } catch (e) {
        emit(UserErrorState());
      }
    });
    on<UserClearEvent>((event, emit) async {
      emit(UserEmptyState());
    });
  }
}
