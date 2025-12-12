*** Settings ***
Resource    BasePage.resource

*** Variables ***
${CART_LIST}               xpath=//div[@class="cart_list"]
${CHECKOUT_BTN}            id=checkout
${CONTINUE_SHOPPING_BTN}   id=continue-shopping

# Dynamic locators (modern DOM)
${CART_ITEM_TITLE_TMPL}    xpath=//div[@class="cart_item"]//div[@class="inventory_item_name" and normalize-space(.)="{0}"]
${CART_ITEM_REMOVE_TMPL}   xpath=//div[@class="inventory_item_name" and normalize-space(.)="{0}"]/ancestor::div[@class="cart_item"]//button[contains(., "Remove")]


*** Keywords ***
#———————————
# Page Identity
#———————————
Cart Page Should Be Loaded
    Wait For Page    ${CART_LIST}
    Log Step    Cart page loaded


#———————————
# Cart Interactions
#———————————
Remove Item From Cart
    [Arguments]    ${product_name}
    Log Step    Removing item from cart: ${product_name}
    ${remove_locator}=    Build Locator    ${CART_ITEM_REMOVE_TMPL}    ${product_name}
    Wait Until Element Is Visible    ${remove_locator}
    Safe Click With Retry    ${remove_locator}

Continue Shopping
    Log Step    Continuing shopping
    Safe Click With Retry    ${CONTINUE_SHOPPING_BTN}

Proceed To Checkout
    Log Step    Proceeding to checkout
    Safe Click With Retry    ${CHECKOUT_BTN}


#———————————
# Assertions
#———————————
Cart Should Contain Product
    [Arguments]    ${product_name}
    Log Step    Checking for product in cart: ${product_name}
    ${title_locator}=    Build Locator    ${CART_ITEM_TITLE_TMPL}    ${product_name}
    Wait Until Element Is Visible    ${title_locator}

Cart Should Not Contain Product
    [Arguments]    ${product_name}
    Log Step    Confirming product is NOT in cart: ${product_name}
    ${title_locator}=    Build Locator    ${CART_ITEM_TITLE_TMPL}    ${product_name}
    Page Should Not Contain Element    ${title_locator}

Cart Should Have Item Count
    [Arguments]    ${expected_count}
    ${actual}=    Get Element Count    xpath=//div[@class="cart_item"]
    Should Be Equal As Integers    ${actual}    ${expected_count}
    Log Step    Verified cart count: ${expected_count}