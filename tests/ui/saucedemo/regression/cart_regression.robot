*** Settings ***
Resource    ../../../../resources/pages/LoginPage.resource
Resource    ../../../../resources/pages/InventoryPage.resource
Resource    ../../../../resources/pages/CartPage.resource
Resource    ../../../../resources/keywords/common_keywords.resource

Suite Setup       Setup Cart Regression Suite
Suite Teardown    Close Browser Session
Test Setup        Return To Cart Page


*** Keywords ***
Setup Cart Regression Suite
    Open Browser To SauceDemo
    Login As Standard User
    Inventory Page Should Be Loaded
    Add Product To Cart    Sauce Labs Backpack
    Go To Cart
    Cart Page Should Be Loaded

Return To Cart Page
    Go To URL    ${BASE_URL}/inventory.html
    Inventory Page Should Be Loaded
    Add Product To Cart    Sauce Labs Backpack
    Go To Cart
    Cart Page Should Be Loaded


*** Test Cases ***
Cart Shows Added Product
    [Tags]    regression    cart
    Cart Should Contain Product    Sauce Labs Backpack

User Can Remove Product From Cart
    [Tags]    regression    cart
    Remove Item From Cart    Sauce Labs Backpack
    Cart Should Not Contain Product    Sauce Labs Backpack

Continue Shopping Returns To Inventory
    [Tags]    regression    cart    navigation
    Continue Shopping
    Inventory Page Should Be Loaded