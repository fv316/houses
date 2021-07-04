defmodule SaltHouses.House do

  alias SaltHouses.House.Data


  def get_points(points) when is_integer(points), do: points
  def get_points(), do: Data.get_all_houses()

end
