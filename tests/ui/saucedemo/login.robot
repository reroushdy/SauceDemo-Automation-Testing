*** Settings ***
Resource    ../../../resources/pages/LoginPage.resource
Resource    ../../../resources/pages/InventoryPage.resource
Resource    ../../../resources/keywords/common_keywords.resource

Suite Setup       Open Browser To SauceDemo
Suite Teardown    Close Browser Session
Test Teardown     Return To Login Page


*** Keywords ***
Return To Login Page
    # After each test, always navigate back to the login page
    Go To    ${BASE_URL}
    Login Page Should Be Loaded


*** Test Cases ***
Valid Login Should Succeed
    [Documentation]    Successful login should land on the inventory page.
    Login As Standard User
    Inventory Page Should Be Loaded

Locked Out User Cannot Login
    [Documentation]    Locked out user should see an appropriate error message.
    Login With Credentials    ${LOCKED_OUT_USER}    ${PASSWORD}
    Login Should Fail With Message    Epic sadface: Sorry, this user has been locked out.

Login Fails With Wrong Password
    [Documentation]    Wrong password should show a generic failure message.
    Login With Credentials    standard_user    wrongpass
    Login Should Fail With Message    Epic sadface: Username and password do not match any user in this service

Login Requires Username And Password
    [Documentation]    Clicking login with empty fields should show a required field error.
    Click Login Button
    Login Should Fail With Message    Epic sadface: Username is required