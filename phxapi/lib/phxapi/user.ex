defmodule Phxapi.User do
  def create("ok") do
    {:ok,
     %{
       firstname: "abe",
       lastname: "eba",
       age: 19,
       socials: %{github: "abehidek"}
     }}
  end

  def create("error") do
    {:error, "Error while creating music"}
  end
end
