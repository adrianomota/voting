defmodule VotingWeb.Admin.SessionController do
  use VotingWeb, :controller

  alias Voting.{SignInAdmin}
  alias VotingWeb.Guardian

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case SignInAdmin.run(email, password) do
      {:ok, admin} ->
        {:ok, token, _claims} = Guardian.encode_and_sign(admin)

        conn
        |> render("session.json", %{admin: admin, access_token: token})

      {:error, _} ->
        conn
        |> put_status(401)
        |> json(%{status: "unauthorized"})
    end
  end
end
