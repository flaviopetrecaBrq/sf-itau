trigger LerEmailRecebido on EmailMessage (after insert) {
	for(EmailMessage message : trigger.new){
		if(message.HasAttachment){
		   System.debug('Email enviado com sucesso');                 
            
			}
        else
        {
           message.addError('Email sem anexo');
        }
	}
}