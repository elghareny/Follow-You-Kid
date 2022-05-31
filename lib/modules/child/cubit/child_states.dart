abstract class ChildStates{}

class InitialState extends ChildStates{}

class ChangeBottomNavBarState extends ChildStates{}
class NavigateTo extends ChildStates{}

class ChangePasswordVisiblityState extends ChildStates{}
class ChangeConfirmPasswordVisiblityState extends ChildStates{}

///////////////////////////////////////////////////////////////////////////////////////  user  /////




class UserRegisterLoadingState extends ChildStates{}
class UserRegisterSuccessState extends ChildStates
{
  final String uId;

  UserRegisterSuccessState(this.uId);
}
class UserRegisterErrorState extends ChildStates
{
  final String error;
  UserRegisterErrorState(this.error);
}


class UserLoginLoadingState extends ChildStates{}
class UserLoginSuccessState extends ChildStates
{
   final String uId;

  UserLoginSuccessState(this.uId);
}
class UserLoginErrorState extends ChildStates
{
  final String error;
  UserLoginErrorState(this.error);
}


class UserCreateSuccessState extends ChildStates
{
   final String uId;

  UserCreateSuccessState(this.uId);
}
class UserCreateErrorState extends ChildStates
{
  final String error;
  UserCreateErrorState(this.error);
}


class LogoutSuccessState extends ChildStates{}