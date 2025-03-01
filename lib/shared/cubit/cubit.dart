import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smar_bin/modules/HomeScreen.dart';
import 'package:smar_bin/modules/ProfileScreen.dart';
import 'package:smar_bin/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  // home Cubit
  int homeCurrentIndex = 1;

  List<Widget> homeBottomScreens = [
    HomeScreen(),
    ProfileScreen(),
  ];

  void homeChangeBottom(int index) {
    homeCurrentIndex = index;
    emit(ChangeHomeBottomNavStates());
  }
}