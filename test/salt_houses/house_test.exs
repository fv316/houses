defmodule SaltHouses.HouseTest do
  use SaltHouses.DataCase

  alias SaltHouses.House

  describe "activities" do
    alias SaltHouses.House.Activity

    @valid_attrs %{
      active: true,
      description: "some description",
      form: %{},
      id: "7488a646-e31f-11e4-aace-600308960662",
      name: "some name",
      points: 42
    }
    @update_attrs %{
      active: false,
      description: "some updated description",
      form: %{},
      id: "7488a646-e31f-11e4-aace-600308960668",
      name: "some updated name",
      points: 43
    }
    @invalid_attrs %{active: nil, description: nil, form: nil, id: nil, name: nil, points: nil}

    def activity_fixture(attrs \\ %{}) do
      {:ok, activity} =
        attrs
        |> Enum.into(@valid_attrs)
        |> House.create_activity()

      activity
    end

    test "list_activities/0 returns all activities" do
      activity = activity_fixture()
      assert House.list_activities() == [activity]
    end

    test "get_activity!/1 returns the activity with given id" do
      activity = activity_fixture()
      assert House.get_activity!(activity.id) == activity
    end

    test "create_activity/1 with valid data creates a activity" do
      assert {:ok, %Activity{} = activity} = House.create_activity(@valid_attrs)
      assert activity.active == true
      assert activity.description == "some description"
      assert activity.form == %{}
      assert activity.id == "7488a646-e31f-11e4-aace-600308960662"
      assert activity.name == "some name"
      assert activity.points == 42
    end

    test "create_activity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = House.create_activity(@invalid_attrs)
    end

    test "update_activity/2 with valid data updates the activity" do
      activity = activity_fixture()
      assert {:ok, %Activity{} = activity} = House.update_activity(activity, @update_attrs)
      assert activity.active == false
      assert activity.description == "some updated description"
      assert activity.form == %{}
      assert activity.id == "7488a646-e31f-11e4-aace-600308960668"
      assert activity.name == "some updated name"
      assert activity.points == 43
    end

    test "update_activity/2 with invalid data returns error changeset" do
      activity = activity_fixture()
      assert {:error, %Ecto.Changeset{}} = House.update_activity(activity, @invalid_attrs)
      assert activity == House.get_activity!(activity.id)
    end

    test "delete_activity/1 deletes the activity" do
      activity = activity_fixture()
      assert {:ok, %Activity{}} = House.delete_activity(activity)
      assert_raise Ecto.NoResultsError, fn -> House.get_activity!(activity.id) end
    end

    test "change_activity/1 returns a activity changeset" do
      activity = activity_fixture()
      assert %Ecto.Changeset{} = House.change_activity(activity)
    end
  end
end
