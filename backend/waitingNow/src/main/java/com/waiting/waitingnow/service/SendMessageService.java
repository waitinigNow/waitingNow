package com.waiting.waitingnow.service;

import com.waiting.waitingnow.domain.MemberVO;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.ApplicationArguments;
import org.springframework.stereotype.Service;

@Service
public class SendMessageService {
    private static final Logger logger = LoggerFactory.getLogger(SendMessageService.class);

    final DefaultMessageService messageService;

    public SendMessageService(ApplicationArguments args){
        this.messageService = NurigoApp.INSTANCE.initialize(args.getOptionValues("apiKey").get(0), args.getOptionValues("apiSecret").get(0), "https://api.coolsms.co.kr");
    }
    public void sendMessage(MemberVO member, ApplicationArguments args){
        Message message = new Message();
        message.setFrom(args.getOptionValues("sendPhoneNumber").get(0));
        message.setTo(member.getMemberPhone());
        message.setText("한글 45자, 영자 90자 이하 입력되면 자동으로 SMS타입의 메시지가 추가됩니다.");
        SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));

        logger.info(response.toString());

    }
}
