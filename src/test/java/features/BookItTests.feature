Feature: Bookit Api tests

  Background:
    * def baseUrl = 'https://cybertek-reservation-api-qa3.herokuapp.com'
    # point another feature file
    * def AuthFeature = call read('classpath:features/BookItAuth.feature')
    * def accessToken = AuthFeature.token
    * print 'Token from Background', accessToken


    Scenario: get user information
      Given url baseUrl
      And path 'api/users/me'
      And header Authorization = 'Bearer ' + accessToken
      And header Accept = 'application/json'
      When method GET
      Then status 200
      And print response
      #json to json compare
      And match response == {"id":93,"firstName":"Cecil","lastName":"Nacey","role":"student-team-leader"}


  Scenario: get campus information
    Given url baseUrl
    And path  'api/campuses'
    And header Authorization = 'Bearer ' + accessToken
    And header Accept = 'application/json'
    When method GET
    Then status 200
    And print response
    # burada json kontrol etmek icin data paketi oluzsturuyoruz, cünki
    # cok fazla json bilgisi var, buradaki dosyaya koyuyoruz bilgileri elle

    # read the campuses.json file in the data directory
    And def expectedCampuses = read ('classpath:data/campuses.json')
    And match response == expectedCampuses



