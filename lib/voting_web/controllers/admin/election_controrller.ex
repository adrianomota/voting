defmodule VotingWeb.Admin.ElectionController do
  use VotingWeb, :controller

  alias Voting.CreateElection
  alias VotingWeb.Guardian.Plug, as: GuardianPlug

  def index(conn, _params) do
    elections = ListElections.run()
    render(conn, "index.json", %{elections: elections})
  end

  @spec create(
          Plug.Conn.t(),
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Plug.Conn.t()

  def create(conn, params) do
    admin = GuardianPlug.current_resource(conn)
    params = Map.put(params, "created_by_id", admin.id)

    case CreateElection.run(params) do
      {:ok, election} ->
        conn
        |> put_status(201)
        |> render("election.json", %{election: election})

      {:error, _} ->
        conn
        |> put_status(422)
        |> json(%{status: "unprocessable entity"})
    end
  end

  def update(conn, %{"id" => election_id} = params) do
    election = ElectionRepo.get_election!(election_id)

    case UpdateElection.run(election, params) do
      {:ok, election} ->
        render(conn, "election.json", %{election: election})

      {:error, _} ->
        conn
        |> put_status(422)
        |> json(%{status: "unprocessable entity"})
    end
  end
end
