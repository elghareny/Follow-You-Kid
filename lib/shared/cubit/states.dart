abstract class AppStates{}

class InitialState extends AppStates{}
class ChangeBottomNavBarState extends AppStates{}
class NavigateTo extends AppStates{}

class ChangePasswordVisiblityState extends AppStates{}
class ChangeConfirmPasswordVisiblityState extends AppStates{}




///////////////////////////////////////////////////////////////////////////////////////  user  /////




class UserRegisterLoadingState extends AppStates{}
class UserRegisterSuccessState extends AppStates
{
  final String uId;

  UserRegisterSuccessState(this.uId);
}
class UserRegisterErrorState extends AppStates
{
  final String error;
  UserRegisterErrorState(this.error);
}


class UserLoginLoadingState extends AppStates{}
class UserLoginSuccessState extends AppStates
{
   final String uId;

  UserLoginSuccessState(this.uId);
}
class UserLoginErrorState extends AppStates
{
  final String error;
  UserLoginErrorState(this.error);
}


class UserCreateSuccessState extends AppStates
{
   final String uId;

  UserCreateSuccessState(this.uId);
}
class UserCreateErrorState extends AppStates
{
  final String error;
  UserCreateErrorState(this.error);
}



///////////////////////////////////////////////////////////////////////////////////////  Parent /////



class ParentRegisterLoadingState extends AppStates{}
class ParentRegisterSuccessState extends AppStates
{
  final String uId;

  ParentRegisterSuccessState(this.uId);
}
class ParentRegisterErrorState extends AppStates
{
  final String error;
  ParentRegisterErrorState(this.error);
}


class ParentLoginLoadingState extends AppStates{}
class ParentLoginSuccessState extends AppStates
{
  final String uId;

  ParentLoginSuccessState(this.uId);
}
class ParentLoginErrorState extends AppStates
{
  final String error;
  ParentLoginErrorState(this.error);
}


class ParentCreateSuccessState extends AppStates
{
   final String uId;

  ParentCreateSuccessState(this.uId);
}
class ParentCreateErrorState extends AppStates
{
  final String error;
  ParentCreateErrorState(this.error);
}


class HomeFirstCreateSuccessState extends AppStates
{
  final String uId;

  HomeFirstCreateSuccessState(this.uId);
}
class HomeFirstCreateErrorState extends AppStates
{
  final String error;

  HomeFirstCreateErrorState(this.error);
}



class LogoutSuccessState extends AppStates{}




/////////////////////////////////////////////////////////



class ProjectGetUserLoadingState extends AppStates{}
class ProjectGetUserSuccessState extends AppStates{}
class ProjectGetUserErrorState extends AppStates
{
  final String error;

  ProjectGetUserErrorState(this.error);
}