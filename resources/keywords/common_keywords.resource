*** Settings ***
Library    SeleniumLibrary

Resource    ../config/env_saucedemo.robot
Resource    ../config/browsers.robot


*** Keywords ***
Open Browser To SauceDemo
    [Documentation]    Open browser at SauceDemo login page using Firefox as the default browser.
    
    # Always use Firefox unless overridden via command line
    Run Keyword If    '${DEFAULT_BROWSER}' == 'firefox'
    ...    Open Browser    ${BASE_URL}    firefox
    ...    ELSE
    ...    Open Browser    ${BASE_URL}    chrome
    ...    options=add_argument=--headless,new;add_argument=--no-sandbox;add_argument=--disable-dev-shm-usage


    Maximize Browser Window
    Set Selenium Timeout    ${ELEMENT_TIMEOUT}
    Log    Browser opened at ${BASE_URL} with browser: ${DEFAULT_BROWSER}


Close Browser Session
    [Documentation]    Close browser gracefully at suite teardown.
    Run Keyword And Ignore Error    Close Browser