package com.waiting.waitingnow.controller;

import com.waiting.waitingnow.DTO.RestResponse;
import com.waiting.waitingnow.DTO.SendDeskVO;
import com.waiting.waitingnow.DTO.noWaitingSentDeskAssignVO;
import com.waiting.waitingnow.config.JwtTokenService;
import com.waiting.waitingnow.domain.SentDeskAssignVO;
import com.waiting.waitingnow.service.DeskService;
import com.waiting.waitingnow.service.WaitingService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class DeskController {

    private static final Logger logger = LoggerFactory.getLogger(DeskController.class);
    private final DeskService deskService;
    private final WaitingService waitingService;
    RestResponse<Object> restResponse = new RestResponse<>();
    private final JwtTokenService jwtTokenService;

    @Autowired
    public DeskController(DeskService deskService, JwtTokenService jwtTokenService, WaitingService waitingService) {
        this.deskService = deskService;
        this.jwtTokenService = jwtTokenService;
        this.waitingService = waitingService;
    }

    /**
     * Desk 조회하는 API
     *
     * @param token
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = {"/desk"}, method = RequestMethod.GET)
    public ResponseEntity deskSearch(@RequestHeader("Authorization") String token) throws Exception {
        int memberNumber = Integer.valueOf(jwtTokenService.getUsernameFromToken(token));
        logger.info("[desk 조회] memberNumber : " + memberNumber);
        try {
            List<SendDeskVO> desks = deskService.selectByMember(memberNumber);
            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message(memberNumber + "의 desk 조회")
                    .data(desks)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        // 일치하는 전화번호가 없을 때, NullpointerException 발생
        catch (NullPointerException e) {
            restResponse = RestResponse.builder()
                    .code(HttpStatus.NOT_FOUND.value())
                    .httpStatus(HttpStatus.NOT_FOUND)
                    .message(e.getMessage())
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }

    /***
     * 식탁 배정하는 메소드 / 웨이팅 상태도 입장 완료(0) 으로 변경하는 메소드
     * @param deskAssignVO
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = {"/desk/sit/waiting"}, method = RequestMethod.POST)
    public ResponseEntity deskAssgin(@RequestBody SentDeskAssignVO deskAssignVO, @RequestHeader("Authorization") String token) throws Exception {
        try {
            deskAssignVO.setMemberNumber(Integer.valueOf(jwtTokenService.getUsernameFromToken(token)));
            logger.info("[desk 배정] memberNumber : " + deskAssignVO.getMemberNumber() + "/ deskStoreNumber : " + deskAssignVO.getDeskStoreNumber());
            SentDeskAssignVO desk = deskService.assignDesk(deskAssignVO);
            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message(desk.getWaitingNumber() + "의 desk 할당")
                    .data(desk)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        // 일치하는 전화번호가 없을 때, NullpointerException 발생
        catch (NullPointerException e) {
            restResponse = RestResponse.builder()
                    .code(HttpStatus.NOT_FOUND.value())
                    .httpStatus(HttpStatus.NOT_FOUND)
                    .message(e.getMessage())
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        } catch (IllegalStateException e) {
            restResponse = RestResponse.builder()
                    .code(HttpStatus.BAD_REQUEST.value())
                    .httpStatus(HttpStatus.BAD_REQUEST)
                    .message(e.getMessage())
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }

    /***
     * 웨이팅 없이 식탁 배정하는 메소드 / 웨이팅 상태도 입장 완료(0)로 지정
     * @param noWaitingSentDeskAssign
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = {"/desk/sit/nowaiting"}, method = RequestMethod.POST)
    public ResponseEntity deskNowaitingAssgin(@RequestBody noWaitingSentDeskAssignVO noWaitingSentDeskAssign, @RequestHeader("Authorization") String token) throws Exception {
        try {
            SentDeskAssignVO deskAssignVO = new SentDeskAssignVO();
            deskAssignVO.setDeskStoreNumber(noWaitingSentDeskAssign.getDeskStoreNumber());
            deskAssignVO.setMemberNumber(Integer.valueOf(jwtTokenService.getUsernameFromToken(token)));// 요청은 (memberNumber, deskStoreNumber, entryPeople)
            logger.info("[desk 배정] memberNumber : " + deskAssignVO.getMemberNumber() + "/ deskStoreNumber : " + deskAssignVO.getDeskStoreNumber());

            //웨이팅으로 등록하기 (전화번호와 대기번호는 null)
            deskAssignVO.setWaitingNumber(waitingService.noWaiting(deskAssignVO.getMemberNumber(),noWaitingSentDeskAssign.getEntryPeople()));
            SentDeskAssignVO desk = deskService.noWaitingAssignDesk(deskAssignVO);

            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message(desk.getWaitingNumber() + "의 desk 할당")
                    .data(desk)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        // 일치하는 전화번호가 없을 때, NullpointerException 발생
        catch (NullPointerException e) {
            restResponse = RestResponse.builder()
                    .code(HttpStatus.NOT_FOUND.value())
                    .httpStatus(HttpStatus.NOT_FOUND)
                    .message(e.getMessage())
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        } catch (IllegalStateException e) {
            restResponse = RestResponse.builder()
                    .code(HttpStatus.BAD_REQUEST.value())
                    .httpStatus(HttpStatus.BAD_REQUEST)
                    .message(e.getMessage())
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }

    @ResponseBody
    @RequestMapping(value = {"/desk/out"}, method = RequestMethod.DELETE)
    public ResponseEntity deskOut(@RequestBody SentDeskAssignVO deskAssignVO, @RequestHeader("Authorization") String token) throws Exception {
        deskAssignVO.setMemberNumber(Integer.valueOf(jwtTokenService.getUsernameFromToken(token)));
        logger.info("[desk 배정 반환] memberNumber : " + deskAssignVO.getMemberNumber() + "/ deskStoreNumber : " + deskAssignVO.getDeskStoreNumber());
        try {
            // 요청은 (memberNumber, deskStoreNumber, waitingNumber)
            deskService.assignOutDesk(deskAssignVO);
            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message(deskAssignVO.getMemberNumber() + " 사장님의 " + deskAssignVO.getDeskStoreNumber() + "번 테이블 배정 해제되었습니다!")
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        // 일치하는 전화번호가 없을 때, NullpointerException 발생
        catch (IllegalStateException e) {
            restResponse = RestResponse.builder()
                    .code(HttpStatus.NOT_FOUND.value())
                    .httpStatus(HttpStatus.NOT_FOUND)
                    .message(e.getMessage())
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }


}
