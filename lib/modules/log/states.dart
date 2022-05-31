abstract class LoginStates{}

class InitialState extends LoginStates{}
class ChangeBottomNavBarState extends LoginStates{}
class NavigateTo extends LoginStates{}

class ChangePasswordVisiblityState extends LoginStates{}
class ChangeConfirmPasswordVisiblityState extends LoginStates{}




///////////////////////////////////////////////////////////////////////////////////////  user  /////




class UserRegisterLoadingState extends LoginStates{}
class UserRegisterSuccessState extends LoginStates
{
  final String uId;

  UserRegisterSuccessState(this.uId);
}
class UserRegisterErrorState extends LoginStates
{
  final String error;
  UserRegisterErrorState(this.error);
}


class UserLoginLoadingState extends LoginStates{}
class UserLoginSuccessState extends LoginStates
{
   final String uId;

  UserLoginSuccessState(this.uId);
}
class UserLoginErrorState extends LoginStates
{
  final String error;
  UserLoginErrorState(this.error);
}


class UserCreateSuccessState extends LoginStates
{
   final String uId;

  UserCreateSuccessState(this.uId);
}
class UserCreateErrorState extends LoginStates
{
  final String error;
  UserCreateErrorState(this.error);
}




class LogoutSuccessState extends LoginStates{}
