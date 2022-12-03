import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

abstract class ColorEvent {}

class RedColorEvent extends ColorEvent {}

class GreenColorEvent extends ColorEvent {}

class ColorBloc extends Bloc<ColorEvent, Color> {
  ColorBloc() : super(Colors.red) {
    on<RedColorEvent>((event, emit) => emit(Colors.red));
    on<GreenColorEvent>((event, emit) => emit(Colors.green));
  }
}
