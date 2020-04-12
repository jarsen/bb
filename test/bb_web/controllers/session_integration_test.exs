defmodule BBWeb.SessionIntegrationTest do
  use BBWeb.IntegrationCase
  alias BB.Accounts

  test "a registered user can log in and log out", %{conn: conn} do
    {:ok, user} =
      Accounts.register_user(%{email: "bill@microsoft.com", password: "Sup3rP4$$w0rd"})

    get(conn, "/")
    |> follow_redirect()
    |> assert_response(status: 200, path: Routes.user_session_path(conn, :new))
    |> follow_form(%{user: Map.take(user, [:email, :password])})
    |> assert_response(status: 200, path: Routes.page_path(conn, :index))
    |> follow_link("Sign out", method: :delete)
    |> assert_response(status: 200, path: Routes.user_session_path(conn, :new))
  end
end
