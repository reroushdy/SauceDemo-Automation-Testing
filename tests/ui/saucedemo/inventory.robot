*** Settings ***
Resource    ../../../resources/pages/LoginPage.resource
Resource    ../../../resources/pages/InventoryPage.resource
Resource    ../../../resources/pages/CartPage.resource
Resource    ../../../resources/keywords/common_keywords.resource

Suite Setup       Open Inventory Session
Suite Teardown    Close Browser Session
Test Teardown     Return To Inventory Page


*** Keywords ***
Open Inventory Session
    Open Browser To SauceDemo
    Login As Standard User
    Inventory Page Should Be Loaded

Return To Inventory Page
    Go To    ${BASE_URL}/inventory.html
    Inventory Page Should Be Loaded


*** Test Cases ***
User Can Sort Items From A To Z
    Sort Products By    Name (A to Z)

User Can Sort Items From High To Low Price
    Sort Products By    Price (high to low)

User Can Add Item To Cart From Inventory Page
    Add Product To Cart    Sauce Labs Bike Light
    Go To Cart
    Cart Page Should Be Loaded
    Cart Should Contain Product    Sauce Labs Bike Light