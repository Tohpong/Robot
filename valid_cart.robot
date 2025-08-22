*** Settings ***
Documentation     A test suite with a single test for valid login.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          resource.robot

*** Test Cases ***
Valid Login
    Open Browser To Login Page
    Input Username    standard_user
    Input Password    secret_sauce
    Submit Credentials
    Welcome Page Should Be Open
    [Teardown]    Close Browser


*** Settings ***
Resource    resource.robot
Test Setup  Open Browser To Login Page
Test Teardown    Close Browser

*** Test Cases ***
ตรวจสอบว่าสินค้าที่เพิ่มมาแสดงในหน้า Cart Page
    Input Username    ${VALID USER}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Welcome Page Should Be Open

    Click Button    css=button[data-test="add-to-cart-sauce-labs-backpack"]
    Click Cart Icon
    Cart Page Should Be Open
    Cart Should Contain Product    Sauce Labs Backpack

ตรวจสอบปุ่ม Remove ทำงานได้
    Input Username    ${VALID USER}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Welcome Page Should Be Open

    Click Button    css=button[data-test="add-to-cart-sauce-labs-bike-light"]
    Click Cart Icon
    Cart Page Should Be Open
    Remove Product From Cart    Sauce Labs Bike Light
    Page Should Not Contain    Sauce Labs Bike Light

ตรวจสอบปุ่ม Continue Shopping
    Input Username    ${VALID USER}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Welcome Page Should Be Open

    Click Button    css=button[data-test="add-to-cart-sauce-labs-fleece-jacket"]
    Click Cart Icon
    Cart Page Should Be Open
    Click Continue Shopping
    Location Should Contain    /inventory.html

ตรวจสอบปุ่ม Checkout
    Input Username    ${VALID USER}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Welcome Page Should Be Open

    Click Button    css=button[data-test="add-to-cart-sauce-labs-onesie"]
    Click Cart Icon
    Cart Page Should Be Open
    Click Checkout
    Location Should Contain    /checkout-step-one.html

    #########################################################

    *** Settings ***
Resource    resource.robot   # import ไฟล์ข้างบน
Test Setup  Open Browser To Login Page
Test Teardown    Close Browser

*** Test Cases ***
เพิ่มสินค้าและลบออกจากตะกร้า
    Input Username    ${VALID USER}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Welcome Page Should Be Open

    Add First Product To Cart
    Go To Cart
    Remove Product From Cart
    Cart Should Be Empty

*** Test Cases ***
ตรวจสอบการเรียงสินค้าจาก A ถึง Z
    Input Username    ${VALID USER}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Welcome Page Should Be Open

    Select Sort Option    az    # value ของ dropdown: az
    Products Should Be Sorted A To Z

ตรวจสอบการเรียงสินค้าจาก Z ถึง A
    Input Username    ${VALID USER}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Welcome Page Should Be Open

    Select Sort Option    za    # value ของ dropdown: za
    Products Should Be Sorted Z To A

*** Settings ***
Resource    resource.robot
Test Setup  Open Browser To Login Page
Test Teardown    Close Browser

*** Test Cases ***
ตรวจสอบการกดไอคอนรถเข็น
    Input Username    ${VALID USER}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Welcome Page Should Be Open

    Click Cart Icon
    Cart Page Should Be Open