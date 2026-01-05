# 🧪 SauceDemo Automation Testing Suite
<p align="left">
  <img src="https://img.shields.io/badge/Smoke%20Suite-100%25%20passing-brightgreen?style=flat-square" />
  <img src="https://img.shields.io/badge/Functional%20Tests-100%25%20passing-brightgreen?style=flat-square" />
  <img src="https://img.shields.io/badge/Regression%20Suite-12%2F12%20passing-brightgreen?style=flat-square" />
</p>

A full end-to-end UI automation framework built using Robot Framework, Selenium, and the Page Object Model (POM).
The project includes smoke tests, functional tests, and a complete regression suite — all runnable locally or in CI/CD.


## 🚀 Description 
This project demonstrates a clean, scalable, production-ready UI automation approach for the SauceDemo application.
It includes:
	•	Modular Page Object design
	•	Reusable common keywords
	•	Isolated test suites with controlled browser lifecycle
	•	A master regression runner
	•	CI/CD pipeline integration (GitHub Actions)
	•	Traceability matrix for full test documentation

This repository is designed as both a learning platform and a portfolio-ready automation project.


## ✨ Features
	•	Page Object Model (POM)
	•	Common keyword libraries for flows/navigation
	•	Stable browser lifecycle (per-suite and per-test)
	•	Full smoke test coverage
	•	Functional test suites
	•	Regression test suites (login, inventory, cart, checkout)
	•	Automatic test reports (output.xml, log.html, report.html)
	•	Master regression suite runner script
	•	CI/CD-ready folder structure
	•	Chrome + Firefox support


## 📁 Project Structure
```
Automation Testing
    tests/
        ui/
            saucedemo/
                login.robot
                inventory.robot
                cart.robot
                checkout.robot
                checkout_negative.robot
                checkout_edgeCase.robot
                checkout_dataDriven.robot
                smoke.robot
                regression/
                    login_regression.robot
                    inventory_regression.robot
                    cart_regression.robot
                    checkout_regression.robot
    resources/
        pages/
            LoginPage.resource
            InventoryPage.resource
            CartPage.resource
            CheckoutPage.resource
        keywords/
            common_keywords.resource
        config/
            env_saucedemo.robot
            credentials.robot
            browsers.robot 
            settings.robot
    reports/
        ui/
    .github/
        workflows/
            robot-ui-tests.yml    
    README.md
    TRACEBILITY.md
    requirements.txt
    run_regression.sh
```

📌 Roles (Folder → Responsibility):
```
	•	tests/ → High-level UI scenarios (readable like specs)
	•	resources/pages/ → Page Objects: locators + low-level interactions
	•	resources/keywords/ → Reusable common flows (login, logout, navigation)
    •	resources/config/ → Environment, browser, credentials, settings
    •	reports/ → Test runners output HTML/XML reports
    •	.github/workflows/ → CI/CD pipeline (GitHub Actions)
```

## 🔍 Debugging Protocol
A structured method for diagnosing any UI automation failure.

Step 1 — Identify Failure Category
Every failure is one of these:
🔹 Element not found
(check locator, timing, page load)
🔹 Keyword not found
(check imports, spelling, indentation)
🔹 Browser didn’t navigate
(check Suite Setup)
🔹 Popup interfered
(re-run with Chrome options / switch to Firefox)

Step 2 — Validate the Locator in DevTools
	1.	Open website 
	2.	Press Ctrl+Shift+C
	3.	Inspect the element
	4.	Validate XPath or CSS

Step 3 — Run Test in Isolation

Step 4 — Enable Debug Screenshots

Step 5 — Confirm Keywords Load Correctly
Check:
	•	BasePage.resource not overridden
	•	No naming collisions with SeleniumLibrary
	•	All resource imports are correct relative paths


