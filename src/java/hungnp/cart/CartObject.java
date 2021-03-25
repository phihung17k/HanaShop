/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hungnp.cart;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author Win 10
 */
public class CartObject implements Serializable{
    private Map<String, Integer> items; // string is itemId, value is quantity

    public CartObject() {
    }
    
    public CartObject(Map<String, Integer> items) {
        this.items = items;
    }

    public Map<String, Integer> getItems() {
        return items;
    }

    public void setItems(Map<String, Integer> items) {
        this.items = items;
    }
    
    public void addItem(String itemId){
        if(this.getItems()==null){
            this.setItems(new HashMap<>());
        }
        int quantity=1;
        if(this.getItems().containsKey(itemId)){
            quantity= this.getItems().get(itemId)+1;
        }
        this.getItems().put(itemId, quantity);
        
    }
    
    public void removeItem(String itemId){
        if(this.getItems()==null){
            return;
        }
        if(this.getItems().containsKey(itemId)){
            this.getItems().remove(itemId);
            if(this.getItems().isEmpty()){
                this.setItems(null);
            }
        }
    }
    
    public void reduceQuantityItem(String itemId){
        if(this.getItems()==null){
            return;
        }
        if(this.getItems().containsKey(itemId)){
            int quantity = this.getItems().get(itemId);
            quantity -=1;
            this.getItems().put(itemId, quantity);
        }
    }
    
}






















