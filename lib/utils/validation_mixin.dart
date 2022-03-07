class ValidationMixin{
  String? validateEmail(String value){
    if(value.trim().isEmpty){
      return "Please enter your email";
    }
    return null;
  }

  String? validatePassword(String value,{bool isConfirmed=false, String confrimValue=""}){
    if(value.trim().isEmpty){
      return "Please enter your password";
    }
    if(isConfirmed){
      if(value != confrimValue){
        return "Your password didn't match.";
      }
    }
    return null;
  }
}