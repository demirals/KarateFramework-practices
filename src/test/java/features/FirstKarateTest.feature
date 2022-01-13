Feature:welcome to karate
  
  Scenario: how to print
    Given print "Hello dunyali"
    When print 'another print'
    Then print 'then print'

    Scenario: more printing
      Given print 'some words to print'
      * print 'my name is','karate kid'
      # , -->> concat two strings +1 white space
  * print 2+2


      Scenario: variables
        * def name = 'Mike'
        * print 'my name is' , name
        * print 'my name is' + name
        * def age = 20
        * print name, 'is', age, 'years old'


    Scenario: difficult parameters: json object
      * def student = {'name': 'sam', 'owes_tuition':false}
                                              #yukaridaki aslinda json structure
      * print student
      * print student.name
      * print student.owes_tuition


      Scenario: json object 2
    * def student =
    """
    {
    "firstName":"Stewen",
    "lastName":"King",
    "Salary":2099
    }
    """
    * print student.Salary
    * print student.firstName
    * print student.lastName

    Scenario: spartan Variable
      * def spartan =
      """
      {
    "id": 55,
    "name": "Karmen",
    "gender": "Female",
    "phone": 5052029186
      }
      """
      * print spartan.gender
      * print spartan.phone
      * print spartan.name
      * print spartan.id


      Scenario: json array objects
        * def students =
        """
        [
          {
          'name': 'sam',
          'owes_tuition':false
          },
          {
          'name': 'mike',
          'owes_tuition':false
          }
        ]
        """
        * print students
        * print students[0].name
        * print students[1].owes_tuition

  

  
        
        
        
        
        
        