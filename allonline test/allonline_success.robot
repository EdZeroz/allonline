*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}            https://www.allonline.7eleven.co.th/
${Browser}        Chrome
${SEARCH_BOX}     name=q
${PRODUCT}        ไฮยีน เอ็กซ์เพิร์ทแคร์ น้ำยาปรับผ้านุ่ม ขาวมิลค์กี้ 1100 มล.

*** Test Cases ***
ลูกค้าสั่งซื้อสินค้าสำเร็จ
    เปิดเว็บเบราว์เซอร์
    เข้า AllOnline
    ค้นหาไฮยีน    ${PRODUCT}        
    กดปุ่ม Enter
    ตรวจสอบผลการค้นหา  ${PRODUCT}
    เลือกไฮยีน
    ตรวจสอบสินค้าว่าเป็น ไฮยีน เอ็กซ์เพิร์ทแคร์ น้ำยาปรับผ้านุ่ม ขาวมิลค์กี้ 1100 มล. ราคาต่อชิ้น 119 บาท ได้รับคะแนนต่อชิ้น 33 คะแนน
    เพิ่มจำนวนสินค้าที่ต้องการซื้อ 10 ชิ้น
    ล็อกอิน
    จัดส่งตามที่อยู่
    ชำระเงินด้วยทรูมันนี่วอลเลต และตรวจสอบว่าได้สินค้า 10 ชิ้นในราคา 1190 บาท ค่าจัดส่งฟรี

*** Keywords ***
เปิดเว็บเบราว์เซอร์
    Open Browser    browser=${BROWSER}
เข้า AllOnline
    Go To    ${URL}
ค้นหาไฮยีน
    [Arguments]    ${PRODUCT}        
    Input Text    ${SEARCH_BOX}    ${PRODUCT}      
กดปุ่ม Enter
    Press Keys    None    RETURN    

ตรวจสอบผลการค้นหา
    [Arguments]    ${SEARCH_RESULT}
    Wait Until Page Contains    ${SEARCH_RESULT}
เลือกไฮยีน
    Click Element    //*[@id="page"]/div[2]/div[2]/div/div/div[2]/div/div/div/div/div/div[3]/div[1]/div/a[2]/div
ตรวจสอบสินค้าว่าเป็น ไฮยีน เอ็กซ์เพิร์ทแคร์ น้ำยาปรับผ้านุ่ม ขาวมิลค์กี้ 1100 มล. ราคาต่อชิ้น 119 บาท ได้รับคะแนนต่อชิ้น 33 คะแนน
    Wait Until Page Contains    ${PRODUCT}
    Element Should Contain    //*[@id="article-form"]/div[2]/span/div/div[1]/span    ฿ 119
    Element Should Contain    //*[@id="article-form"]/div[1]/div[3]/div/div[2]/div/span/span    คุณจะได้รับ 33 คะแนน
เพิ่มจำนวนสินค้าที่ต้องการซื้อ 10 ชิ้น
    Input Text    //*[@id="article-form"]/div[2]/div[2]/div[1]/input    10
    Click Element    //*[@id="article-form"]/div[2]/div[2]/div[4]/div[2]/button
ล็อกอิน
    Input Text    name=email    JohnDoh
    Input Text    name=password    abcd1234
    Click Element    //*[@id="__next"]/div/div/div[2]/div[2]/div/div/div/div[6]/a[1]
    Wait Until Page Contains    สมัครสมาชิกวันนี้ รับสิทธิพิเศษมากมาย
    Click Element    //*[@id="__next"]/div/div/div[2]/div[2]/div/div/div[3]/div/button[2]
จัดส่งตามที่อยู่
    Wait Until Page Contains    ${PRODUCT}
    Click Element    id=btn-accept-gdpr
    Click Element    //*[@id="address-tabs"]/ul/li[2]/a
    Wait Until Page Contains    ที่อยู่ในการจัดส่งสินค้า
    Click Element    //*[@id="addressbook"]/div/div[1]/span/button
    # Input Text    id=new-address-name    กิตติพงศ์
    # Input Text    id=new-address-lastname    วัฒนชัย
    # Input Text    id=new-address-mobile    0811034067
    # Input Text    id=new-address-addrno    89/12
    # Input Text    id=new-address-moo    9
    # Select From List By Label    id=new-address-province    ปทุมธานี
    # Wait Until Element Contains    id=select2-new-address-province-container    ปทุมธานี
    # Select From List By Label    id=new-address-district    ลำลูกกา
    # Wait Until Element Contains    id=select2-new-address-district-container    ลำลูกกา
    # Select From List By Label    id=new-address-sub-district    ลำลูกกา
    # Wait Until Element Contains    id=select2-new-address-sub-district-container    ลำลูกกา   
    Wait Until Element Contains    id=formatted-location    2 ตำบล บึงคำพร้อย อำเภอลำลูกกา ปทุมธานี 12150 ประเทศไทย
    Click Element    id=selected-location
    Wait Until Element Contains    id=conf-dif-addr     ยืนยันตามที่อยู่ที่กรอกไว้
    Click Element    id=conf-dif-addr
    # Element Attribute Value Should Be    id=new-address-postal-code    value    12150
    Scroll Element Into View    id=continue-payment-btn            
    Wait Until Element Is Visible    id=continue-payment-btn
    Click Element    id=continue-payment-btn
ชำระเงินด้วยทรูมันนี่วอลเลต และตรวจสอบว่าได้สินค้า 10 ชิ้นในราคา 1190 บาท ค่าจัดส่งฟรี
    Wait Until Page Contains    วิธีการชำระเงิน
    Element Should Contain    //*[@id="stepModel"]/div[1]/div[2]/div[2]/table/tbody[1]/tr[3]/td[3]    10
    Element Should Contain    //*[@id="stepModel"]/div[1]/div[2]/div[2]/table/tbody[1]/tr[3]/td[4]    ฿ 1,190    
    Element Should Contain    //*[@id="js-invoice-details-tbody"]/tr[2]/td[2]/b    ฟรี
    Element Should Contain    id=totalAmount    ฿ 1,190
    Click Element    //*[@id="payment-options"]/div[2]/button
    Sleep    5
    Wait Until Element Contains    id=COUNTERSERVICE_TMW-tab    ใส่เบอร์โทรศัพท์
    Input Text    id=checkoutData.paymentData.trueMoneyMobileNumber    0811034067
    Click Element    //*[@id="stepModel"]/div[1]/div[2]/footer/div/div/button


