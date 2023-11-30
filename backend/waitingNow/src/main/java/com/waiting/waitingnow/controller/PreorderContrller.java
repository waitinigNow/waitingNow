package com.waiting.waitingnow.controller;

import com.waiting.waitingnow.DTO.MenuPreorderVO;
import com.waiting.waitingnow.DTO.RestResponse;
import com.waiting.waitingnow.DTO.SetPreorderVO;
import com.waiting.waitingnow.service.MemberService;
import com.waiting.waitingnow.service.PreorderService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class PreorderContrller {
    private static final Logger logger = LoggerFactory.getLogger(PreorderContrller.class);
    private final MemberService memberService;
    private final PreorderService preorderService;
    RestResponse<Object> restResponse = new RestResponse<>();

    // 생성자 방식으로 의존성 주입
    @Autowired
    public PreorderContrller(MemberService memberService, PreorderService preorderService){
        this.memberService = memberService;
        this.preorderService = preorderService;
    }

    /***
     * 선주문 등록하는 API
     * @apiNote 선주문 등록 완료 / 일치하는 웨이팅 번호가 없을 때
     * @param preorder
     */
    @RequestMapping(value = {"/preorder"}, method = RequestMethod.POST)
    public ResponseEntity preorder(@RequestBody SetPreorderVO preorder) throws Exception {
        logger.info("선주문 등록 호출");
        try{
            List<MenuPreorderVO> menus =  preorderService.setPreorder(preorder);
            restResponse = RestResponse.builder()
                    .code(HttpStatus.CREATED.value())
                    .httpStatus(HttpStatus.CREATED)
                    .message("")
                    .data(menus)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        // 2. 일치하는 웨이팅 번호가 없을 때
        catch (NullPointerException e){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.NOT_FOUND.value())
                    .httpStatus(HttpStatus.NOT_FOUND)
                    .message("일치하는 웨이팅 번호가 없습니다")
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }
    
    /***
     * 선주문 조회하는 API
     * @param waitingNumber
     */
    @RequestMapping(value = {"/preorder"}, method = RequestMethod.GET)
    public ResponseEntity preorderSearch(@RequestParam int waitingNumber) throws Exception {
        logger.info(waitingNumber + "번의 선주문 내역 조회");
        try{
            List<MenuPreorderVO> menuPreorders = preorderService.searchPreorder(waitingNumber);
            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message("선주문한 메뉴 개수 : " + menuPreorders.size() + "개")
                    .data(menuPreorders)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        // 2. 일치하는 웨이팅 번호가 없을 때
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
     * 선주문 변경하는 API
     * @param preorder
     * @return
     * @throws Exception
     */
    @RequestMapping(value = {"/preorder/edit"}, method = RequestMethod.PATCH)
    public ResponseEntity preorderEdit(@RequestBody SetPreorderVO preorder) throws Exception {
        // 기존에 있던 선주문 모두 delete하고
        // 그냥 다시 등록하면 됨
        logger.info("선주문 수정 호출");
        try{
            preorderService.deletePreorder(preorder);
            List<MenuPreorderVO> menus = preorderService.setPreorder(preorder);
            restResponse = RestResponse.builder()
                    .code(HttpStatus.CREATED.value())
                    .httpStatus(HttpStatus.CREATED)
                    .message("[변경 완료] 현재 메뉴 개수 : " + menus.size())
                    .data(menus)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        // 2. 일치하는 웨이팅 번호가 없을 때
        catch (NullPointerException e){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.NOT_FOUND.value())
                    .httpStatus(HttpStatus.NOT_FOUND)
                    .message("일치하는 웨이팅 번호가 없습니다")
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }
}
