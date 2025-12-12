## 🧭 TRACEABILITY MATRIX – SauceDemo UI Automation Project

This document provides full traceability across all automated UI tests in the SauceDemo framework.
It connects requirements → test cases → components → verification status, ensuring transparency, maintainability, and audit readiness.


## 📘 1. Requirements Overview
This matrix links:
- Requirements → what the system must support
- Test Cases → which tests validate each requirement
- Pages / Keywords → artifacts used by those tests

This ensures full coverage and helps identify impact when changing functionality.


## 📗 2. Requirement Definitions
```
REQ-LOGIN-001  Standard user login succeeds
REQ-LOGIN-002  Wrong password shows correct error message
REQ-LOGIN-003  Locked out user sees locked-out error
REQ-LOGIN-004  Username and password fields are required

REQ-INVENTORY-001 Inventory page loads properly after login
REQ-INVENTORY-002 User can sort products by name
REQ-INVENTORY-003 User can sort products by price
REQ-INVENTORY-004 Items can be added from inventory page

REQ-CART-001  Cart displays correct items
REQ-CART-002  Items can be removed from cart
REQ-CART-003  Continue Shopping returns to inventory page

REQ-CHECKOUT-001 Checkout information can be submitted
REQ-CHECKOUT-002 Checkout overview loads correctly
REQ-CHECKOUT-003 Completing checkout shows confirmation
REQ-CHECKOUT-004 Error messages appear for missing required fields
```


## 📙 3. Test Case → Requirement Traceability Matrix
🔵 Login Tests
| Test Case                              | Requirement(s)        | Suite(s)                        |
|----------------------------------------|------------------------|---------------------------------|
| Valid Login Should Succeed             | REQ-LOGIN-001         | login, login_regression, smoke |
| Locked Out User Cannot Login           | REQ-LOGIN-003         | login, login_regression        |
| Login Fails With Wrong Password        | REQ-LOGIN-002         | login, login_regression        |
| Login Requires Username And Password   | REQ-LOGIN-004         | login, login_regression        |

🟣 Inventory Tests
| Test Case                                  | Requirement(s)                | Suite(s)                           |
|--------------------------------------------|-------------------------------|------------------------------------|
| User Can Sort Items From A To Z            | REQ-INVENTORY-002             | inventory, inventory_regression    |
| User Can Sort Items From High To Low Price | REQ-INVENTORY-003             | inventory, inventory_regression    |
| User Can Add Item To Cart From Inventory   | REQ-INVENTORY-004, REQ-CART-001 | inventory, inventory_regression |

🟡 Cart Tests
| Test Case                                  | Requirement(s)        | Suite(s)                       |
|--------------------------------------------|------------------------|--------------------------------|
| Cart Should Show Added Product             | REQ-CART-001          | cart, cart_regression          |
| User Can Remove Product From Cart          | REQ-CART-002          | cart, cart_regression          |
| Continue Shopping Returns User To Inventory| REQ-CART-003          | cart, cart_regression          |

🟢 Checkout Tests
| Test Case                            | Requirement(s)                    | Suite(s)                         |
|--------------------------------------|-----------------------------------|----------------------------------|
| User Can Complete Checkout Flow      | REQ-CHECKOUT-001, REQ-CHECKOUT-002, REQ-CHECKOUT-003 | checkout, checkout_regression, smoke |
| Checkout Requires First Name         | REQ-CHECKOUT-004                 | checkout, checkout_regression     |


## 📘 4. Requirement → Test Case Coverage Map
| Requirement               | Test Case(s)                                                                 |
|---------------------------|-------------------------------------------------------------------------------|
| REQ-LOGIN-001            | Valid Login Should Succeed                                                     |
| REQ-LOGIN-002            | Login Fails With Wrong Password                                                |
| REQ-LOGIN-003            | Locked Out User Cannot Login                                                   |
| REQ-LOGIN-004            | Login Requires Username And Password                                           |
| REQ-INVENTORY-001        | (Implicitly Verified by all inventory tests after login)                       |
| REQ-INVENTORY-002        | User Can Sort Items From A To Z                                                |
| REQ-INVENTORY-003        | User Can Sort Items From High To Low Price                                     |
| REQ-INVENTORY-004        | User Can Add Item To Cart From Inventory                                       |
| REQ-CART-001             | Cart Should Show Added Product                                                 |
| REQ-CART-002             | User Can Remove Product From Cart                                              |
| REQ-CART-003             | Continue Shopping Returns User To Inventory                                    |
| REQ-CHECKOUT-001         | User Can Complete Checkout Flow                                                |
| REQ-CHECKOUT-002         | User Can Complete Checkout Flow                                                |
| REQ-CHECKOUT-003         | User Can Complete Checkout Flow                                                |
| REQ-CHECKOUT-004         | Checkout Requires First Name                                                   |


## 📗 5. Test → Page Object Mapping
| Suite/Test                         | Pages Used                               |
|-----------------------------------|-------------------------------------------|
| login.robot                       | LoginPage                                 |
| inventory.robot                   | LoginPage, InventoryPage                  |
| cart.robot                        | InventoryPage, CartPage                   |
| checkout.robot                    | CartPage, CheckoutPage, InventoryPage     |
| smoke.robot                       | Login → Inventory → Cart → Checkout       |
| regression suites                 | Same structure as functional suites       |


## 📙 6. Impact Analysis Guide
-- When a change occurs:
 
 ### ✔ Change in LoginPage.resource
Impacts:
- login.robot
- login_regression.robot
- smoke.robot
- checkout_regression (if login flow reused)

 ### ✔ Change in InventoryPage.resource
Impacts:
- inventory.robot
- inventory_regression.robot
- smoke.robot
- cart flows
- checkout (initial step)

### ✔ Change in CartPage.resource
Impacts:
- cart.robot
- cart_regression.robot
- smoke.robot
- checkout.robot

### ✔ Change in CheckoutPage.resource
Impacts:
- checkout.robot
- checkout_regression.robot
- smoke.robot


## 🟦 7. Traceability Summary Diagram
```
          BasePage.resource
                 ▲
                 │
  ┌──────────────┼──────────────────────┐
LoginPage   InventoryPage   CartPage   CheckoutPage
     ▲           ▲            ▲            ▲
     │           │            │            │
     ├──────── smoke.robot ───┼────────────┤
     │           │            │            │
login.robot   inventory.robot   cart.robot   checkout.robot

(regression included for all)
```