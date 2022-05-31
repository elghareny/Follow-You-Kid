abstract class ParentStates{}

class InitialState extends ParentStates{}

class NavigateTo extends ParentStates{}

class ChangePasswordVisiblityState extends ParentStates{}
class ChangeConfirmPasswordVisiblityState extends ParentStates{}

///////////////////////////////////////////////////////////////////////////////////////  user  /////




class UserRegisterLoadingState extends ParentStates{}
class UserRegisterSuccessState extends ParentStates
{
  final String uId;

  UserRegisterSuccessState(this.uId);
}
class UserRegisterErrorState extends ParentStates
{
  final String error;
  UserRegisterErrorState(this.error);
}


class UserLoginLoadingState extends ParentStates{}
class UserLoginSuccessState extends ParentStates
{
   final String uId;

  UserLoginSuccessState(this.uId);
}
class UserLoginErrorState extends ParentStates
{
  final String error;
  UserLoginErrorState(this.error);
}


class UserCreateSuccessState extends ParentStates
{
   final String uId;

  UserCreateSuccessState(this.uId);
}
class UserCreateErrorState extends ParentStates
{
  final String error;
  UserCreateErrorState(this.error);
}


class LogoutSuccessState extends ParentStates{}