package com.waiting.waitingnow.service;

import com.waiting.waitingnow.DTO.MenuPreorderVO;
import com.waiting.waitingnow.DTO.SetPreorderVO;
import com.waiting.waitingnow.domain.OptionMenuVO;
import com.waiting.waitingnow.persistance.MenuDAO;
import com.waiting.waitingnow.persistance.OptionMenuDAO;
import com.waiting.waitingnow.persistance.PreorderDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class PreorderService {
    private PreorderDAO preorderDAO;

    private OptionMenuDAO optionMenuDAO;

    private MenuDAO menuDAO;

    private static final Logger logger = LoggerFactory.getLogger(PreorderService.class);

    @Autowired
    public PreorderService(PreorderDAO preorderDAO, MenuDAO menuDAO, OptionMenuDAO optionMenuDAO){
        this.preorderDAO = preorderDAO;
        this.menuDAO = menuDAO;
        this.optionMenuDAO = optionMenuDAO;
    }

    public List<MenuPreorderVO> setPreorder(SetPreorderVO preorder) throws Exception{
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
}
