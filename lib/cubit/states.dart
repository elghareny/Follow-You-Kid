abstract class ProjectStates{}
class ProjectInitialState extends ProjectStates{}


/////////////////////////////////////////////////////////////////   child   ///////////////////


class ProjectGetUserLoadingState extends ProjectStates{}
class ProjectGetUserSuccessState extends ProjectStates{}
class ProjectGetUserErrorState extends ProjectStates
{
  final String error;

  ProjectGetUserErrorState(this.error);
}

////////////////////////////////////////////////////// 


class ProjectGetHomeLoadingState extends ProjectStates{}
class ProjectGetHomeSuccessState extends ProjectStates{}
class ProjectGetHomeErrorState extends ProjectStates
{
  final String error;

  ProjectGetHomeErrorState(this.error);
}



class HomeCreateSuccessState extends ProjectStates
{
  final String uId;

  HomeCreateSuccessState(this.uId);
}
class HomeCreateErrorState extends ProjectStates
{
  final String error;

  HomeCreateErrorState(this.error);
}

/////////////////////////////////////////////////////////////////   parent  ///////


class ProjectGetParentLoadingState extends ProjectStates{}
class ProjectGetParentSuccessState extends ProjectStates{}
class ProjectGetParentErrorState extends ProjectStates
{
  final String error;

  ProjectGetParentErrorState(this.error);
}


/////////////////////////////////////////////////////////////////////////////////////



class EaditDataLoadingState extends ProjectStates{}
class EaditDataSuccessState extends ProjectStates{}
class EaditDataErrorState extends ProjectStates
{
  final String error;

  EaditDataErrorState(this.error);
}




class UploadProfileSuccessState extends ProjectStates{}
class UploadProfileErrorState extends ProjectStates
{
  final String error;

  UploadProfileErrorState(this.error);
}







class LogoutSuccessState extends ProjectStates{}
class LogoutErrorState extends ProjectStates
{
  final String error;

  LogoutErrorState(this.error);
}





class VerifiedSuccessState extends ProjectStates{}
class VerifiedErrorState extends ProjectStates
{
  final String error;

  VerifiedErrorState(this.error);
}


/////////////////////////////////////////////////////////////////////////////////////



class ProfileImageSuccessState extends ProjectStates{}
class ProfileImageErrorState extends ProjectStates
{
  final String error;

  ProfileImageErrorState(this.error);
}




////////////////////////////////////////////////////////  Connect TO Child   //////////////


class ConnectTOChildLoadingState extends ProjectStates{}
class ConnectTOChildSuccessState extends ProjectStates
{
  final String uId;

  ConnectTOChildSuccessState(this.uId);
}
class ConnectTOChildErrorState extends ProjectStates
{
  final String error;

  ConnectTOChildErrorState(this.error);
}



////////////////////////////////////////////////////////////////////////////////////////



class ChangeBottomNavBarState extends ProjectStates{}
class SwitchState extends ProjectStates{}
class ChangePasswordVisiblityState extends ProjectStates{}
class ChangeConfirmPasswordVisiblityState extends ProjectStates{}


class ChangeSliderState extends ProjectStates{}


class ChangeBottomSheetState extends ProjectStates{}