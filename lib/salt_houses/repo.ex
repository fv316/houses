defmodule SaltHouses.Repo do
  use Ecto.Repo,
    otp_app: :salt_houses,
    adapter: Ecto.Adapters.Postgres
end
