/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hungnp.error;

import java.io.Serializable;

/**
 *
 * @author Win 10
 */
public class ItemError implements Serializable{
    private String nameEmptyError;
    private String imageNotChosenError;
    private String priceEmptyError;
    private String priceInputInvalidError;
    private String unitEmptyError;
    private String quantityEmptyError;
    private String quantityInputInvalidError;
    private String emptyDateError;
    private String dateLessCurrentDateError;

    public ItemError() {
    }
    
    public ItemError(String nameEmptyError, String priceEmptyError, String priceInputInvalidError, String quantityEmptyError, 
            String quantityInputInvalidError, String dateLessCurrentDateError) {
        this.nameEmptyError = nameEmptyError;
        this.priceEmptyError = priceEmptyError;
        this.priceInputInvalidError = priceInputInvalidError;
        this.quantityEmptyError = quantityEmptyError;
        this.quantityInputInvalidError = quantityInputInvalidError;
        this.dateLessCurrentDateError = dateLessCurrentDateError;
    }

    public ItemError(String nameEmptyError, String imageNotChosenError, String priceEmptyError, String priceInputInvalidError,
            String unitEmptyError, String quantityEmptyError, String quantityInputInvalidError, String dateLessCurrentDateError
            ,String emptyDateError) {
        this.nameEmptyError = nameEmptyError;
        this.imageNotChosenError = imageNotChosenError;
        this.priceEmptyError = priceEmptyError;
        this.priceInputInvalidError = priceInputInvalidError;
        this.unitEmptyError = unitEmptyError;
        this.quantityEmptyError = quantityEmptyError;
        this.quantityInputInvalidError = quantityInputInvalidError;
        this.dateLessCurrentDateError = dateLessCurrentDateError;
        this.emptyDateError=emptyDateError;
    }

    public String getEmptyDateError() {
        return emptyDateError;
    }

    public void setEmptyDateError(String emptyDateError) {
        this.emptyDateError = emptyDateError;
    }

    public String getImageNotChosenError() {
        return imageNotChosenError;
    }

    public void setImageNotChosenError(String imageNotChosenError) {
        this.imageNotChosenError = imageNotChosenError;
    }

    public String getUnitEmptyError() {
        return unitEmptyError;
    }

    public void setUnitEmptyError(String unitEmptyError) {
        this.unitEmptyError = unitEmptyError;
    }
    
    
    
    public String getNameEmptyError() {
        return nameEmptyError;
    }

    public void setNameEmptyError(String nameEmptyError) {
        this.nameEmptyError = nameEmptyError;
    }

    public String getPriceEmptyError() {
        return priceEmptyError;
    }

    public void setPriceEmptyError(String priceEmptyError) {
        this.priceEmptyError = priceEmptyError;
    }

    public String getPriceInputInvalidError() {
        return priceInputInvalidError;
    }

    public void setPriceInputInvalidError(String priceInputInvalidError) {
        this.priceInputInvalidError = priceInputInvalidError;
    }

    public String getQuantityEmptyError() {
        return quantityEmptyError;
    }

    public void setQuantityEmptyError(String quantityEmptyError) {
        this.quantityEmptyError = quantityEmptyError;
    }

    public String getQuantityInputInvalidError() {
        return quantityInputInvalidError;
    }

    public void setQuantityInputInvalidError(String quantityInputInvalidError) {
        this.quantityInputInvalidError = quantityInputInvalidError;
    }

    public String getDateLessCurrentDateError() {
        return dateLessCurrentDateError;
    }

    public void setDateLessCurrentDateError(String dateLessCurrentDateError) {
        this.dateLessCurrentDateError = dateLessCurrentDateError;
    }
    
    
}











