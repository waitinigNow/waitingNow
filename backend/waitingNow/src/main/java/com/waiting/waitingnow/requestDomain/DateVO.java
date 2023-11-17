package com.waiting.waitingnow.requestDomain;

import java.util.ArrayList;
import java.util.Collections;

public class DateVO {
    private ArrayList<Integer> customer = new ArrayList<>(Collections.nCopies(24, 0));;

    public ArrayList<Integer> getCustomer() {
        return customer;
    }

    public void setCustomer(ArrayList<Integer> customer, int time, int count) {
        customer.set(time, count);
        this.customer = customer;
    }
}
