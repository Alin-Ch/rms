package com.www.utils;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

/**
 * @Author Alin
 * @date 2024/5/4 004 20:09
 * @Description:
 */
public class MailSenderUtil {

    private static final JavaMailSender javaMailSender = null;

    @Value(value = "${spring.mail.username}")
    private static String sender;



    // 发送邮件的方法，传入邮箱号
    public static void sendMessageForOrder(String email, String title, String content) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(sender);
        message.setTo(email);
        message.setSubject(title);
        message.setText(content);
        javaMailSender.send(message);
    }


    /*
    // 发送邮件的方法，传入邮箱号
    public static void sendMessageForOrder(String email, String title, String content, String senderEmail, String host, int port, String username, String password) {
        JavaMailSender javaMailSender = getJavaMailSender(host, port, username, password);

        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(senderEmail);
        message.setTo(email);
        message.setSubject(title);
        message.setText(content);
        javaMailSender.send(message);
    }

    private static JavaMailSender getJavaMailSender(String host, int port, String username, String password) {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost(host);
        mailSender.setPort(port);
        mailSender.setUsername(username);
        mailSender.setPassword(password);
        return mailSender;
    } */

}
