package com.waiting.waitingnow.controller;

import com.waiting.waitingnow.DTO.RestResponse;
import com.waiting.waitingnow.domain.WaitingVO;
import com.waiting.waitingnow.service.SendMessageService;
import com.waiting.waitingnow.service.WaitingService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class WaitingController {

    private static final Logger logger = LoggerFactory.getLogger(WaitingController.class);

    private final WaitingService waitingService;
    private final SendMessageService sendMessageService;

    RestResponse<Object> restResponse = new RestResponse<>();

    @Autowired
    public WaitingController(WaitingService waitingService,SendMessageService sendMessageService) {
        this.waitingService = waitingService;
        this.sendMessageService = sendMessageService;
    }

    /**
     * 웨이팅 등록하는 API
     * @apiNote 1. waiting 등록 성공 시 / 2. 일치하는 사장님 회원 번호가 없을 때
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = {"/waiting"}, method = RequestMethod.POST)
    public ResponseEntity waitingRegist(@RequestBody WaitingVO waiting) throws Exception {
        // 1. waiting 등록 성공 시
        try{
            waitingService.insert(waiting);
            WaitingVO NewWaiting = waitingService.selectByid(waiting.getWaitingNumber());
            restResponse = RestResponse.builder()
                    .code(HttpStatus.CREATED.value())
                    .httpStatus(HttpStatus.CREATED)
                    .message("웨이팅 정상 등록됨")
                    .data(NewWaiting)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        // 2. 일치하는 사장님 회원 번호가 없을 때
        catch (NullPointerException e){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.NOT_FOUND.value())
                    .httpStatus(HttpStatus.NOT_FOUND)
                    .message("일치하는 사장님의 회원번호가 없습니다")
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }


    /**
     * 웨이팅 번호로 웨이팅 조회하는 API
     * @param waitingNumber
     * @apiNote 1. waiting 조회 성공 시 / 2. 일치하는 웨이팅 번호가 없을 때
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = {"/waiting"}, method = RequestMethod.GET)
    public ResponseEntity waitingCheck(@RequestParam Integer waitingNumber) throws Exception {
        // 1. waiting 조회 성공 시
        try{
            WaitingVO waiting = waitingService.selectByid(waitingNumber);
            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message(waitingNumber + "번 웨이팅 조회")
                    .data(waiting)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        // 2. 일치하는 웨이팅 번호가 없을 때
        catch (NullPointerException e){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.NOT_FOUND.value())
                    .httpStatus(HttpStatus.NOT_FOUND)
                    .message(e.toString())
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }

    /**
     * 웨이팅 호출하는 api 메소드
     * @apiNote 1. waiting 호출 성공 시 / 2. 파라미터 둘 중에 하나라도 잘못됨
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = {"/waiting/call"}, method = RequestMethod.GET)
    public ResponseEntity waitingCall(@RequestParam (value = "waitingCustomerNumber") int waitingCustomerNumber, @RequestParam(value = "memberNumber") int memberNumber) throws Exception {
        // 1. waiting 호출 성공 시
        WaitingVO waiting = new WaitingVO();
        waiting.setWaitingCustomerNumber(waitingCustomerNumber);
        waiting.setMemberNumber(memberNumber);
        try{
            WaitingVO newWaiting = waitingService.waitingSearchByCustomerNumber(waiting);
            String sentMessage = sendMessageService.sendWaitingCallMessage(newWaiting);
            // TODO 추후 선주문 내용도 담겨야함.
            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message(sentMessage)
                    .data(newWaiting)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        // 2. 파라미터 둘 중에 하나라도 잘못됨
        catch (Exception e){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.NOT_FOUND.value())
                    .httpStatus(HttpStatus.NOT_FOUND)
                    .message(e.toString())
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }

    /**
     * 웨이팅 상태를 변경하는 api
     * @apiNote 1. 성공적으로 상태를 변경함 / 2. 파라미터 둘 중에 하나라도 잘못됨
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = {"/waiting/status"}, method = RequestMethod.PATCH)
    public ResponseEntity waitingChangeStatus(@RequestBody WaitingVO waiting) throws Exception {
        // 1. 성공적으로 상태를 변경함
        try{
            WaitingVO newWaiting = waitingService.waitingChangeStatus(waiting);
            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message("상태가 [" + newWaiting.getWaitingAvailable() + "]으로 변경되었습니다")
                    .data(newWaiting)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        // 2. 파라미터 둘 중에 하나라도 잘못됨
        catch (Exception e){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.NOT_FOUND.value())
                    .httpStatus(HttpStatus.NOT_FOUND)
                    .message(e.toString())
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }

    /**
     * 현재 대기 인원을 찾는 api
     * @apiNote
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = {"/waiting/now/people"}, method = RequestMethod.GET)
    public ResponseEntity waitingNowPeople(@RequestParam int memberNumber) throws Exception {
        // 1. 현재 인원을 출력함
        try{
            int people = waitingService.waitingNowPeople(memberNumber);
            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message("현재 대기 인원 : "+Integer.toString(people)+"(대기/입장가능 상태)")
                    .data(people)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        // 2. memberNumber가 잘못된 경우
        catch (Exception e){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.NOT_FOUND.value())
                    .httpStatus(HttpStatus.NOT_FOUND)
                    .message("사장님의 회원번호가 잘못되었습니다.")
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }

    /**
     * 회원 번호로 상태에 따른 사람 리스트 출력하기 (대기중 / 완료)
     * @param waitingStatus
     * @apiNote 1. waiting List 조회 성공 시 / 2. 일치하는 웨이팅 번호가 없을 때
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = {"/waiting/now"}, method = RequestMethod.GET)
    public ResponseEntity waitingSearchList(String memberNumber) throws Exception {
        logger.info("/waiting/now 호출");
        try{
            List<WaitingVO> waitings = waitingService.waitingNowList(memberNumber);
            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message(memberNumber + "번 사장님의 웨이팅 손님 리스트 조회")
                    .data(waitings)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        // 2. 일치하는 사장님 번호가 없을 때
        catch (NullPointerException e){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.NOT_FOUND.value())
                    .httpStatus(HttpStatus.NOT_FOUND)
                    .message(e.toString())
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }
}