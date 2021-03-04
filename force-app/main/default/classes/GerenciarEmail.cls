public class GerenciarEmail {
    public static void EnviarEMail(String endereco, String assunto, String corpo) {
        // Criar Email
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        //messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
        String[] enderecos = new String[] {endereco};
        mail.setToAddresses(enderecos);
        mail.setSubject(endereco);
        mail.setPlainTextBody(corpo);
        //mail.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
        
		// Blob csvBlob = blob.valueOf(mOutput); // <-- ERROR IN THIS LINE
		//string csvname= 'CodeCoverage.xls';
		//csvAttc.setFileName(csvname);
		// csvAttc.setBody(mOutput);
			
		       
        Messaging.SendEmailResult[] results = Messaging.sendEmail(
            new Messaging.SingleEmailMessage[] { mail });
        inspectResults(results);
    }
    
    // Método validador de envio 
    private static Boolean inspectResults(Messaging.SendEmailResult[] results) {
        Boolean sendResult = true;
      // Sucesso
        for (Messaging.SendEmailResult res : results) {
            if (res.isSuccess()) {
                System.debug('Email enviado com sucesso');
            } else {
                sendResult = false;
                System.debug('Ocorreram os seguintes ao tentar enviar o email: ' + res.getErrors());                 
            }
        }
        return sendResult;
    }
}