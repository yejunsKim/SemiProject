package login.controller;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MySMTPAuthenticator extends Authenticator {
	// import 할 때, (javaX.mail) 로 해야한다.
	
	@Override
    public PasswordAuthentication getPasswordAuthentication() {
   
      return new PasswordAuthentication("ssdonghee99@gmail.com", "qllf oynj sonx xnte"); 
    }
	
}
