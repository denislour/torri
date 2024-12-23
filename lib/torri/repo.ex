defmodule Torri.Repo do
  use Ecto.Repo,
    otp_app: :torri,
    adapter: Ecto.Adapters.SQLite3
end
