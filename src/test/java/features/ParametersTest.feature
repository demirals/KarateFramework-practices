Feature: Paraeters examples

  Background:
    * def baseUrl = 'https://api.exchangeratesapi.io'
    * def spartanUrl = 'http://54.92.248.102:8000'
    * def hrUrl = 'http://54.92.248.102:1000/ords/hr'


Scenario: path parameters
  Given url baseUrl
  And path "latest"
  #buraya mutlaka / koyman gerekmez kendisi görür
  When method GET
  Then status 200

  Scenario: path parameters
    Given url baseUrl
    And path "2010-01-12"
    When method GET
    Then status 200


  Scenario: get all spartans with path
      Given url spartanUrl
      And path "api/spartans"
      And path "20"
      When method get
      Then status 200
      And print response
      And match response == {"gender": "Male", "phone": 7551551687, "name": "Lothario", "id": 20}

  Scenario: get all spartans with path
    * def expectedSpartan =
    """
    {
    "gender": "Male",
    "phone": 7551551687,
    "name": "Lothario",
    "id": 20
    }
    """
    Given url spartanUrl
    And path "api/spartans"
    And path "20"
    When method get
    Then status 200
    And print response
    And match response == expectedSpartan

  Scenario:  query parameters
    Given url spartanUrl
    And path "api/spartans/search"
    And param nameContains = 'j'
    And param gender = 'Female'
    When method GET
    Then status 200
    And match header Content-Type == 'application/json'
    And print response
                                                            #bu satir calismiyor
 #   And match response.pageable.pageNumber == 0
     #verify each content has gender = Female
    And match each response.content contains {"gender":"Female"}
      #second way of iteration
    And match each response.content[*].gender == 'Female'
    And match response.content[0].name == 'Jaimie'
      #verify each content phone is number
    And match each response.content[*].phone == '#number'

    Scenario: hr regions example
      Given url hrUrl
      And path 'regions'
      When method GET
      Then status 200
      And print response
      And match response.limit == 25
      And print each response.items[*].links
      And match each response.items[*].region_id == '#number'




