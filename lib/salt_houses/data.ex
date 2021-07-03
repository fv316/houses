defmodule SaltHouses.House.Data do
  alias SaltHouses.Repo
  alias SaltHouses.House.Schemas.House

  def get_house_count() do
    case Repo.all(House) |> length do
      0 -> {:error, :no_houses}
      n -> {:ok, n}
    end
  end
end
