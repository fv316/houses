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

alias SaltHouses.Houses.Schemas.{Activity, House}
alias SaltHouses.Repo

Repo.insert!(%House{name: "Percivale Team"})
Repo.insert!(%House{name: "Bedivere Team"})
Repo.insert!(%House{name: "Alymere Team"})
Repo.insert!(%House{name: "Galahad Team"})

Repo.insert!(%Activity{name: "House building",description: "Build the housing application",points: 10})
