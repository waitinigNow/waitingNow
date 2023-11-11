package com.waiting.waitingnow.domain;

public class MemberVO {
    private int memberNumber;
    private String memberName;
    private String memberEmail;
    private String memberPhone;
    private String memberPassword;
    private String memberStoreName;
    private String memberStorePhone;
    private String memberStoreCategory;
    private boolean memberPreorder;

    public int getMemberNumber() {
        return memberNumber;
    }

    public void setMemberNumber(int memberNumber) {
        this.memberNumber = memberNumber;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    public String getMemberEmail() {
        return memberEmail;
    }

    public void setMemberEmail(String memberEmail) {
        this.memberEmail = memberEmail;
    }

    public String getMemberPhone() {
        return memberPhone;
    }

    public void setMemberPhone(String memberPhone) {
        this.memberPhone = memberPhone;
    }

    public String getMemberPassword() {
        return memberPassword;
    }

    public void setMemberPassword(String memberPassword) {
        this.memberPassword = memberPassword;
    }

    public String getMemberStoreName() {
        return memberStoreName;
    }

    public void setMemberStoreName(String memberStoreName) {
        this.memberStoreName = memberStoreName;
    }

    public String getMemberStorePhone() {
        return memberStorePhone;
    }

    public void setMemberStorePhone(String memberStorePhone) {
        this.memberStorePhone = memberStorePhone;
    }

    public String getMemberStoreCategory() {
        return memberStoreCategory;
    }

    public void setMemberStoreCategory(String memberStoreCategory) {
        this.memberStoreCategory = memberStoreCategory;
    }

    public boolean isMemberPreorder() {
        return memberPreorder;
    }

    public void setMemberPreorder(boolean memberPreorder) {
        this.memberPreorder = memberPreorder;
    }
}
