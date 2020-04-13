defmodule BBWeb.SessionIntegrationTest do
  use BBWeb.IntegrationCase
  alias BB.Accounts

  test "a registered user can log in and log out", %{conn: conn} do
    user_params = %{email: "bill@microsoft.com", password: "Sup3rP4$$w0rd"}
    {:ok, _user} = Accounts.register_user(user_params)

    get(conn, "/users/login")
    |> assert_response(status: 200, path: Routes.user_session_path(conn, :new))
    |> follow_form(%{user: user_params})
    |> assert_response(status: 200, path: Routes.page_path(conn, :index))
    |> follow_link("Log out", method: :delete)
    |> assert_response(status: 200, path: Routes.page_path(conn, :index))
  end
end
