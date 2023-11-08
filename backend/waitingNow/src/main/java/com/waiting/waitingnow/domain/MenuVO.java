package com.waiting.waitingnow.domain;

public class MenuVO {

    private int menuNumber;
    private String menuName;
    private int menuPrice;
    private String menuFile;
    private String menuCategory;
    private int memberNumber;
    private int memberOption;

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

    public int getMemberOption() {
        return memberOption;
    }

    public void setMemberOption(int memberOption) {
        this.memberOption = memberOption;
    }
}
