package com.waiting.waitingnow.controller;

import com.waiting.waitingnow.DTO.RestResponse;
import com.waiting.waitingnow.DTO.SendDeskVO;
import com.waiting.waitingnow.config.JwtTokenService;
import com.waiting.waitingnow.domain.SentDeskAssignVO;
import com.waiting.waitingnow.service.DeskService;
import jakarta.servlet.ServletContext;
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
    RestResponse<Object> restResponse = new RestResponse<>();
    private final JwtTokenService jwtTokenService;

    @Autowired
    private ServletContext servletContext;

    @Autowired
    public DeskController(DeskService deskService, JwtTokenService jwtTokenService){
        this.deskService = deskService;
        this.jwtTokenService = jwtTokenService;
    }

    /**
     * Desk 조회하는 API
     * @param memberNumber
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = { "/desk" }, method = RequestMethod.GET)
    public ResponseEntity deskSearch(@RequestParam int memberNumber) throws Exception {
        logger.info("[desk 조회] memberNumber : " + memberNumber);
        try{
            List<SendDeskVO> desks = deskService.selectByMember(memberNumber);
            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message(memberNumber+"의 desk 조회")
                    .data(desks)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        // 일치하는 전화번호가 없을 때, NullpointerException 발생
        catch (NullPointerException e){
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
    @RequestMapping(value = { "/desk/sit" }, method = RequestMethod.POST)
    public ResponseEntity deskAssgin(@RequestBody SentDeskAssignVO deskAssignVO) throws Exception {
        logger.info("[desk 배정] memberNumber : " + deskAssignVO.getMemberNumber() + "/ deskStoreNumber : "+deskAssignVO.getDeskStoreNumber());
        try{
            deskAssignVO.setMemberNumber(Integer.valueOf(jwtTokenService.getUsernameFromToken(deskAssignVO.getToken())));// 요청은 (memberNumber, deskStoreNumber, waitingNumber)
            SentDeskAssignVO desk = deskService.assignDesk(deskAssignVO);
            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message(desk.getWaitingNumber()+"의 desk 할당")
                    .data(desk)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        // 일치하는 전화번호가 없을 때, NullpointerException 발생
        catch (NullPointerException e){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.NOT_FOUND.value())
                    .httpStatus(HttpStatus.NOT_FOUND)
                    .message(e.getMessage())
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        catch (IllegalStateException e){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.BAD_REQUEST.value())
                    .httpStatus(HttpStatus.BAD_REQUEST)
                    .message(e.getMessage())
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }

    @ResponseBody
    @RequestMapping(value = { "/desk/out" }, method = RequestMethod.DELETE)
    public ResponseEntity deskOut(@RequestBody SentDeskAssignVO deskAssignVO) throws Exception {
        logger.info("[desk 배정 반환] memberNumber : " + deskAssignVO.getMemberNumber() + "/ deskStoreNumber : "+deskAssignVO.getDeskStoreNumber());
        try{
            // 요청은 (memberNumber, deskStoreNumber, waitingNumber)
            deskService.assignOutDesk(deskAssignVO);
            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message(deskAssignVO.getMemberNumber() + " 사장님의 " + deskAssignVO.getDeskStoreNumber() +"번 테이블 배정 해제되었습니다!")
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        // 일치하는 전화번호가 없을 때, NullpointerException 발생
        catch (IllegalStateException e){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.NOT_FOUND.value())
                    .httpStatus(HttpStatus.NOT_FOUND)
                    .message(e.getMessage())
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }

    }
}
