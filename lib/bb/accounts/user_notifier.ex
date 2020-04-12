defmodule BB.Accounts.UserNotifier do
  def deliver_confirmation_instructions(user, url) do
    IO.puts("""

    ==============================

    Hi #{user.email},

    You can confirm your account by visiting the url below:

    #{url}

    If you didn't create an account with us, please ignore this.

    ==============================
    """)
  end
end
