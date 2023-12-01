package com.waiting.waitingnow.DTO;

import com.waiting.waitingnow.domain.MenuVO;

import java.util.List;

public class SetPreorderVO {
    private int waitingNumber;
    private List<MenuPreorderVO> menu;

    public int getWaitingNumber() {
        return waitingNumber;
    }

    public void setWaitingNumber(int waitingNumber) {
        this.waitingNumber = waitingNumber;
    }

    public List<MenuPreorderVO> getMenu() {
        return menu;
    }

    public void setMenu(List<MenuPreorderVO> menu) {
        this.menu = menu;
    }
}
