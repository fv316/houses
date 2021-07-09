# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SaltHouses.Repo.insert!(%SaltHouses.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias SaltHouses.House.Schemas.{Activity, CompletedActivity, House, Member}
alias SaltHouses.Repo

Repo.insert!(%House{name: "Percivale Team", description: "The brave"})
Repo.insert!(%House{name: "Bedivere Team", description: "The mighty"})
Repo.insert!(%House{name: "Alymere Team", description: "The sly"})
Repo.insert!(%House{name: "Galahad Team", description: "The evil"})

member =
  Repo.insert!(%Member{name: "Francisco Correia", date_of_birth: ~D"2000-12-12", house_id: 1})

member_2 = Repo.insert!(%Member{name: "Denna Torra", date_of_birth: ~D"2000-02-12", house_id: 2})

activity =
  Repo.insert!(%Activity{
    name: "House points",
    description: "Build the house system",
    form: %{"language" => "string"},
    points: 10
  })

Repo.insert!(%CompletedActivity{
  member_id: member.id,
  activity_id: activity.id,
  form: %{"language" => "Elixir"}
})

Repo.insert!(%CompletedActivity{
  member_id: member.id,
  activity_id: activity.id,
  form: %{"language" => "F#"}
})

Repo.insert!(%CompletedActivity{
  member_id: member_2.id,
  activity_id: activity.id,
  form: %{"language" => "Go"}
})
