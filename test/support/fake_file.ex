defmodule Voting.FakeFile do
  @moduledoc false

  def stat("/users/adrianomota/pictures/voting.jpeg") do
    {:ok, %{size: 6_000_000}}
  end

  def stat(_file_path) do
    {:ok, %{size: 1_000_000}}
  end
end
