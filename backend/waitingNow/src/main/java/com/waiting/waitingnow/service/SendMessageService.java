package com.waiting.waitingnow.service;

import com.waiting.waitingnow.domain.MemberVO;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.ApplicationArguments;
import org.springframework.stereotype.Service;

@Service
public class SendMessageService {
    private static final Logger logger = LoggerFactory.getLogger(SendMessageService.class);

    final DefaultMessageService messageService;
    private final ApplicationArguments applicationArguments;
    @Autowired
    public SendMessageService(ApplicationArguments applicationArguments){
        this.applicationArguments = applicationArguments;
        this.messageService = NurigoApp.INSTANCE.initialize(applicationArguments.getOptionValues("apiKey").get(0), applicationArguments.getOptionValues("apiSecret").get(0), "https://api.coolsms.co.kr");
    }
    public void sendMessage(MemberVO member, String randomNumber){
        Message message = new Message();
        message.setFrom(applicationArguments.getOptionValues("sendPhoneNumber").get(0));
        message.setTo(member.getMemberPhone());
        message.setText("[웨이팅 나우] 인증번호는 "+randomNumber+ " 입니다.");
        SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));

        logger.info(response.toString());

    }
}
