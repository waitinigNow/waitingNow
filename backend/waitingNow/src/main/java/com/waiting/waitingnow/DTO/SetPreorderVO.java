package com.waiting.waitingnow.DTO;

import com.waiting.waitingnow.domain.MenuVO;

import java.util.List;

public class SetPreorderVO {
    private int waitingNumber;
    private List<MenuVO> menu;

    public int getWaitingNumber() {
        return waitingNumber;
    }

    public void setWaitingNumber(int waitingNumber) {
        this.waitingNumber = waitingNumber;
    }

    public List<MenuVO> getMenu() {
        return menu;
    }

    public void setMenu(List<MenuVO> menu) {
        this.menu = menu;
    }
}
