*** Settings ***
Resource    ../../../../resources/pages/LoginPage.resource
Resource    ../../../../resources/pages/InventoryPage.resource
Resource    ../../../../resources/keywords/common_keywords.resource

Suite Setup       Open Browser To SauceDemo
Suite Teardown    Close Browser Session
Test Setup        Return To Login Page


*** Keywords ***
Return To Login Page
    Go To URL    ${BASE_URL}
    LoginPage.Page Should Be Loaded


*** Test Cases ***
Valid Login Should Succeed
    [Tags]    regression    login
    Login As Standard User
    Inventory Page Should Be Loaded

Locked Out User Cannot Login
    [Tags]    regression    login
    Login As Locked Out User
    Login Should Fail With Message    Epic sadface: Sorry, this user has been locked out.

Login Fails With Wrong Password
    [Tags]    regression    login
    Login With Credentials    standard_user    wrong_password
    Login Should Fail With Message    Epic sadface: Username and password do not match any user in this service

Login Requires Username And Password
    [Tags]    regression    login
    Login With Credentials    ${EMPTY}    ${EMPTY}
    Login Should Fail With Message    Epic sadface: Username is required