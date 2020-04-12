defmodule BBWeb.UserRegistrationController do
  use BBWeb, :controller
  alias BBWeb.UserAuth
  alias BB.Accounts
  alias BB.Accounts.User

  def new(conn, _params) do
    changeset = Accounts.registration_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> UserAuth.log_user_in(user)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
