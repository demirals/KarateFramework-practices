Feature: get user token

  # api den bilgi cekme

  Scenario: get one user token
    Given url 'https://cybertek-reservation-api-qa3.herokuapp.com'
    And path 'sign'
    And header Accept = 'application/json'
    And param email = 'mcossor8l@webmd.com'
    And param password = 'cecilnacey'
    When method GET
    Then status 200
    And print response.accessToken
    And def token = response.accessToken
    
