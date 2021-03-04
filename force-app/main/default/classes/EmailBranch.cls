global class EmailBranch implements Messaging.InboundEmailHandler {
 
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, 
                                                       Messaging.InboundEnvelope env){
 
    // Create an InboundEmailResult object for returning the result of the 
    // Apex Email Service
    Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
  
    String myPlainText= '';
    
    // Add the email plain text into the local variable 
    myPlainText = email.plainTextBody;
 
    // New Task object to be created
    EmailMessage[] newEmailMessage = new EmailMessage[0];
   
    // Try to look up any contacts based on the email from address
    // If there is more than one contact with the same email address,
    // an exception will be thrown and the catch statement will be called.
    try {
      Contact vCon = [SELECT AccountId
        FROM Contact
        WHERE Email = :email.fromAddress
        LIMIT 1];
      
      // Add a new Task to the contact record we just found above.
      newEmailMessage.add(new EmailMessage( 
           HTMLBody =  myPlainText,
           FromAddress = email.fromAddress,
           Status = '3',
           RelatedToId = vCon.AccountId,
           Subject = email.subject,
           MessageDate =  System.now() ));
     
     // Insert the new Task 
     insert newEmailMessage;    
     
    System.debug('New Email Message: ' + newEmailMessage );   
    }
    // If an exception occurs when the query accesses 
    // the contact record, a QueryException is called.
    // The exception is written to the Apex debug log.
   catch (QueryException e) {
       System.debug('Query Issue: ' + e);
   }
   
   // Set the result to true. No need to send an email back to the user 
   // with an error message
   result.success = true;
   
   // Return the result for the Apex Email Service
   return result;
  }
}