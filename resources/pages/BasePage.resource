*** Settings ***
Library    SeleniumLibrary
Library    String
Library    OperatingSystem

Resource    ../config/settings.robot
Resource    ../config/env_saucedemo.robot


*** Keywords ***
# ---------------------------------------------------------
# Retry-Safe Interactions
# ---------------------------------------------------------
Safe Click With Retry
    [Arguments]    ${locator}    ${retries}=${RETRY_COUNT}
    FOR    ${i}    IN RANGE    ${retries}
        TRY
            Wait For And Click    ${locator}
            EXIT FOR LOOP
        EXCEPT
            Log    Retry click attempt ${i + 1} failed. Retrying...
            Sleep    0.5s
        END
    END


Safe Input With Retry
    [Arguments]    ${locator}    ${text}    ${retries}=${RETRY_COUNT}
    FOR    ${i}    IN RANGE    ${retries}
        TRY
            Wait For And Input Text    ${locator}    ${text}
            EXIT FOR LOOP
        EXCEPT
            Log    Retry input attempt ${i + 1} failed. Retrying...
            Sleep    0.5s
        END
    END


# ---------------------------------------------------------
# Core Interaction Utilities (NO SCROLLING)
# ---------------------------------------------------------
Wait For Element
    [Arguments]    ${locator}    ${timeout}=${ELEMENT_TIMEOUT}
    Wait Until Element Is Visible    ${locator}    ${timeout}


Wait For And Click
    [Arguments]    ${locator}    ${timeout}=${ELEMENT_TIMEOUT}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Click Element    ${locator}


Wait For And Input Text
    [Arguments]    ${locator}    ${text}    ${timeout}=${ELEMENT_TIMEOUT}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Input Text    ${locator}    ${text}


# ---------------------------------------------------------
# Visibility & Presence Assertions
# ---------------------------------------------------------
Wait For Page
    [Arguments]    ${locator}    ${timeout}=${PAGE_LOAD_TIMEOUT}
    Wait Until Page Contains Element    ${locator}    ${timeout}


# ---------------------------------------------------------
# Navigation
# ---------------------------------------------------------
Go To URL
    [Arguments]    ${url}
    Go To    ${url}
    Log Step    Navigated to URL: ${url}


Current URL Should Be
    [Arguments]    ${expected_url}
    ${current}=    Get Location
    Should Be Equal    ${current}    ${expected_url}


Reload Page
    Reload Page
    Log Step    Page reloaded


Scroll To Top
    Execute Javascript    window.scrollTo(0, 0)


Scroll To Bottom
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight)


# ---------------------------------------------------------
# Screenshots and Text Assertions
# ---------------------------------------------------------
Take Page Screenshot
    [Arguments]    ${name}=screenshot
    Capture Page Screenshot    ${name}.png
    Log Step    Screenshot saved: ${name}.png


Page Should Contain Text
    [Arguments]    ${text}    ${timeout}=${ELEMENT_TIMEOUT}
    Wait Until Page Contains    ${text}    ${timeout}


Page Should Not Contain Text
    [Arguments]    ${text}    ${timeout}=${ELEMENT_TIMEOUT}
    Wait Until Page Does Not Contain    ${text}    ${timeout}


# ---------------------------------------------------------
# Logging Utilities
# ---------------------------------------------------------
Log Step
    [Arguments]    ${message}
    Log    --- ${message} ---


Log Page State
    ${url}=    Get Location
    ${title}=    Get Title
    Log    Current URL: ${url}
    Log    Page Title: ${title}


# ---------------------------------------------------------
# Page Stability & Network Idle
# ---------------------------------------------------------
Wait For Page To Stabilize
    [Arguments]    ${timeout}=${PAGE_LOAD_TIMEOUT}
    Wait Until Keyword Succeeds    ${timeout}    0.5s    Page Should Be Stable


Page Should Be Stable
    ${ready}=    Execute Javascript    return document.readyState;
    Should Be Equal    ${ready}    complete


Wait For Network Idle
    [Arguments]    ${timeout}=5s
    Wait Until Keyword Succeeds    ${timeout}    0.5s    Network Should Be Idle


Network Should Be Idle
    ${active}=    Execute Javascript    return window.performance.getEntries().filter(e => e.initiatorType === 'xmlhttprequest' || e.initiatorType === 'fetch').length;
    Should Be Equal As Integers    ${active}    0


# ---------------------------------------------------------
# Debugging & Dynamic Locators
# ---------------------------------------------------------
Highlight Element
    [Arguments]    ${locator}
    Execute Javascript    arguments[0].style.border='3px solid red';    ${locator}
    Sleep    0.2s


Capture HTML Snapshot
    [Arguments]    ${name}=page_snapshot
    ${html}=    Get Source
    Create File    ${name}.html    ${html}
    Log Step    Saved HTML snapshot as ${name}.html


Build Locator
    [Arguments]    ${template}    @{args}
    ${locator}=    Replace String    ${template}    {0}    ${args[0]}
    RETURN    ${locator}