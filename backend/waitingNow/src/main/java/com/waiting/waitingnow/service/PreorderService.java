package com.waiting.waitingnow.service;

import com.waiting.waitingnow.DTO.SetPreorderVO;
import com.waiting.waitingnow.controller.WaitingController;
import com.waiting.waitingnow.domain.MenuVO;
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

    public List<MenuVO> setPreorder(SetPreorderVO preorder) throws Exception{
        List<MenuVO> originalMenus = preorder.getMenu();
        List<MenuVO> setMenus = new ArrayList<MenuVO>();
        for(int i = 0 ; i < originalMenus.size() ; i++){
            MenuVO setMenu = new MenuVO();
            // 옵션들도 등록
            Map<String, List<OptionMenuVO>> originalOptions = originalMenus.get(i).getMenuOption();
            Collection<List<OptionMenuVO>> values = originalOptions.values();
            for(List<OptionMenuVO> optionMenus : values){
                List<OptionMenuVO> options = new ArrayList<OptionMenuVO>();
                String optionCategory = "";
                Map<String, List<OptionMenuVO>> addOptions = new HashMap<>();
                for(OptionMenuVO optionMenu : optionMenus){
                    options.add(optionMenuDAO.selectByid(optionMenu.getOptionMenuKey()));
                    optionCategory = optionMenuDAO.selectByid(optionMenu.getOptionMenuKey()).getOptionMenuCategory();
                }
                addOptions.put(optionCategory, options);

                setMenu = menuDAO.selectByid(originalMenus.get(i).getMenuNumber());
                setMenu.setMenuOption(addOptions);
            }
            // 메뉴 모든 정보 불러오기
            setMenus.add(setMenu);
        }
        return setMenus;
    }
}
