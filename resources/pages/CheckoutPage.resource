*** Settings ***
Resource    BasePage.resource


*** Variables ***
# Page 1: Your Information
${FIRST_NAME_FIELD}      id:first-name
${LAST_NAME_FIELD}       id:last-name
${ZIP_FIELD}             id:postal-code
${CONTINUE_BTN}          id:continue

# Page 2: Overview
${OVERVIEW_CONTAINER}    css:div.checkout_summary_container
${FINISH_BTN}            id:finish
${ITEM_TOTAL_LABEL}      css:div.summary_subtotal_label
${TAX_LABEL}             css:div.summary_tax_label
${TOTAL_LABEL}           css:div.summary_total_label

# Page 3: Complete
${COMPLETE_HEADER}       css:h2.complete-header
${BACK_HOME_BTN}         id:back-to-products


*** Keywords ***
#———————————
#Page Identity - Your Information
#———————————
Information Page Should Be Loaded
    Wait For Element    ${FIRST_NAME_FIELD}
    Wait For Element    ${LAST_NAME_FIELD}
    Wait For Element    ${ZIP_FIELD}
    Log Step    Checkout Information page loaded

#———————————
#Actions - Your Information
#———————————
Enter Checkout Information
    [Arguments]    ${first}    ${last}    ${zip}
    Log Step    Entering checkout information
    Safe Input With Retry    ${FIRST_NAME_FIELD}    ${first}
    Safe Input With Retry    ${LAST_NAME_FIELD}    ${last}
    Safe Input With Retry    ${ZIP_FIELD}          ${zip}

Continue To Overview
    Log Step    Continuing to overview page
    Safe Click With Retry    ${CONTINUE_BTN}

#———————————
#Page Identity - Overview
#———————————
Overview Page Should Be Loaded
    Wait For Page    ${OVERVIEW_CONTAINER}
    Log Step    Checkout Overview page loaded

#———————————
#Assertions - Overview
#———————————
Overview Should Show Item Total
    [Arguments]    ${expected}
    Page Should Contain Text    ${ITEM_TOTAL_LABEL}    ${expected}

Overview Should Show Tax
    [Arguments]    ${expected}
    Page Should Contain Text     ${TAX_LABEL}    ${expected}

Overview Should Show Total
    [Arguments]    ${expected}
    Page Should Contain Text     ${TOTAL_LABEL}    ${expected}

#———————————
#Actions - Overview
#———————————
Finish Checkout
    Log Step    Finishing checkout
    Safe Click With Retry    ${FINISH_BTN}

#———————————
#Page Identity - Complete
#———————————
Complete Page Should Be Loaded
    Wait For Page    ${COMPLETE_HEADER}
    Log Step    Checkout Complete page loaded

#———————————
#Assertions - Complete
#———————————
Checkout Confirmation Should Be Visible
    Element Should Be Visible    ${COMPLETE_HEADER}
    Log Step    Verified order confirmation

#———————————
#Actions - Complete
#———————————
Return To Inventory
    Log Step    Returning to inventory
    Safe Click With Retry    ${BACK_HOME_BTN}