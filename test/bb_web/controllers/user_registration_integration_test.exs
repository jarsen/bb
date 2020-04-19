defmodule BBWeb.UserRegistrationIntegrationTest do
  use BBWeb.IntegrationCase

  test "can create a user with valid credentials", %{conn: conn} do
    get(conn, Routes.user_registration_path(conn, :new))
    |> follow_form(%{
      user: %{
        name: "Bill Gates",
        email: "bill@microsoft.com",
        password: "some P4$sword"
        # confirm_password: "some P4$sword"
      }
    })
    |> assert_response(
      status: 200,
      path: Routes.page_path(conn, :index)
    )
  end

  test "validates form", %{conn: conn} do
    get(conn, Routes.user_registration_path(conn, :new))
    |> follow_form(%{
      user: %{
        name: "Bill Gates",
        email: "not an email",
        password: "some P4$sword"
        # confirm_password: "some P4$sword"
      }
    })
    |> assert_response(
      status: 200,
      path: Routes.user_registration_path(conn, :new)
    )
  end
end
