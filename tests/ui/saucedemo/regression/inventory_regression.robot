*** Settings ***
Resource    ../../../../resources/pages/LoginPage.resource
Resource    ../../../../resources/pages/InventoryPage.resource
Resource    ../../../../resources/pages/CartPage.resource
Resource    ../../../../resources/keywords/common_keywords.resource

Suite Setup       Setup Inventory Regression Suite
Suite Teardown    Close Browser Session
Test Setup        Return To Inventory Page


*** Keywords ***
Setup Inventory Regression Suite
    Open Browser To SauceDemo
    Login As Standard User
    Inventory Page Should Be Loaded

Return To Inventory Page
    Go To URL    ${BASE_URL}/inventory.html
    Inventory Page Should Be Loaded


*** Test Cases ***
Products Can Be Sorted By Name
    [Tags]    regression    inventory
    Sort Products By    Name (A to Z)

Products Can Be Sorted By Price
    [Tags]    regression    inventory
    Sort Products By    Price (high to low)

User Can Add Item To Cart From Inventory
    [Tags]    regression    inventory    cart
    Add Product To Cart    Sauce Labs Bike Light
    Go To Cart
    Cart Page Should Be Loaded
    Cart Should Contain Product    Sauce Labs Bike Light