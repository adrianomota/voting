defmodule VotingWeb.Admin.SessionControllerTest do
  use VotingWeb.ConnCase, async: true

  import Voting.Factory

  describe "create/2" do
    setup %{conn: conn} do
      insert(:admin,
        name: "Adriano Mota",
        email: "adrianowsh@gmail.com"
      )

      %{conn: conn}
    end

    test "returns 200 when admin credenrials are valid", %{conn: conn} do
      conn =
        post(conn, "/api/v1/admin/sign_in", %{
          "email" => "adrianowsh@gmail.com",
          "password" => "123456"
        })

      assert %{
               "data" => %{
                 "name" => "Adriano Mota",
                 "email" => "adrianowsh@gmail.com",
                 "access_token" => _
               }
             } = json_response(conn, 200)
    end

    test "returns 401 when admin credentials are invalid", %{conn: conn} do
      conn =
        post(conn, "/api/v1/admin/sign_in", %{
          "email" => "adrianowsh@gmail.com",
          "password" => "12345"
        })

      assert %{"status" => "unauthorized"} = json_response(conn, 401)
    end

    test "return 201 when created a admin", %{conn: conn} do
      conn =
        post(conn, "/api/v1/admin/sign_up", %{
          "admin" => %{
            "name" => "Foo",
            "email" => "foo@gmail.com",
            "password" => "123456"
          }
        })

      assert %{
               "status" => "created"
             } = json_response(conn, 201)
    end
  end
end
