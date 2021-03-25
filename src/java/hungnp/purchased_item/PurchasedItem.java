/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hungnp.purchased_item;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author Win 10
 */
public class PurchasedItem implements Serializable{
    private String invoiceId;
    private String itemName;
    private int itemPrice;
    private Date buyTime;

    public PurchasedItem() {
    }

    public PurchasedItem(String invoiceId, String itemName, int itemPrice, Date buyTime) {
        this.invoiceId = invoiceId;
        this.itemName = itemName;
        this.itemPrice = itemPrice;
        this.buyTime = buyTime;
    }

    public String getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(String invoiceId) {
        this.invoiceId = invoiceId;
    }

    

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public int getItemPrice() {
        return itemPrice;
    }

    public void setItemPrice(int itemPrice) {
        this.itemPrice = itemPrice;
    }

    public Date getBuyTime() {
        return buyTime;
    }

    public void setBuyTime(Date buyTime) {
        this.buyTime = buyTime;
    }
    
}







