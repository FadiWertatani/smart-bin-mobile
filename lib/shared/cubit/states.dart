abstract class AppStates {}

class AppInitialStates extends AppStates {}

class AppLoadingStates extends AppStates {}

class RegisterSuccessStates extends AppStates {}

class AppErrorStates extends AppStates {
  final String error;
  AppErrorStates(this.error);
}

//Bottom nav states
class ChangeHomeBottomNavStates extends AppStates {}
