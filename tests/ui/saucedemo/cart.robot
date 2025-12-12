*** Settings ***
Resource    ../../../resources/pages/LoginPage.resource
Resource    ../../../resources/pages/InventoryPage.resource
Resource    ../../../resources/pages/CartPage.resource
Resource    ../../../resources/keywords/common_keywords.resource

Suite Setup       Open Cart Suite
Suite Teardown    Close Browser Session
Test Setup        Ensure Cart Has Backpack
Test Teardown     Return To Cart Page


*** Keywords ***
Open Cart Suite
    # One-time setup for the whole suite
    Open Browser To SauceDemo
    Login As Standard User
    Inventory Page Should Be Loaded

Ensure Cart Has Backpack
    # Make sure each test starts with the backpack in the cart on Cart page
    Go To    ${BASE_URL}/inventory.html
    Inventory Page Should Be Loaded
    Add Product To Cart    Sauce Labs Backpack
    Go To Cart
    Cart Page Should Be Loaded

Return To Cart Page
    # After each test, go back to the cart in a known state/page
    Go To    ${BASE_URL}/cart.html
    Cart Page Should Be Loaded


*** Test Cases ***
Cart Should Show Added Product
    Cart Should Contain Product    Sauce Labs Backpack

User Can Remove Product From Cart
    Remove Item From Cart    Sauce Labs Backpack
    Cart Should Not Contain Product    Sauce Labs Backpack

Continue Shopping Returns User To Inventory Page
    Continue Shopping
    Inventory Page Should Be Loaded