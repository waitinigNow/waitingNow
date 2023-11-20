package com.waiting.waitingnow.DTO;

import java.util.ArrayList;
import java.util.Collections;

public class DateVO {
    private ArrayList<Integer> customer = new ArrayList<>(Collections.nCopies(24, 0));;

    public ArrayList<Integer> getCustomer() {
        return customer;
    }

    public void setCustomer(int time) {
        this.customer.set(time, this.customer.get(time)+1);
    }
}
