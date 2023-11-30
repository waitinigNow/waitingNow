package com.waiting.waitingnow.DTO;

import com.waiting.waitingnow.domain.OptionMenuVO;

import java.util.List;
import java.util.Map;

public class MenuPreorderVO {
    private int menuNumber;
    private String menuName;
    private int menuPrice;
    private int menuCount;
    private String menuFile;
    private String menuCategory;
    private int memberNumber;
    private Map<String, List<OptionMenuVO>> menuOption;

    public int getMenuCount() {
        return menuCount;
    }

    public void setMenuCount(int menuCount) {
        this.menuCount = menuCount;
    }

    public int getMenuNumber() {
        return menuNumber;
    }

    public void setMenuNumber(int menuNumber) {
        this.menuNumber = menuNumber;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }

    public int getMenuPrice() {
        return menuPrice;
    }

    public void setMenuPrice(int menuPrice) {
        this.menuPrice = menuPrice;
    }

    public String getMenuFile() {
        return menuFile;
    }

    public void setMenuFile(String menuFile) {
        this.menuFile = menuFile;
    }

    public String getMenuCategory() {
        return menuCategory;
    }

    public void setMenuCategory(String menuCategory) {
        this.menuCategory = menuCategory;
    }

    public int getMemberNumber() {
        return memberNumber;
    }

    public void setMemberNumber(int memberNumber) {
        this.memberNumber = memberNumber;
    }

    public Map<String, List<OptionMenuVO>> getMenuOption() {
        return menuOption;
    }

    public void setMenuOption( Map<String, List<OptionMenuVO>> menuOption) {
        this.menuOption = menuOption;
    }
}
