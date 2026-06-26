trigger Validate_Field_Before_save on Account (before insert,before update) {
    for(Account acc : trigger.new){
        if(acc.AnnualRevenue != null &&acc.AnnualRevenue < 10000){
         //   acc.addError('Annual Revenue must be greater than 10000');
        }
    }
}