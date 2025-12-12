*** Settings ***
Resource    BasePage.resource
Resource    ../config/credentials.robot


*** Variables ***
${URL_LOGIN}          ${BASE_URL}
${TXT_USERNAME}       id:user-name
${TXT_PASSWORD}       id:password
${BTN_LOGIN}          id:login-button
${ERROR_CONTAINER}    css:div.error-message-container

# UPDATED to match SauceDemo’s real DOM
${ERROR_CONTAINER}    css:div[data-test="error"]
${ERROR_TEXT}         css:h3[data-test="error"]


*** Keywords ***
#-----------------------------------------------------
# Page Identity
#-----------------------------------------------------
Login Page Should Be Loaded
    Wait For Page    ${BTN_LOGIN}
    Log Step    Login page loaded

LoginPage.Page Should Be Loaded
    # Backwards-compatible alias for existing tests (smoke, etc.)
    Login Page Should Be Loaded


#-----------------------------------------------------
# Atomic Actions
#-----------------------------------------------------
Enter Username
    [Arguments]    ${username}
    Safe Input With Retry    ${TXT_USERNAME}    ${username}

Enter Password
    [Arguments]    ${password}
    Safe Input With Retry    ${TXT_PASSWORD}    ${password}

Click Login Button
    Safe Click With Retry    ${BTN_LOGIN}


#-----------------------------------------------------
# Composite Actions
#-----------------------------------------------------
Login With Credentials
    [Arguments]    ${username}    ${password}
    Log Step    Attempting login using username: ${username}
    Log Page State

    Log Step    Typing username...
    Enter Username    ${username}

    Log Step    Typing password...
    Enter Password    ${password}

    Log Step    Clicking login button...
    Click Login Button

    Sleep    1s
    Log Page State

Login As Standard User
    Log Step    Logging in as STANDARD_USER
    Login With Credentials    ${STANDARD_USER}    ${PASSWORD}

Login As Locked Out User
    Log Step    Logging in as LOCKED_OUT_USER
    Login With Credentials    ${LOCKED_OUT_USER}    ${PASSWORD}


#-----------------------------------------------------
# Assertions
#-----------------------------------------------------
Login Should Fail With Message
    [Arguments]    ${expected_message}
    Element Should Be Visible    ${ERROR_TEXT}
    ${actual}=    Get Text    ${ERROR_TEXT}
    Should Contain    ${actual}    ${expected_message}
    Log Step    Verified login failure message: ${expected_message}