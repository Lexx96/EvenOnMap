

class LicenseAgreementProvider {

  bool? agreeTerms (bool? isAccepted) {
    if(isAccepted == false) {
      return false;
    }
    else{
      return true;
    }
  }
}