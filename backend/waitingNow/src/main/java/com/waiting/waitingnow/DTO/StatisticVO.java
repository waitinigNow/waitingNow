package com.waiting.waitingnow.DTO;

import java.text.SimpleDateFormat;
import java.util.Date;

public class StatisticVO {
    private String memberPhone;
    private Date waitingDate;

    public String getMemberPhone() {
        return memberPhone;
    }

    public String getWaitingDate() {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return simpleDateFormat.format(waitingDate);
    }

    public void setMemberPhone(String memberPhone) {
        this.memberPhone = memberPhone;
    }

    public void setWaitingDate(Date waitingDate) {
        this.waitingDate = waitingDate;
    }
}
