*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${SERVER}         saucedemo.com
${BROWSER}        Chrome
${VALID USER}     standard_user
${VALID PASSWORD}    secret_sauce
${LOGIN URL}      https://www.${SERVER}
${WELCOME URL}    https://www.${SERVER}/inventory.html
${ERROR URL}      https://www.${SERVER}

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Login Page Should Be Open

Login Page Should Be Open
    Title Should Be    Swag Labs
    Wait Until Page Contains Element    id=user-name   10s

Go To Login Page
    Go To    ${LOGIN URL}
    Login Page Should Be Open

Input Username
    [Arguments]    ${username}
    Input Text    id=user-name    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    id=password     ${password}

Submit Credentials
    Click Button    id=login-button

Welcome Page Should Be Open
    Wait Until Location Contains    /inventory.html     10s
    Location Should Be    ${WELCOME URL}
    Title Should Be    Swag Labs

Welcome Should Have Failed
    # ใช้อย่างใดอย่างนึงก็ได้ (หรือทั้งคู่)
    Wait Until Location Is      ${ERROR URL}    10s
    Wait Until PageContains Element     css=[data-test="error"]     10s


*** Keywords ***
Cart Should Contain Product
    [Arguments]    ${product_name}
    Page Should Contain    ${product_name}

Remove Product From Cart
    [Arguments]    ${product_name}
    Click Button    xpath=//div[text()="${product_name}"]/ancestor::div[@class="cart_item"]//button
    Page Should Not Contain    ${product_name}

Click Continue Shopping
    Click Button    css=button[data-test="continue-shopping"]
    Wait Until Location Contains    /inventory.html   5s
    Title Should Be    Swag Labs

Click Checkout
    Click Button    css=button[data-test="checkout"]
    Wait Until Location Contains    /checkout-step-one.html   5s
    Title Should Be    Swag Labs

#################################################


# ========================
# Cart Function Keywords
# ========================
Add First Product To Cart
    Click Button    css=button[data-test="add-to-cart-sauce-labs-backpack"]
    Wait Until Page Contains Element    css=.shopping_cart_badge   5s
    Element Text Should Be    css=.shopping_cart_badge    1

Go To Cart
    Click Element    css=.shopping_cart_link
    Wait Until Location Contains    /cart.html   5s
    Title Should Be    Swag Labs

Remove Product From Cart
    Click Button    css=button[data-test="remove-sauce-labs-backpack"]
    Wait Until Element Does Not Contain    css=.cart_item    Sauce Labs Backpack    5s

Cart Should Be Empty
    Page Should Not Contain Element    css=.cart_item
    Page Should Contain    Your cart is empty

*** Keywords ***
Select Sort Option
    [Arguments]    ${option}
    Select From List By Value    css=select[data-test="product_sort_container"]    ${option}
    Sleep    1s    # เผื่อให้ DOM refresh

Get Product Names
    @{names}=    Get Texts    css=.inventory_item_name
    [Return]    @{names}

Products Should Be Sorted A To Z
    @{names}=    Get Product Names
    ${sorted}=    Evaluate    sorted(${names})
    Lists Should Be Equal    ${names}    ${sorted}

Products Should Be Sorted Z To A
    @{names}=    Get Product Names
    ${sorted}=    Evaluate    sorted(${names}, reverse=True)
    Lists Should Be Equal    ${names}    ${sorted}

*** Keywords ***
Click Cart Icon
    Click Element    css=.shopping_cart_link
    Wait Until Location Contains    /cart.html   5s
    Title Should Be    Swag Labs

Cart Page Should Be Open
    Location Should Contain    /cart.html
    Page Should Contain Element    css=.cart_list
