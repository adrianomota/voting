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
end
