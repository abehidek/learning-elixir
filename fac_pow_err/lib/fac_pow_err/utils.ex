defmodule FacPowErr.Utils do
  use Rustler, otp_app: :fac_pow_err, crate: "facpowerr_utils"

  def add(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
  def raise_error(), do: :erlang.nif_error(:nif_not_loaded)

  def factorial(_a, _b \\ 1)
  def factorial(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
  def power(_a), do: :erlang.nif_error(:nif_not_loaded)
  def thread_sleep(), do: :erlang.nif_error(:nif_not_loaded)
end
