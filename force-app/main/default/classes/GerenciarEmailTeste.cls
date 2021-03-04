@isTest
private class GerenciarEmailTeste {
    
    @isTest static void LerEmailRecebidoSemAnexoTeste() {
        EmailMessage email = new EmailMessage(FromAddress = 'test@abc.org', Incoming = True, ToAddress= 'hello@670ocglw7xhomi4oyr5yw2zvf.8kp7yeag.8.case.salesforce.com', Subject = 'Test email', TextBody = '23456 ');
			
     		 Database.SaveResult result = Database.insert(email, false);
        System.assert(!result.isSuccess());
                System.assert(result.getErrors().size() > 0);
        System.assertEquals('Email sem anexo',
                             result.getErrors()[0].getMessage());
    }
    
    @isTest static void LerEmailRecebidoComAnexoTeste() {
        EmailMessage email = new EmailMessage(FromAddress = 'test@abc.org', Incoming = True, ToAddress= 'hello@670ocglw7xhomi4oyr5yw2zvf.8kp7yeag.8.case.salesforce.com', Subject = 'Test email', TextBody = '23456 ');
     	Database.SaveResult result = Database.insert(email, false);
       
 		//Attachment attach=new Attachment(); 
   		//attach.Name='Unit Test Attachment'; 
    	//Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body'); 
    	//attach.body=bodyBlob; 
		//attach.parentId = email.id;
		//attach.ContentType='application/x-excel';
		//insert attach;

    	//attach.body=bodyBlob; 
	
		//insert attach ;
        
        
        System.assert(!result.isSuccess());
                System.assert(result.getErrors().size() > 0);
        System.assertEquals('Email sem anexo',
                             result.getErrors()[0].getMessage());
    }  
}