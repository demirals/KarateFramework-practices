Feature: exchange rate api tests
# api calismiyor web sayfasinda

  Scenario: basic test with status code validation
    Given url 'https://api.exchangeratesapi.io/latest'
    When method GET
    Then status 200


  Scenario: basic test with status code validation historical
    Given url 'https://api.exchangeratesapi.io/2010-01-12
    When method GET
    Then status 200

  Scenario: header verification
    Given url 'https://api.exchangeratesapi.io/2010-01-12
    When method GET
    Then status 200
    And match header Content-Type == 'application/json'
    And match header Vary == 'Accept-Encoding'
    And match header Connection == 'keep-alive'
    #to verify headers we use header keyword then headername without double or single code
    # and == 'header value'
    And match header Date == '#present'
    #this equals to headers().hasHeaderWithName("headername") in restassured

  Scenario: json body verification
    Given url 'https://api.exchangeratesapi.io/2010-01-12
    When method GET
    Then status 200
    And match header Content-Type == 'application-json'
    And print response
    And print response.base
    #verify base is euro
    And match response.base == 'EUR'
    #existing of rates USD
    And print response.rates
    And print response.rates.USD
    And match response.rates.USD == '#present'
    And match response.rates.USD == 1.4481















