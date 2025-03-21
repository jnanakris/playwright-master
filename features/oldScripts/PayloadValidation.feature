Feature: Playwright Payload Validation

    @payload
    Scenario Outline: Validate Homepage

        Given user login to "<url>" with "<user>" credentials
        When User see text "LastName *" in "LastnameValidate" in "Payload" screen
        And User enter text "<Firstname>" in "Firstname" in "Payload" screen
        And User enter text "<Lastname>" in "Lastname" in "Payload" screen
        Then User click on "Submit" "Submit" in "Payload" screen
        When User have text "Success" in "VerifyToastMessage" in "Payload" screen




        Examples:
            | url         | user       | Firstname | Lastname |
            | Payload_Url | sdale_user | scott     | dale     |
