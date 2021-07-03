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


alias SaltHouses.House.Schemas.{House, Member}
alias SaltHouses.Repo

Repo.insert!(%House{name: "House 1", description: "The brave"})
Repo.insert!(%House{name: "House 2", description: "The mighty"})
Repo.insert!(%House{name: "House 3", description: "The sly"})
Repo.insert!(%House{name: "House 4", description: "The evil"})

Repo.insert!(%Member{name: "Kvothe Correia", date_of_birth: ~D"2000-12-12", house_id: 1})
