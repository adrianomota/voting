defmodule VotingWeb.Admin.ElectionControllerTest do
  use VotingWeb.ConnCase, async: true

  import VotingWeb.AdminAuth

  describe "create/2" do
    setup %{conn: conn} do
      conn = authenticated(conn)
      %{conn: conn}
    end

    test "returns 201 when election is created successfully", %{conn, conn} do
      params = %{
        "name" => "Eleicoes 2020",
        "cover" => "img-url",
        "notice" => "pdf_url",
        "starts_at" => "2020-07-13T08:00:00.080Z",
        "ends_at" => "2020-10-13T22:23:59.080Z"
      }

      conn = post(conn, "/api/v1/lelections", params)

      expected =
        assert %{
                 "data" => %{
                   "name" => "Eleicoes 2020",
                   "cover" => "img-url",
                   "notice" => "pdf_url",
                   "starts_at" => "2020-07-13T08:00:00.080Z",
                   "ends_at" => "2020-10-13T22:23:59.080Z"
                 }
               } = json_response(conn, 201)
    end

    test "returns 422 when election is created successfully", %{conn, conn} do
      params = %{
        "name" => "Eleicoes 2020",
        "cover" => "img-url",
        "notice" => "pdf_url",
        "starts_at" => "2020-07-13T08:00:00.080Z",
        "ends_at" => "2020-10-13T22:23:59.080Z"
      }

      conn = post(conn, "/api/v1/lelections", params)

      expected = assert %{"status" => "unprocessable entity"} = json_response(conn, 422)
    end
  end

  describe "update/2" do
    test "returns 200 when election is updated successfully", %{conn: conn} do
      election = insert(:election)
      params = %{"name" => "Election 2020"}

      conn = put(conn, "/api/v1/elections/#{election.id}", params)

      assert %{"status" => "ok", "data" => %{"name" => "Election 2020"}} =
               json_response(conn, 200)
    end

    test "returns 422 when params are invalid", %{conn: conn} do
      election = insert(:election)
      params = %{"name" => ""}

      conn = put(conn, "/api/v1/elections/#{election.id}", params)
      assert %{"status" => "unprocessable entity"} = json_response(conn, 422)
    end
  end
end
