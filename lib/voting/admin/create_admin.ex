defmodule Voting.CreateAdmin do
  @moduledoc """
  Create a new admin
  """
  import Ecto.Changeset

  alias Voting.{Admin, Repo}

  def run(params) do
    %Admin{}
    |> cast(params, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> unique_constraint(:email)
    |> put_password()
    |> Repo.insert()
  end

  defp put_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_password(changeset) do
    changeset
  end
end
