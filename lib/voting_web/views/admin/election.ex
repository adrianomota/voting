defmodule VotingWeb.Admin.ElectionView do
  use VotingWeb, :view

  def render("index.json", %{elections: elections}) do
    Enum.map(elections, &election_json/1)
  end

  def render("election.json", %{election: election}) do
    %{
      data: %{
        id: election.id,
        name: election.name,
        cover: election.cover,
        notice: election.notice,
        starts_at: election.starts_at,
        ends_at: election.ends_at
      }
    }
  end

  defp election_json(election) do
    %{
      id: election.id,
      name: election.name,
      cover: election.cover,
      notice: election.notice,
      starts_at: election.starts_at,
      ends_at: election.ends_at
    }
  end
end
