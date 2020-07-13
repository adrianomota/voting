defmodule Voting.CreateElectionTest do
  use Voting.DataCase, async: true

  import Voting.Factory

  alias Voting.{CreateElection, Election}

  describe "run/1" do
    test "returns a struct when the params are valid" do
      admin = insert(:admin)

      params = %{
        name: "foo",
        cover: "image_url",
        notice: "pdf_file",
        starts_at: ~U[2020-02-11 11:00:00Z],
        ends_at: ~U[2020-02-29 20:59:00Z],
        created_by_id: admin.id
      }

      assert {:ok, %Election{} = election} = CreateElection.run(params)
      assert election.name == "foo"
      assert election.cover == "image_url"
      assert election.notice == "pdf_file"
      assert election.starts_at == ~U[2020-02-11 11:00:00Z]
      assert election.ends_at == ~U[2020-02-29 20:59:00Z]
      assert election.created_by_id == admin.id
    end

    test "returns error when name is missing" do
      admin = insert(:admin)

      params = %{
        name: "",
        cover: "image_url",
        notice: "pdf_file",
        starts_at: ~U[2020-02-11 11:00:00Z],
        ends_at: ~U[2020-02-29 20:59:00Z],
        created_by_id: admin.id
      }

      assert {:error, %Ecto.Changeset{} = changeset} = CreateElection.run(params)
      %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when starts_at is missing" do
      admin = insert(:admin)

      params = %{
        name: "foo",
        cover: "image_url",
        notice: "pdf_file",
        starts_at: nil,
        ends_at: ~U[2020-02-29 20:59:00Z],
        created_by_id: admin.id
      }

      assert {:error, %Ecto.Changeset{} = changeset} = CreateElection.run(params)
      %{starts_at: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when ends_at is missing" do
      admin = insert(:admin)

      params = %{
        name: "foo",
        cover: "image_url",
        notice: "pdf_file",
        starts_at: ~U[2020-02-11 11:00:00Z],
        ends_at: nil,
        created_by_id: admin.id
      }

      assert {:error, %Ecto.Changeset{} = changeset} = CreateElection.run(params)
      %{ends_at: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when created_by is invalid" do
      params = %{
        name: "foo",
        cover: "image_url",
        notice: "pdf_file",
        starts_at: ~U[2020-02-11 11:00:00Z],
        ends_at: ~U[2020-02-29 20:59:00Z],
        created_by_id: 99
      }

      assert {:error, %Ecto.Changeset{} = changeset} = CreateElection.run(params)
      %{created_by_id: ["is invalid"]} = errors_on(changeset)
    end

    test "returns error when starts_at is greater than ends_at" do
      admin = insert(:admin)

      params = %{
        name: "Foo",
        cover: "url",
        notice: "url",
        starts_at: ~U[2020-03-01 11:00:00Z],
        ends_at: ~U[2020-02-29 20:59:59Z],
        created_by_id: admin.id
      }

      assert {:error, %Ecto.Changeset{} = changeset} = CreateElection.run(params)
      %{starts_at: ["should be before ends_at"]} = errors_on(changeset)
    end
  end
end
