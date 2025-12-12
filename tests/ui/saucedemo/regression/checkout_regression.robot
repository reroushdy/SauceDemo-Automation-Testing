*** Settings ***
Resource    ../../../../resources/pages/LoginPage.resource
Resource    ../../../../resources/pages/InventoryPage.resource
Resource    ../../../../resources/pages/CartPage.resource
Resource    ../../../../resources/pages/CheckoutPage.resource
Resource    ../../../../resources/keywords/common_keywords.resource

Suite Setup       Setup Checkout Regression Suite
Suite Teardown    Close Browser Session
Test Setup        Return To Checkout Start


*** Keywords ***
Setup Checkout Regression Suite
    Open Browser To SauceDemo
    Login As Standard User
    Inventory Page Should Be Loaded
    Add Product To Cart    Sauce Labs Backpack
    Go To Cart
    Cart Page Should Be Loaded


Return To Checkout Start
    # Always begin each test at the Cart page with 1 item
    Go To URL    ${BASE_URL}
    Login As Standard User
    Inventory Page Should Be Loaded
    Wait For Page To Stabilize
    Add Product To Cart    Sauce Labs Backpack
    Go To Cart
    Cart Page Should Be Loaded


Click Continue Button Without Input
    Log Step    Clicking Continue without entering checkout info
    Safe Click With Retry    ${CONTINUE_BTN}


Error Should Show
    [Arguments]    ${expected_message}
    ${error_locator}=    Set Variable    css:h3[data-test="error"]
    Element Should Be Visible    ${error_locator}
    Page Should Contain Text     ${expected_message}
    Log Step    Verified checkout error: ${expected_message}


*** Test Cases ***
User Can Complete Checkout Flow
    [Tags]    regression    checkout
    Proceed To Checkout
    Information Page Should Be Loaded
    Enter Checkout Information    Jane    Tester    90210
    Continue To Overview
    Overview Page Should Be Loaded
    Finish Checkout
    Complete Page Should Be Loaded
    Checkout Confirmation Should Be Visible


Checkout Requires First Name
    [Tags]    regression    checkout    validation
    Proceed To Checkout
    Information Page Should Be Loaded
    Click Continue Button Without Input
    Error Should Show    Error: First Name is required