package com.waiting.waitingnow.controller;

import com.waiting.waitingnow.DTO.RestResponse;
import com.waiting.waitingnow.domain.MemberVO;
import com.waiting.waitingnow.domain.WaitingVO;
import com.waiting.waitingnow.persistance.WaitingDAO;
import com.waiting.waitingnow.service.WaitingService;
import org.apache.ibatis.jdbc.Null;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
public class WaitingController {

    private static final Logger logger = LoggerFactory.getLogger(WaitingController.class);

    private final WaitingService waitingService;

    RestResponse<Object> restResponse = new RestResponse<>();

    @Autowired
    public WaitingController(WaitingService waitingService) {
        this.waitingService = waitingService;
    }

    /**
     * 웨이팅 등록하는 API
     * @apiNote 1. waiting 등록 성공 시 / 2. 일치하는 시징님 회원 번호가 없을 때
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
        // 2. 일치하는 시징님 회원 번호가 없을 때
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
}