package kr.spring.member.email;

import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class EmailSender {
	@Autowired
	protected JavaMailSender mailSender;

	public void sendEmail(Email email) throws Exception {
		MimeMessage msg = mailSender.createMimeMessage();
		try {
			msg.setFrom();
			msg.setSubject(email.getSubject());
			msg.setText(email.getContent());
			msg.setRecipients(RecipientType.TO, InternetAddress.parse(email.getReceiver()));

		}catch(MessagingException e) {
			log.error(e.toString());
		}
		mailSender.send(msg);
	}
}
