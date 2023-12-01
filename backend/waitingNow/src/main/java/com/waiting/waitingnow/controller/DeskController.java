package com.waiting.waitingnow.controller;

import com.waiting.waitingnow.DTO.RestResponse;
import com.waiting.waitingnow.DTO.SendDeskVO;
import com.waiting.waitingnow.domain.DeskVO;
import com.waiting.waitingnow.domain.MemberVO;
import com.waiting.waitingnow.service.DeskService;
import jakarta.servlet.http.HttpServletRequest;
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

    @Autowired
    public DeskController(DeskService deskService){
        this.deskService = deskService;
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
}
