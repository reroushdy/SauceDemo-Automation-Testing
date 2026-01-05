*** Settings ***
Resource    ../../../resources/pages/LoginPage.resource
Resource    ../../../resources/pages/InventoryPage.resource
Resource    ../../../resources/pages/CartPage.resource
Resource    ../../../resources/pages/CheckoutPage.resource
Resource    ../../../resources/keywords/common_keywords.resource

Suite Setup       Setup Checkout Suite
Suite Teardown    Close Browser Session


*** Keywords ***
Setup Checkout Suite
    Open Browser To SauceDemo
    Login As Standard User
    Inventory Page Should Be Loaded


Return To Checkout Start
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
    ${error_locator}=    Set Variable    xpath=//h3[@data-test="error"]
    Element Should Be Visible    ${error_locator}
    Element Text Should Be       ${error_locator}    ${expected_message}
    Log Step    Verified checkout error: ${expected_message}


*** Test Cases ***
Checkout Accepts Whitespace First Name (Known Limitation)
    [Tags]    ui    negative    checkout    edge    known-issue

    Return To Checkout Start
    Proceed To Checkout
    Information Page Should Be Loaded

    Enter Checkout Information    ${SPACE}    Tester    90210
    Click Continue Button Without Input

    # SauceDemo does not trim whitespace; no error is expected
    Overview Page Should Be Loaded