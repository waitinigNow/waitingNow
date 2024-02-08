package com.waiting.waitingnow.DTO;

import java.util.List;

public class noWaitingSentDeskAssignVO {
    private List<Integer> deskStoreNumber;
    private int entryPeople;

    public List<Integer> getDeskStoreNumber() {
        return deskStoreNumber;
    }

    public void setDeskStoreNumber(List<Integer> deskStoreNumber) {
        this.deskStoreNumber = deskStoreNumber;
    }

    public int getEntryPeople() {
        return entryPeople;
    }

    public void setEntryPeople(int entryPeople) {
        this.entryPeople = entryPeople;
    }
}
