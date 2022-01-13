Feature: Data driven tests

  Scenario Outline: get token for user <email>
    Given url 'https://cybertek-reservation-api-qa3.herokuapp.com/'
    And path 'sign'
    And header Accept = 'application/json'
    And param email = '<email>'
    And param password = '<password>'
    When method GET
    Then status 200
    And print response.accessToken
    And def token = response.accessToken

    Examples:
      | email                     | password   |
      | mcossor8l@webmd.com       | cecilnacey |
      | wamiss8p@businesswire.com | olagrills  |
  #bunu calistiramadim
  # Ancak , data driven test pratik olmadigi icin csv file olusturuyoruz, bilgileri db dan asagidaki nkod ile cekiyoruz
  # bu sadece karatede calisiyor, cucumberde olmazmis  :(((
  # select email, lower(firstname||lastname) from users;


  Scenario Outline: get token for user <email>
    Given url 'https://cybertek-reservation-api-qa3.herokuapp.com/'
    And path 'sign'
    And header Accept = 'application/json'
    And param email = '<email>'
    And param password = '<password>'
    When method GET
    Then status 200
    And print response.accessToken
    And def token = response.accessToken


    Examples:
    |read('data/users.csv')|
    # bu da düzgün calismadi

  Scenario: get user information verification(Database vs API)
    * def DBUtils = Java.type('utilities.DBUtils')
    * def query = "select id, firstname, lastname, role from users where email = 'mcossor8l@webmd.com'"
    * def dbResult = DBUtils.getRowMap(query)
    * print 'DB result ',dbResult
    Given url 'https://cybertek-reservation-api-qa3.herokuapp.com'
    And path 'sign'
    And header Accept = 'application/json'
    And param email = 'mcossor8l@webmd.com'
    And param password = 'cecilnacey'
    When method GET
    Then status 200
    And print response.accessToken
    And def token = response.accessToken
    Given url 'https://cybertek-reservation-api-qa3.herokuapp.com'
    And path 'api/users/me'
    And header Authorization = 'Bearer ' + token
    And header Accept = 'application/json'
    When method GET
    Then status 200
    And print response
    And match response.id == dbResult.id
    And match response.firstName == dbResult.firstname
    And match response.lastName == dbResult.lastname
    And match response.role == dbResult.role

  @wip
  Scenario Outline: get user information verification(Database vs API) <email>
    * def DBUtils = Java.type('utilities.DBUtils')
    * def query = "select id, firstname, lastname, role from users where email = '<email>'"
    * def dbResult = DBUtils.getRowMap(query)
    * print 'DB result ',dbResult
    Given url 'https://cybertek-reservation-api-qa3.herokuapp.com'
    And path 'sign'
    And header Accept = 'application/json'
    And param email = '<email>'
    And param password = '<password>'
    When method GET
    Then status 200
    And print response.accessToken
    And def token = response.accessToken
    Given url 'https://cybertek-reservation-api-qa3.herokuapp.com'
    And path 'api/users/me'
    And header Authorization = 'Bearer ' + token
    And header Accept = 'application/json'
    When method GET
    Then status 200
    And print response
    And match response.id == dbResult.id
    And match response.firstName == dbResult.firstname
    And match response.lastName == dbResult.lastname
    And match response.role == dbResult.role

    Examples:
    |read('data/users.csv')|
    # bu da calismadi lanet







