package com.waiting.waitingnow.DTO;

public class SendDeskVO {
    private int deskStoreNumber;
    private int deskPeople;
    private boolean deskAvailable;

    public SendDeskVO(){
        deskAvailable = true;
    }
    public int getDeskStoreNumber() {
        return deskStoreNumber;
    }

    public void setDeskStoreNumber(int deskStoreNumber) {
        this.deskStoreNumber = deskStoreNumber;
    }

    public int getDeskPeople() {
        return deskPeople;
    }

    public void setDeskPeople(int deskPeople) {
        this.deskPeople = deskPeople;
    }

    public boolean isDeskAvailable() {
        return deskAvailable;
    }

    public void setDeskAvailable(boolean deskAvailable) {
        this.deskAvailable = deskAvailable;
    }
}
