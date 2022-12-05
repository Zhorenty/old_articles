import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class MyConnectionState {
  final bool connected;
  MyConnectionState(this.connected);
}

class ConnectionCubit extends Cubit<MyConnectionState> {
  late StreamSubscription<ConnectivityResult> _subscription;
  ConnectionCubit() : super(MyConnectionState(false)) {
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      emit(MyConnectionState(result != ConnectivityResult.none));
    });
  }
  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
