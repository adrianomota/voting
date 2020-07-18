defmodule VotingWeb.Admin.SessionController do
  use VotingWeb, :controller

  alias Voting.{CreateAdmin, SignInAdmin}
  alias VotingWeb.Guardian

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case SignInAdmin.run(email, password) do
      {:ok, admin} ->
        {:ok, token, _claims} = Guardian.encode_and_sign(admin)

        conn
        |> put_status(:ok)
        |> render("session.json", %{admin: admin, access_token: token})

      {:error, _} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{status: :unauthorized})
    end
  end

  def sign_up(conn, %{"admin" => admin}) do
    case CreateAdmin.run(admin) do
      {:ok, _} ->
        conn
        |> put_status(:created)
        |> json(%{status: :created})

      {:error, _} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: "unprocessable Entity"})
    end
  end
end
