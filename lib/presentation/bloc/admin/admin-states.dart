

abstract class AdminStates{
}


class AppIntialState extends AdminStates{


}

class GetCatSuccessState extends AdminStates{


  GetCatSuccessState();
}

class ChangeWaitSuccessState extends AdminStates{

  ChangeWaitSuccessState();
}
class ChangeWaitSuccessState2 extends AdminStates{

  ChangeWaitSuccessState2();
}

class ChangeCatSuccessState extends AdminStates{

  ChangeCatSuccessState();
}
class ChangeCatFirstSuccessState extends AdminStates{

  ChangeCatFirstSuccessState();
}
class ChangeCountryFirstSuccessState extends AdminStates{

  ChangeCountryFirstSuccessState();
}

class ChangeCountrySuccessState extends AdminStates{

  ChangeCountrySuccessState();
}


class AddNewSplashSuccessState extends AdminStates{


  AddNewSplashSuccessState();
}


class AddNewProductSuccessState extends AdminStates{


  AddNewProductSuccessState();
}

class AddNewCatSuccessState extends AdminStates{


  AddNewCatSuccessState();
}

class EditProductsSuccessState extends AdminStates{


  EditProductsSuccessState();
}


class DeleteProductsSuccessState extends AdminStates{


  DeleteProductsSuccessState();
}


class GetAllDoctorsErrorState extends AdminStates{

  final String error;

  GetAllDoctorsErrorState(this.error);
}

class GetAllAdsSuccessState extends AdminStates{


  GetAllAdsSuccessState();
}


class ChangeDataSuccessState extends AdminStates{


  ChangeDataSuccessState();
}

class GetAllSalesLoadingState extends AdminStates{


  GetAllSalesLoadingState();
}


class GetAllSalesErrorState extends AdminStates{

  final String error;

  GetAllSalesErrorState(this.error);
}

class GetAllSalesSuccessState extends AdminStates{


  GetAllSalesSuccessState();
}













class GetAllSystemLoadingState extends AdminStates{



}


class GetAllSystemErrorState extends AdminStates{

  final String error;

  GetAllSystemErrorState(this.error);
}


class GetAllSystemSuccessState extends AdminStates{


  GetAllSystemSuccessState();
}




class GetAllAdsLoadingState extends AdminStates{


  GetAllAdsLoadingState();
}


class GetAllAdsErrorState extends AdminStates{

  final String error;

  GetAllAdsErrorState(this.error);
}


class GetAllBookingSuccessState extends AdminStates{


  GetAllBookingSuccessState();
}


class GetAllBookingLoadingState extends AdminStates{


  GetAllBookingLoadingState();
}


class GetAllBookingErrorState extends AdminStates{

  final String error;

  GetAllBookingErrorState(this.error);
}
class getBakaSuccessState extends AdminStates{
}

class getBakaLoadingState extends AdminStates{
}

class getBakaErrorState extends AdminStates{
  String error;
  getBakaErrorState({required this.error});
}


class  DeleteDoctorsSuccessState extends AdminStates{

  DeleteDoctorsSuccessState();
}

class DeleteDoctorsLoadingState extends AdminStates{

  DeleteDoctorsLoadingState();
}


class DeleteDoctorsErrorState extends AdminStates{
  final String error;
  DeleteDoctorsErrorState(this.error);
}


class  BestDoctorsSuccessState extends AdminStates{

  BestDoctorsSuccessState();
}

class BestDoctorsLoadingState extends AdminStates{

  BestDoctorsLoadingState();
}


class BestDoctorsErrorState extends AdminStates{

}



class  DeleteAdSuccessState extends AdminStates{


  DeleteAdSuccessState();
}

class DeleteAdLoadingState extends AdminStates{

  DeleteAdLoadingState();
}


class DeleteAdErrorState extends AdminStates{
  final String error;
  DeleteAdErrorState(this.error);
}
class  DeleteBakaSuccessState extends AdminStates{


  DeleteBakaSuccessState();
}

class DeleteBakaLoadingState extends AdminStates{

  DeleteBakaLoadingState();
}


class DeleteBakaErrorState extends AdminStates{
  final String error;
  DeleteBakaErrorState(this.error);
}



class  DeleteCountrySuccessState extends AdminStates{


  DeleteCountrySuccessState();
}

class DeleteCountryLoadingState extends AdminStates{

