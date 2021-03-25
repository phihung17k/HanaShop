/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hungnp.dtos;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author Win 10
 */
public class ItemDTO implements Serializable{
    private String itemId;
    private String itemName;
    private String image;
    private int price;
    private String unit;
    private int quantity;
    private String category;
    private String description;
    private Date createdDate;
    private Date expirationDate;
    private String status;

    public ItemDTO(String itemId, String itemName, int price){
        this.itemId = itemId;
        this.itemName = itemName;
        this.price = price;
    }
    
    public ItemDTO(String itemId, String itemName, String image, int price, String unit, int quantity , Date expirationDate) {
        this.itemId = itemId;
        this.itemName = itemName;
        this.image = image;
        this.price = price;
        this.unit = unit;
        this.quantity= quantity;
        this.expirationDate=expirationDate;
    }
    
    public ItemDTO(String itemId, String itemName, String image, int price, String unit, int quantity,
            String category, String description, Date expirationDate) {
        this.itemId = itemId;
        this.itemName = itemName;
        this.image = image;
        this.price = price;
        this.unit = unit;
        this.quantity= quantity;
        this.category = category;
        this.description = description;
        this.expirationDate= expirationDate;
    }

    public ItemDTO(String itemId, String itemName, String image, int price, int quantity, String category, Date expirationDate, String status) {
        this.itemId = itemId;
        this.itemName = itemName;
        this.image = image;
        this.price = price;
        this.quantity = quantity;
        this.category = category;
        this.expirationDate = expirationDate;
        this.status = status;
    }

    public ItemDTO(String itemId, String itemName, String image, int price, String unit, int quantity, String category, String description, Date expirationDate, String status) {
        this.itemId = itemId;
        this.itemName = itemName;
        this.image = image;
        this.price = price;
        this.unit = unit;
        this.quantity = quantity;
        this.category = category;
        this.description = description;
        this.expirationDate = expirationDate;
        this.status = status;
    }
    
    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
    
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getExpirationDate() {
        return expirationDate;
    }

    public void setExpirationDate(Date expirationDate) {
        this.expirationDate = expirationDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}









































