global class myEmailHandler implements Messaging.InboundEmailHandler {
 
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, 
                                                       Messaging.InboundEnvelope env){
 
    // Crie um objeto InboundEmailResult para retornar o resultado do
    // Apex Email Service
    
    Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
  
    String myPlainText= '';
    
    // Adicione o texto simples do e-mail na variável local
    myPlainText = email.plainTextBody;
 
     // Novo objeto Task a ser criado
    EmailMessage[] newEmailMessage = new EmailMessage[0];
   
    // Tente procurar quaisquer contatos com base no endereço de e-mail de
    // Se houver mais de um contato com o mesmo endereço de e-mail,
    // uma exceção será lançada e a instrução catch será chamada.
    try {
    
    Contract vCon = [SELECT Id
        FROM Contract
        WHERE ContractNumber = :email.subject.mid(13,8)
        LIMIT 1];
      
      // Adicione uma nova Tarefa ao registro de contato que acabamos de encontrar acima.
      newEmailMessage.add(new EmailMessage( 
           HTMLBody =  myPlainText,
           FromAddress = email.fromAddress,
           Status = '3',
           RelatedToId =vCon.id,
           Subject = email.subject,
           MessageDate =  System.now() ));
     
    // Insira a nova tarefa 
     insert newEmailMessage;    
     
    System.debug('New Email Message: ' + newEmailMessage );   
    }
    // Se ocorrer uma exceção quando a consulta acessar 
    // o registro do contato, uma QueryException é chamada.
    // A exceção é gravada no log de depuração do Apex.
   catch (QueryException e) {
       System.debug('Query Issue: ' + e);
   }
   
    // Defina o resultado como verdadeiro. Não há necessidade de enviar um e-mail de volta para o usuário
   // com uma mensagem de erro
   result.success = true;
   
   // Retorna o resultado para o Apex Email Service
   return result;
  }
}