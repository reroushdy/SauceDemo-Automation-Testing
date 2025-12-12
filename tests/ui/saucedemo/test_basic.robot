*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Test Basic Navigation
    Open Browser    https://www.saucedemo.com/    chrome
    Sleep    3s
    Input Text    id:user-name    standard_user
    Sleep    3s
    Close Browser

    Open Browser    https://www.saucedemo.com/    firefox
    Sleep    3s
    Input Text    id:user-name    standard_user
    Sleep    3s
    Close Browser