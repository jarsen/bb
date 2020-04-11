defmodule BB.AccountsTest do
  use BB.DataCase

  alias BB.Accounts

  describe "users" do
    alias BB.Accounts.User

    def fixture(:user, attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(%{
          email: "bill@microsoft.com",
          password: "some P4$sword"
        })
        |> Accounts.register_user()

      user
    end

    test "get_user!/1 returns the user with given id" do
      %{id: user_id} = fixture(:user)
      assert %User{id: ^user_id} = Accounts.get_user!(user_id)
    end

    test "get_user/1 returns the user with given id" do
      %{id: user_id} = fixture(:user)
      assert %User{id: ^user_id} = Accounts.get_user(user_id)
      assert nil == Accounts.get_user(12_837_123_123)
    end

    test "get_user_by_email_and_password/2 with a non existing user returns nil" do
      assert nil == Accounts.get_user_by_email_and_password("ghost@boo.confirmed_at", "scary")
    end

    test "get_user_by_email_and_password/2 with an incorrect password returns nil" do
      user = fixture(:user)
      assert nil == Accounts.get_user_by_email_and_password(user.email, "wrong password")
    end

    test "get_user_by_email_and_password/2 with an correct credentials returns user" do
      user = fixture(:user)
      user_id = user.id

      assert %User{id: ^user_id} =
               Accounts.get_user_by_email_and_password(user.email, user.password)
    end

    test "register_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} =
               Accounts.register_user(%{email: "bill@microsoft.com", password: "S3cureP4$$w0rD"})

      assert user.email == "bill@microsoft.com"
      assert user.encrypted_password != nil
    end

    test "register_user/1 with invalid email returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.register_user(%{email: "not an email"})
    end

    test "register_user/1 with invalid password returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Accounts.register_user(%{email: "bill@microsoft.com", password: "dolphins"})
    end

    test "register_user/1 ensures email is unique" do
      user = fixture(:user)

      assert {:error, %Ecto.Changeset{}} =
               Accounts.register_user(%{email: user.email, password: user.password <> "2"})
    end

    test "registration_user/1 returns a user changeset" do
      user = fixture(:user)
      assert %Ecto.Changeset{} = Accounts.registration_user(user)
    end
  end
end