## 🧵 Template-Based Generation for New Tests
📄 Test Case Template
```
*** Settings ***
Resource    ../../../resources/pages/LoginPage.resource
Resource    ../../../resources/keywords/common_keywords.resource

Suite Setup       Open Browser To SauceDemo
Suite Teardown    Close Browser Session

*** Test Cases ***
<Feature> Should Work
    <Preconditions>
    <Action>
    <Assertion>
```
📄 Page Object Template
```
*** Settings ***
Resource    BasePage.resource

*** Variables ***
${PAGE_IDENTIFIER}      css:...

${FIELD_TMPL}           xpath=...

*** Keywords ***
<Page> Page Should Be Loaded
    Wait For Page    ${PAGE_IDENTIFIER}
    Log Step    <Page> page loaded

Action Keyword
    Log Step    <Describe Action>
    Safe Click With Retry    ...

Assertion Keyword
    ${text}=    Get Text    ${locator}
    Should Contain    ${text}    ${expected}
```


## 🧪 Test Suite Purpose Mapping 
This creates traceability between features → tests → page objects.

🔹 smoke.robot — “Critical Happy Path”
	•	Tests the core purchase flow
	•	If this fails, site is broken
	•	Depends on LoginPage, InventoryPage, CartPage, CheckoutPage

🔹 login.robot — Login Variants
	•	Positive + negative + edge cases
	•	Tests: success, locked-out, wrong password, missing fields

🔹 inventory.robot — Sorting & Product Visibility
	•	Sorting A→Z, price order
	•	Adding items to cart
	•	Depends on InventoryPage + LoginPage

🔹 cart.robot — Cart Behavior
	•	Verify items present/absent
	•	Remove items
	•	Continue shopping → returns to inventory

🔹 checkout.robot — Checkout & Validation
Goal: Validate checkout flow and form validation.
Core Functional Coverage
	•	Successful checkout
	•	Missing required field errors
	•	Confirmation page validation
Newly Added Tests (🔹 checkout_negative.robot, 🔹 checkout_edgeCase.robot, 🔹 checkout_dataDriven.robot)
These tests expand validation coverage without impacting regression stability:
	•	Negative Validation
	•	Checkout blocked when First Name is missing
	•	Edge Case
	•	Whitespace-only First Name accepted (documented behavior / known limitation)
	•	Data-Driven Validation
	•	Multiple invalid checkout input combinations using template-driven tests

🔹 Regression Suites

Each regression file tests one domain thoroughly without overlapping setup logic.

### 🔗 Full Dependency Mapping
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

Regression Suites (run independently):
login_regression.robot
inventory_regression.robot
cart_regression.robot
checkout_regression.robot
```


## 🧪 Automation Workflow
⭐ Set up project structure
⭐ Configure environment + venv
⭐ Implement Page Objects
⭐ Build smoke test
⭐ Build functional tests
⭐ Build regression suite
⭐ Create master regression runner
⭐ Add tags: smoke, regression, functional
⭐ Add CI/CD workflow
⭐ Add traceability matrix
⭐ Add README badges & documentation

### Running the Regression Suite
The regression pack consists of:
```
- `login_regression.robot`
- `inventory_regression.robot`
- `cart_regression.robot`
- `checkout_regression.robot`
```
All regression tests are tagged with [regression]
Run the full regression suite:
```
bash
./run_regression.sh
or
robot --include regression -d reports/ui/regression tests/ui/saucedemo
```
### 🎛 Running Individual Suites
Smoke:
```
 robot -d reports/ui tests/ui/saucedemo/smoke.robot
```
Functional: 
``` 
 robot -d reports/ui tests/ui/saucedemo/checkout.robot
 robot -d reports/ui tests/ui/saucedemo/cart.robot
```


## 🧠 Possible Enhancements (Future Work) 
	•	Add parallel execution (Pabot)
	•	Add design for multi-environment testing (QA/Staging/Prod)
	•	Add data-driven test examples
	•	Integrate video recordings in CI
	•	Add Allure reporting
	•	Add visual regression testing layer
	•	Add API test layer for backend verification


## 💡 Why This Project Matters  
This repository demonstrates:
	•	Architectural understanding of automation
	•	Ability to create stable, maintainable tests
	•	Mastery of Robot Framework + Selenium
	•	CI/CD-friendly test design
	•	Test hierarchy and traceability
	•	Real-world QA engineering thinking