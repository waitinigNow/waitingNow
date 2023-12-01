package com.waiting.waitingnow.domain;

public class OptionMenuVO {
    private int optionMenuKey;
    private int menuNumber;
    private String optionMenuName;
    private int optionMenuPrice;
    private String optionMenuCategory;

    public int getOptionMenuKey() {
        return optionMenuKey;
    }

    public void setOptionMenuKey(int optionMenuKey) {
        this.optionMenuKey = optionMenuKey;
    }

    public int getMenuNumber() {
        return menuNumber;
    }

    public void setMenuNumber(int menuNumber) {
        this.menuNumber = menuNumber;
    }

    public int getOptionMenuPrice() {
        return optionMenuPrice;
    }

    public void setOptionMenuPrice(int optionMenuPrice) {
        this.optionMenuPrice = optionMenuPrice;
    }

    public String getOptionMenuName() {
        return optionMenuName;
    }

    public void setOptionMenuName(String optionMenuName) {
        this.optionMenuName = optionMenuName;
    }

    public String getOptionMenuCategory() {
        return optionMenuCategory;
    }

    public void setOptionMenuCategory(String optionMenuCategory) {
        this.optionMenuCategory = optionMenuCategory;
    }
}
