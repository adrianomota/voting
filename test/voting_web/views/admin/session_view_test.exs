defmodule VotingWeb.Admin.SessionViewTest do
  use ExUnit.Case, async: true

  import Voting.Factory

  alias VotingWeb.Admin.SessionView

  test "render/2 returns ok and the admin data" do
    admin = params_for(:admin, name: "Adriano Mota")

    assert %{data: %{name: "Adriano Mota", email: "email@example.com", access_token: "foo"}} =
             SessionView.render("session.json", %{
               admin: admin,
               access_token: "foo"
             })
  end
end
