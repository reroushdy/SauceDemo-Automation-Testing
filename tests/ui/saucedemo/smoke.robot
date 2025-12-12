*** Settings ***
Documentation     Smoke test validating the critical purchase flow in SauceDemo.

Resource    ../../../resources/pages/LoginPage.resource
Resource    ../../../resources/pages/InventoryPage.resource
Resource    ../../../resources/pages/CartPage.resource
Resource    ../../../resources/pages/CheckoutPage.resource
Resource    ../../../resources/config/browsers.robot
Resource    ../../../resources/config/env_saucedemo.robot

Suite Setup     Open Browser To Login Page
Suite Teardown  Close Browser


*** Keywords ***
Open Browser To Login Page
    Open Browser    ${BASE_URL}    ${DEFAULT_BROWSER}
    Maximize Browser Window
    LoginPage.Page Should Be Loaded
    Log Step    Browser opened and login page is ready


*** Test Cases ***
#———————————
#Smoke: Complete Purchase Flow
#———————————
Smoke Purchase Flow
    [Tags]    smoke    ui

    Log Step    Starting smoke test: full purchase flow

    # Login
    Login As Standard User
    Log Step    After login – checking inventory page
    Inventory Page Should Be Loaded

    # Add product
    Add Product To Cart    Sauce Labs Backpack
    Go To Cart
    Cart Page Should Be Loaded
    Cart Should Contain Product    Sauce Labs Backpack

    # Checkout page 1
    Proceed To Checkout
    Information Page Should Be Loaded
    Enter Checkout Information    John    Tester    60601
    Continue To Overview

    # Checkout page 2
    Overview Page Should Be Loaded
    Finish Checkout

    # Checkout complete
    Complete Page Should Be Loaded
    Checkout Confirmation Should Be Visible

    Log Step    Smoke test completed successfully