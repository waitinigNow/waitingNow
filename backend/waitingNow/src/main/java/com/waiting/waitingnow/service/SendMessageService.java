package com.waiting.waitingnow.service;

import com.waiting.waitingnow.domain.MemberVO;
import com.waiting.waitingnow.domain.WaitingVO;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
    public void sendAuthMessage(String memberPhone, String randomNumber){
        Message message = new Message();
        message.setFrom(applicationArguments.getOptionValues("sendPhoneNumber").get(0));
        message.setTo(memberPhone);
        message.setText("[웨이팅 나우] 인증번호는 "+randomNumber+ " 입니다.");
        SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));

        logger.info(response.toString());
    }
    public String sendWaitingCallMessage(WaitingVO waiting){
        Message message = new Message();
        message.setFrom(applicationArguments.getOptionValues("sendPhoneNumber").get(0));
        message.setTo(waiting.getWaitingPhone());
        // TODO 가게명을 표기해야할듯..

        message.setText("[웨이팅 나우]\n고객님 현재 매장에 입장 가능합니다! 5분 내에 입장 부탁드립니다!");
        SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));

        logger.info(response.toString());
        return "[웨이팅 나우]\n고객님 현재 매장에 입장 가능합니다! 5분 내에 입장 부탁드립니다!";
    }
}
