*** Settings ***
Library    SeleniumLibrary

Resource    ../config/env_saucedemo.robot
Resource    ../config/browsers.robot


*** Keywords ***
Open Browser To SauceDemo
    [Documentation]    Open browser at SauceDemo login page using configured browser.
    Open Browser    ${BASE_URL}    ${DEFAULT_BROWSER}
    Maximize Browser Window
    Set Selenium Timeout    ${ELEMENT_TIMEOUT}
    Log    Browser opened at ${BASE_URL} with browser: ${DEFAULT_BROWSER}


Close Browser Session
    [Documentation]    Close browser gracefully at suite teardown.
    Run Keyword And Ignore Error    Close Browser