import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smar_bin/modules/HomeScreen.dart';
import 'package:smar_bin/shared/cubit/states.dart';

import '../../modules/Profile.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  // home Cubit
  int homeCurrentIndex = 0;

  List<Widget> homeBottomScreens = [
    HomeScreen(),
    Profile(),
  ];

  void homeChangeBottom(int index) {
    homeCurrentIndex = index;
    emit(ChangeHomeBottomNavStates());
  }
}