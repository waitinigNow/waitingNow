package com.waiting.waitingnow.service;

import com.waiting.waitingnow.domain.MenuVO;
import com.waiting.waitingnow.domain.OptionMenuVO;
import com.waiting.waitingnow.persistance.MenuDAO;
import com.waiting.waitingnow.persistance.OptionMenuDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MenuService {
    private final MenuDAO menuDAO;
    private final OptionMenuDAO optionMenuDAO;
    @Autowired
    public MenuService(MenuDAO menuDAO, OptionMenuDAO optionMenuDAO){
        this.menuDAO = menuDAO;
        this.optionMenuDAO = optionMenuDAO;
    }

    public Map<String, List<MenuVO>> selectByMember(int memberNumber) throws Exception{
        List<MenuVO> menus = menuDAO.selectByMember(memberNumber);
        if(menus.size() == 0){
            throw new NullPointerException("메뉴가 등록되지 않았거나, 사장님 번호가 일치하지 않습니다.");
        }

        // 메뉴마다 옵션 Map으로 할당함
        for(int i = 0 ; i < menus.size() ; i++){
            MenuVO menu = menus.get(i);
            menu.setMenuOption(setMenuOptionToMap(optionMenuDAO.selectByMenu(menu.getMenuNumber())));
            menus.set(i,menu);
        }
        return setMenuToMap(menus);
    }

    /***
     * 같은 옵션 카테고리끼리 묶는 API
     * @param optionMenu(List<OptionMenuVO>)
     * @return Map형태
     */
    public Map<String, List<OptionMenuVO>> setMenuOptionToMap(List<OptionMenuVO> optionMenu){
        Map<String, List<OptionMenuVO>> map = new HashMap<>();
        for (OptionMenuVO vo : optionMenu) {
            String category = vo.getOptionMenuCategory();

            // 맵에 이미 해당 카테고리가 있으면, 그 리스트에 추가
            if (map.containsKey(category)) {
                map.get(category).add(vo);
            }
            // 맵에 해당 카테고리가 없으면, 새로운 리스트를 만들고 추가
            else {
                List<OptionMenuVO> newList = new ArrayList<>();
                newList.add(vo);
                map.put(category, newList);
            }
        }
        return map;
    }

    /***
     * 같은 메뉴 카테고리끼리 묶는 API
     * @param Menu(List<OptionMenuVO>)
     * @return Map형태
     */
    public Map<String, List<MenuVO>> setMenuToMap(List<MenuVO> Menu){
        Map<String, List<MenuVO>> map = new HashMap<>();
        for (MenuVO vo : Menu) {
            String category = vo.getMenuCategory();

            // 맵에 이미 해당 카테고리가 있으면, 그 리스트에 추가
            if (map.containsKey(category)) {
                map.get(category).add(vo);
            }
            // 맵에 해당 카테고리가 없으면, 새로운 리스트를 만들고 추가
            else {
                List<MenuVO> newList = new ArrayList<>();
                newList.add(vo);
                map.put(category, newList);
            }
        }
        return map;
    }

}
