package com.waiting.waitingnow.service;

import com.waiting.waitingnow.DTO.MenuPreorderVO;
import com.waiting.waitingnow.DTO.SetPreorderVO;
import com.waiting.waitingnow.domain.MenuVO;
import com.waiting.waitingnow.domain.OptionMenuVO;
import com.waiting.waitingnow.domain.OptionPreorderVO;
import com.waiting.waitingnow.domain.PreorderVO;
import com.waiting.waitingnow.persistance.MenuDAO;
import com.waiting.waitingnow.persistance.OptionMenuDAO;
import com.waiting.waitingnow.persistance.PreorderDAO;
import com.waiting.waitingnow.persistance.WaitingDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class PreorderService {
    private final PreorderDAO preorderDAO;

    private final OptionMenuDAO optionMenuDAO;

    private final MenuDAO menuDAO;
    private final MenuService menuService;
    private final WaitingDAO waitingDAO;


    private static final Logger logger = LoggerFactory.getLogger(PreorderService.class);

    @Autowired
    public PreorderService(PreorderDAO preorderDAO, MenuDAO menuDAO, OptionMenuDAO optionMenuDAO, MenuService menuService, WaitingDAO waitingDAO){
        this.preorderDAO = preorderDAO;
        this.menuDAO = menuDAO;
        this.optionMenuDAO = optionMenuDAO;
        this.menuService = menuService;
        this.waitingDAO = waitingDAO;
    }

    public List<MenuPreorderVO> setPreorder(SetPreorderVO preorder) throws Exception{
        // 먼저 예외 처리 진행
        if(waitingDAO.selectByid(preorder.getWaitingNumber()) == null){
            throw new NullPointerException("존재하지 않는 웨이팅 번호입니다.");
        }

        // request 받은 선주문 내역과 모든 내용을 다 저장할 선주문 내역들
        List<MenuPreorderVO> originalMenus = preorder.getMenu();
        List<MenuPreorderVO> setMenus = new ArrayList<MenuPreorderVO>();
        
        for(int i = 0 ; i < originalMenus.size() ; i++){
            MenuPreorderVO setMenu = new MenuPreorderVO();
            // 옵션들도 등록
            Map<String, List<OptionMenuVO>> originalOptions = originalMenus.get(i).getMenuOption();
            Collection<List<OptionMenuVO>> values = originalOptions.values();
            
            // 한 메뉴에 옵션 여러가지
            for(List<OptionMenuVO> optionMenus : values){
                List<OptionMenuVO> options = new ArrayList<OptionMenuVO>();
                String optionCategory = "";
                Map<String, List<OptionMenuVO>> addOptions = new HashMap<>();
                for(OptionMenuVO optionMenu : optionMenus){
                    options.add(optionMenuDAO.selectByid(optionMenu.getOptionMenuKey()));
                    optionCategory = optionMenuDAO.selectByid(optionMenu.getOptionMenuKey()).getOptionMenuCategory();
                }
                addOptions.put(optionCategory, options);

                // 기존에 있던 애들 덮어쓰기함. 새로 할당 해주어야 함
                setMenu = menuDAO.selectPreorderVOByid(originalMenus.get(i).getMenuNumber());
                setMenu.setMenuOption(addOptions);
                setMenu.setMenuCount(originalMenus.get(i).getMenuCount());
            }
            // 메뉴 모든 정보 불러오기
            setMenus.add(setMenu);
        }
        preorder.setMenu(setMenus);
        preorderDAO.insert(preorder);
        return setMenus;
    }

    /***
     * 선주문 조회하는 함수
     * @param waitingNumber
     * @return
     * @throws Exception
     */
    public List<MenuPreorderVO> searchPreorder(int waitingNumber) throws Exception{
        // 선주문 테이블 불러옴
        List<PreorderVO> preorders = preorderDAO.selectByWaiting(waitingNumber);
        if(preorders.isEmpty()){
            throw new NullPointerException("일치하지 않는 웨이팅 번호입니다.");
        }
        List<MenuPreorderVO> newPreorders = new ArrayList<MenuPreorderVO>();
        List<MenuVO> menus = new ArrayList<MenuVO>(); // 전송할 메뉴들 저장할 공간

        for(PreorderVO preorder : preorders){
            // 하나의 선주문 메뉴에 대한 옵션들을 불러옴
            List<OptionPreorderVO> optionPreorders = preorderDAO.selectOptionsByPreorderNumber(preorder.getPreorderNumber());
            List<OptionMenuVO> optionmenus = new ArrayList<OptionMenuVO>();
            
            // 메뉴에 대한 옵션들 불러옴
            for(OptionPreorderVO optionPreoder : optionPreorders){
                optionmenus.add(optionMenuDAO.selectByid(optionPreoder.getOptionMenuKey()));
            }

            // 메뉴 번호로 선주문 메뉴들 정보 가져옴
            // 옵션 Map 방식으로 변경하여 추가함
            MenuPreorderVO newPreorder = menuDAO.selectPreorderVOByid(preorder.getMenuNumber());
            newPreorder.setMenuOption(menuService.setMenuOptionToMap(optionmenus));
            newPreorder.setMenuCount(preorder.getPreorderMenuCount());

            // 세팅 마친 MenuPreorderVO 넣음
            newPreorders.add(newPreorder);
        }
        return newPreorders;
    }

    /**
     * 선주문 삭제하는 메소드
     * @param preorder
     * @throws Exception
     */
    public void deletePreorder(SetPreorderVO preorder) throws Exception{
        List<PreorderVO> preorders = preorderDAO.selectByWaiting(preorder.getWaitingNumber());
        for(PreorderVO preorderVO : preorders){
            // preorderNumber로 옵션, 선주문 삭제함
            preorderDAO.deleteOptions(preorderVO.getPreorderNumber());
            preorderDAO.delete(preorderVO.getPreorderNumber());
        }
    }
}
