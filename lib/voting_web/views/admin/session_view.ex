defmodule VotingWeb.Admin.SessionView do
  use VotingWeb, :view

  def render("session.json", %{admin: admin, access_token: token}) do
    %{
      data: %{
        name: admin.name,
        email: admin.email,
        access_token: token
      }
    }
  end
end
