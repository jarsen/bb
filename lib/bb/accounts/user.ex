defmodule BB.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :confirmed_at, :naive_datetime
    field :email, :string
    field :encrypted_password, :string
    has_many :tokens, BB.Accounts.UserToken, foreign_key: :user_id

    field :password, :string, virtual: true

    timestamps()
  end

  @doc """
  Confirms the account by setting `confirmed_at`.
  """
  def confirm_changeset(user) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
    change(user, confirmed_at: now)
  end

  @doc false
  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_format(:email, "@")
    |> validate_length(:email, max: 240)
    |> validate_length(:password, min: 12, max: 80)
    |> validate_format(:password, ~r/[a-z]/, message: "at least one lower case character")
    |> validate_format(:password, ~r/[A-Z]/, message: "at least one upper case character")
    |> validate_format(:password, ~r/[!?@#$%^&*_0-9]/,
      message: "at least one digit or punctuation character"
    )
    |> unsafe_validate_unique(:email, BB.Repo)
    |> maybe_encrypt_password()
    |> unique_constraint(:email)
  end

  defp maybe_encrypt_password(changeset) do
    password = get_change(changeset, :password)

    if password && changeset.valid? do
      put_change(changeset, :encrypted_password, Bcrypt.hash_pwd_salt(password))
    else
      changeset
    end
  end

  def valid_password?(%BB.Accounts.User{encrypted_password: encrypted_password}, password)
      when is_binary(password) do
    Bcrypt.verify_pass(password, encrypted_password)
  end

  def valid_password?(_) do
    Bcrypt.no_user_verify()
  end
end
