defmodule Voting.Factory do
  @moduledoc """
  Ex-machina Factory
  """
  # with Ecto
  use ExMachina.Ecto, repo: Voting.Repo

  alias Voting.Admin

  def admin_factory do
    %Admin{
      name: "Jane Smith",
      email: "email@example.com",
      password_hash: Bcrypt.hash_pwd_salt("123456")
    }
  end
end
