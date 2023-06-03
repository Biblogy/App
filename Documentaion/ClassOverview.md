Challenges --> NewChallengePage
Challenges --> ChallengePage
Challenges --> IntervallPageOverview
Challenges --> ChallengeOverviewModell
Challenges --> CalcIntervallPage


```mermaid
classDiagram
    App --> Challenges 
    App --> BookManagement 
    App --> BooerCalender

    Challenges --> 0_DatabaseConnect
    Challenges --> 1_Modell
    Challenges --> 2_Services
    2_Services --> CalcProgress 
    CalcProgress --> CalcIntervallPage


    
    Challenges --> CallengePage

```


Animal <|-- Duck
    note for Duck "can fly\ncan swim\ncan dive\ncan help in debugging"
    Animal <|-- Fish
    Animal <|-- Zebra
    Animal : +int age
    Animal : +String gender
    Animal: +isMammal()
    Animal: +mate()
    class Duck{
        +String beakColor
        +swim()
        +quack()
    }
    class Fish{
        -int sizeInFeet
        -canEat()
    }
    class Zebra{
        +bool is_wild
        +run()
    }