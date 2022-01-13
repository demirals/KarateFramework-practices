Feature: Karate Java Integration

  Background:
    * def spartanUrl = 'http://54.92.248.102:8000'

    Scenario: Get a spartan with request header
    Given url spartanUrl
    And path "api/spartans"
    And header Accept = 'application/json'
    When method GET
    Then status 200

  Scenario: Create a new spartan
    Given url spartanUrl
    And path "api/spartans"
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And request
    """
    {
     "gender": "Female",
     "name": "Lorenza",
     "phone": 3123781237
    }
    """
    When method POST
    Then status 201
    And print response

    # java faker kullanacagiz (utils icinde)
    # acayip güzel bir olay

    Scenario: reading java methods
      #point the class we want to run
      #Java.type --> used to connect to java class
      * def SDG = Java.type('utilities.SpartanDataGenerator')
      * def newSpartan = SDG.createSpartan()
      #run the static method in that class and capture the result
      #the return map object is represented as a json
      * print newSpartan


      Scenario: Create a spartan with random data (JAVA) (POST method) an delete it (DELETE)
        * def SDG = Java.type('utilities.SpartanDataGenerator')
        * def newSpartan = SDG.createSpartan()
        Given url spartanUrl
        And path "api/spartans"
        And header Accept = 'application/json'
        And header Content-Type = 'application/json'
        And request newSpartan
        When method POST
        Then status 201
        And print response
        And match response.success == 'A Spartan is Born!'
    # verify names
        And match response.data.name == newSpartan.name
    # how to delete ?
        And def idToDelete = response.data.id
        Given url spartanUrl
        And path 'api/spartans' ,idToDelete
        When method DELETE
        Then status 204

    #############log kayitlarindan kurtulmak icin logback-java.xml dosyasini ekledim







