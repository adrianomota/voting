defmodule VotingWeb.Admin.ElectionViewTest do
  use ExUnit.Case, async: true

  import Voting.Factory

  alias VotingWeb.Admin.ElectionView

  test "render/2 returns ok and the admin data" do
    election = build(:election, id: 1)

    assert %{
             data: %{
               id: 1,
               name: "Election 2020",
               cover: "image url",
               notice: "pdf file",
               starts_at: ~U[2020-02-11 11:00:00Z],
               ends_at: ~U[2020-02-29 20:59:00Z]
             }
           } = ElectionView.render("election.json", %{election: election})
  end
end
