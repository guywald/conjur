Feature: Checking whether a role has a privilege on a resource.

  An RBAC transaction involves a role, a privilege, and a resource. A permission
  check determines whether a transaction is allowed or not.

  Background:
    Given I create a new resource
    And a new user "bob"
    And I permit user "bob" to "fry" it

  @logged-in
  Scenario: I confirm that the role can perform the granted action

    If a role is granted a privilege on a resource, then a permission check will pass.

    Then I can GET "/roles/:account/user/bob@:user_namespace" with parameters:
    """
    check: true
    resource: "@resource_kind@:@resource_id@"
    privilege: fry
    """

  @logged-in
  Scenario: I confirm that the role cannot perform ungranted actions

    If a role is not granted a privilege, then a permission check will fail.

    When I GET "/roles/:account/user/bob@:user_namespace" with parameters:
    """
    check: true
    resource: "@resource_kind@:@resource_id@"
    privilege: freeze
    """
    Then it's not found

  Scenario: The new role can confirm that it may perform the granted action

    A role which is authenticated can use `check` parameter to determine whether it
    has a privilege on some resource.

    When I login as "bob"
    Then I can GET "/resources/:account/:resource_kind/:resource_id" with parameters:
    """
    check: true
    privilege: fry
    """
