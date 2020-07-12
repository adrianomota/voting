defmodule Voting.SignInAdmin do
  @moduledoc """
  Signing in as admin
  """
  alias Voting.{Admin, Repo}

  def run(email, password) do
    case Repo.get_by(Admin, email: email) do
      %Admin{} = admin -> verify_password(admin, password)
      nil -> {:error, :email_or_password_invalid}
    end
  end

  defp verify_password(nil, _) do
    Bcrypt.no_user_verify()
    {:error, :email_or_password_invalid}
  end

  defp verify_password(admin, password) do
    case Bcrypt.verify_pass(password, admin.password_hash) do
      true -> {:ok, admin}
      false -> {:error, :email_or_password_invalid}
    end
  end
end
