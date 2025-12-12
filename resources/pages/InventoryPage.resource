*** Settings ***
Resource    BasePage.resource


*** Variables ***
# Core page elements
${INVENTORY_CONTAINER}      css:[data-test="inventory-container"]
${SORT_DROPDOWN}            css:select[data-test="product-sort-container"]
${CART_ICON}                css:a.shopping_cart_link


*** Keywords ***
# -------------------------------------------------------------
# Page Identity
# -------------------------------------------------------------
Inventory Page Should Be Loaded
    Wait For Page    ${INVENTORY_CONTAINER}
    Log Step    Inventory page loaded


# -------------------------------------------------------------
# Navigation
# -------------------------------------------------------------
Go To Cart
    Log Step    Navigating to cart
    Safe Click With Retry    ${CART_ICON}


# -------------------------------------------------------------
# Sorting
# -------------------------------------------------------------
Sort Products By
    [Arguments]    ${option}
    Log Step    Sorting products by: ${option}
    Wait For And Click    ${SORT_DROPDOWN}
    Select From List By Label    ${SORT_DROPDOWN}    ${option}
    Wait For Page To Stabilize


# -------------------------------------------------------------
# Product Interaction Helpers
# -------------------------------------------------------------
Normalize Product Name
    [Arguments]    ${product_name}
    ${normalized}=    Replace String    ${product_name}    ${SPACE}    -
    ${normalized}=    Convert To Lowercase    ${normalized}
    RETURN    ${normalized}


Get Add Button Locator
    [Arguments]    ${product_name}
    ${id}=    Normalize Product Name    ${product_name}
    ${locator}=    Set Variable    css:button[data-test="add-to-cart-${id}"]
    RETURN    ${locator}


Get Remove Button Locator
    [Arguments]    ${product_name}
    ${id}=    Normalize Product Name    ${product_name}
    ${locator}=    Set Variable    css:button[data-test="remove-${id}"]
    RETURN    ${locator}


Get Product Title Locator
    [Arguments]    ${product_name}
    ${locator}=    Set Variable    xpath://div[@class="inventory_item_name" and normalize-space(.)="${product_name}"]
    RETURN    ${locator}


# -------------------------------------------------------------
# Product-Level Interactions
# -------------------------------------------------------------
Add Product To Cart
    [Arguments]    ${product_name}
    Log Step    Adding product to cart: ${product_name}
    ${btn}=    Get Add Button Locator    ${product_name}
    Safe Click With Retry    ${btn}


Remove Product From Cart
    [Arguments]    ${product_name}
    Log Step    Removing product from cart: ${product_name}
    ${btn}=    Get Remove Button Locator    ${product_name}
    Safe Click With Retry    ${btn}


# -------------------------------------------------------------
# Assertions
# -------------------------------------------------------------
Product Should Be Visible
    [Arguments]    ${product_name}
    ${locator}=    Get Product Title Locator    ${product_name}
    Element Should Be Visible    ${locator}


Product Should Not Be Visible
    [Arguments]    ${product_name}
    ${locator}=    Get Product Title Locator    ${product_name}
    Page Should Not Contain Element    ${locator}


Inventory Should Have Item Count
    [Arguments]    ${expected_count}
    ${actual}=    Get Element Count    css:div.inventory_item
    Should Be Equal As Integers    ${actual}    ${expected_count}


Product Price Should Be
    [Arguments]    ${product_name}    ${expected_price}
    ${locator}=    xpath://div[@class="inventory_item_name" and normalize-space(.)="${product_name}"]/../../div[@class="inventory_item_price"]
    Element Text Should Be    ${locator}    ${expected_price}