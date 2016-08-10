Feature: Using a password to obtain the API key

  Roles which have passwords can use the `login` method to obtain their API key.
  The API key is then used to authenticate and receive an auth token.

  Background:
    Given a new user "alice"

  Scenario: Password can be used to obtain API key
    Given I set the password for "alice" to "my-password"
    Then I can GET "/authn/:account/login" with username "alice@:user_namespace" and password "my-password"
    Then the result is the API key for user "alice"

  @logged-in
  Scenario: Bearer token cannot be used to login

    The login method requires the password; login cannot be performed using the auth token
    as a credential.

    When I GET "/authn/:account/login"
    Then it's not authenticated

  @logged-in-admin
  Scenario: "Super" users cannot login as other users

    Users can never login as other users.

    When I GET "/authn/:account/login?role=user:alice@@user_namespace@"
    Then it's not authenticated