  DeleteCountryLoadingState();
}


class DeleteCountryErrorState extends AdminStates{
  String error;
  DeleteCountryErrorState({required this.error});
}






class  SalesRegisterSuccessState extends AdminStates{


  SalesRegisterSuccessState();
}

class SalesRegisterLoadingState extends AdminStates{

  SalesRegisterLoadingState();
}


class SalesRegisterErrorState extends AdminStates{
  String error;
  SalesRegisterErrorState({required this.error});
}







class  SalesDeleteSuccessState extends AdminStates{


  SalesDeleteSuccessState();
}

class SalesDeleteLoadingState extends AdminStates{

  SalesDeleteLoadingState();
}


class SalesDeleteErrorState extends AdminStates{
  String error;
  SalesDeleteErrorState({required this.error});
}

















class  DeleteCatSuccessState extends AdminStates{


  DeleteCatSuccessState();
}

class DeleteCatLoadingState extends AdminStates{

  DeleteCatLoadingState();
}

class  AddCatSuccessState extends AdminStates{


  AddCatSuccessState();
}

class AddCatLoadingState extends AdminStates{

  AddCatLoadingState();

}
class AddCatErrorState extends AdminStates{
  String error;

  AddCatErrorState({required this.error});

}






class  AddBakaSuccessState extends AdminStates{
  AddBakaSuccessState();
}

class AddBakaLoadingState extends AdminStates{
  AddBakaLoadingState();
}


class AddBakaErrorState extends AdminStates{
  String error;
  AddBakaErrorState({required this.error});
}








class  AddCountrySuccessState extends AdminStates{


  AddCountrySuccessState();
}

class AddCountryLoadingState extends AdminStates{

  AddCountryLoadingState();

}
class AddCountryErrorState extends AdminStates{
  String error;

  AddCountryErrorState({required this.error});

}








class  UpdateCountrySuccessState extends AdminStates{


  UpdateCountrySuccessState();
}

class UpdateCountryLoadingState extends AdminStates{

  UpdateCountryLoadingState();

}
class UpdateCountryErrorState extends AdminStates{
  String error;

  UpdateCountryErrorState({required this.error});

}









class  AddToBestSuccessState extends AdminStates{


  AddToBestSuccessState();
}

class AddBestLoadingState extends AdminStates{

  AddBestLoadingState();
}

class AddBestErrorState extends AdminStates{

  String error;
  AddBestErrorState({required this.error});
}




class  AddNewAdsSuccessState extends AdminStates{

  AddNewAdsSuccessState();
}

class AddNewAdsLoadingState extends AdminStates{

  AddNewAdsLoadingState();
}

class AddNewAdsErrorState extends AdminStates{

  String error;
  AddNewAdsErrorState({required this.error});
}



















class GetCoinsLoadingState extends AdminStates{

}

class GetCoinsErrorState extends AdminStates{

  final String error;

  GetCoinsErrorState(this.error);
}


class GetCoinsSuccessState extends AdminStates{

  GetCoinsSuccessState();
}

class UpdateAdsCoinsLoadingState extends AdminStates{

  UpdateAdsCoinsLoadingState();

}
class UpdateAdsCoinsErrorState extends AdminStates{
  String error;

  UpdateAdsCoinsErrorState({required this.error});

}


class  UpdateAdsCoinsSuccessState extends AdminStates{


  UpdateAdsCoinsSuccessState();
}
















class GetCountrySuccessState extends AdminStates{

  GetCountrySuccessState();
}

class GetCountryLoadingState extends AdminStates{

  GetCountryLoadingState();
}
class GetCountryErrorState extends AdminStates{
  String error;
  GetCountryErrorState(this.error);
}


class sendImageToServerErrorState extends AdminStates{
  String error;

  sendImageToServerErrorState({required this.error});

}
class setImageSuccessState extends AdminStates{

}
class sendImageToServerSuccessState extends AdminStates{


}
class sendImageToServerLoadingState extends AdminStates{


}

class DeleteCatErrorState extends AdminStates{
  final String error;
  DeleteCatErrorState(this.error);
}

class getCatSuccessState extends AdminStates{


  getCatSuccessState();
}
class getCatLoadingState extends AdminStates{


  getCatLoadingState();
}

class getCatErrorState extends AdminStates{
  String error;

  getCatErrorState({required this.error});
}























