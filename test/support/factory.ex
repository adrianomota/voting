defmodule Voting.Factory do
  @moduledoc """
  Ex-machina Factory
  """
  # with Ecto
  use ExMachina.Ecto, repo: Voting.Repo

  alias Voting.{Admin, Election}

  def admin_factory do
    %Admin{
      name: "Jane Smith",
      email: "email@example.com",
      password_hash: Bcrypt.hash_pwd_salt("123456")
    }
  end

  def election_factory do
    %Election{
      name: "Election 2020",
      cover: "image url",
      notice: "pdf file",
      starts_at: ~U[2020-02-11 11:00:00Z],
      ends_at: ~U[2020-02-29 20:59:00Z],
      created_by: build(:admin)
    }
  end
end
