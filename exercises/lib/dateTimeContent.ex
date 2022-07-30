defmodule DateTimeContent do
  @moduledoc """
  Elixir has some modules that help us to work with time.
  """

  # Time

  def get_time_now, do: Time.utc_now()

  # we also have a sigil that can be used to create Time struct as well.
  def time_sigil, do: ~T[21:41:03.030422]
  # you can access its atribute using:
  # time_sigil.hour
  # time_sigil.minute
  # time_sigil.second
  # time_sigil.microsecond

  # however, using time_sigil.day will not work because it only contains the time within a day

  # Date
  def get_date_now, do: Date.utc_today()

  # it's sigil is created using ~D
  # ~D/2028-10-21/
  # it has some interesting functions to work with it

  def date_functions do
    {:ok, date} = Date.new(2002, 12, 31) |> IO.inspect()
    Date.day_of_week(date) |> IO.inspect()
    Date.leap_year?(date) |> IO.inspect()
    :ok
  end

  # NaiveDateTime
  # There are only two structs that contain both time and date, the firt one is NaiveDateTime, it's disavantage is the lack of timezone support

  def get_naive_date_time, do: NaiveDateTime.utc_now()
  # it's sigil is created using a ~N
  # ~N[2022-01-21 19:55:10.008965]
  # it has both time and date, so you can perform aritmetic operations of time on it:
  def naive_date_time_functions do
    get_naive_date_time() |> NaiveDateTime.add(30)
  end

  # DateTime
  # has no limitations, have time, date and timezones, however as official docs states:

  # " Many functions in this module require a time zone database. By default, it uses the default time zone database returned by Calendar.get_time_zone_database/0, which defaults to Calendar.UTCOnlyTimeZoneDatabase which only handles “Etc/UTC” datetimes and returns {:error, :utc_only_time_zone_database} for any other time zone. "

  # so must be aware of using that

  # you can create a DateTime instance from a NaiveDateTime, just providing the timezone
  def date_time do
    DateTime.from_naive!(~N/2016-05-24 13:26:08.003/, "Europe/Paris", Tz.TimeZoneDatabase)
    |> IO.inspect(label: "before")
    |> DateTime.shift_zone("America/New_York", Tz.TimeZoneDatabase)
    |> IO.inspect(label: "after")

    # a interesting fact about inspect is that it returns the value it's inspecting, that way you can reuse then in the transformations of data like above

    DateTime.now("America/Sao_Paulo", Tz.TimeZoneDatabase) |> IO.inspect()

    # working with timezones:
    # as you noticed before on the previous section, by default Elixir doesnt have any timezones data, to solve this issue, you can install the tzdata package. After installing it, you should configure globally to use tzdata as a timezone databases.

    # other powerful libs to consider is timex and Calendar, which provides more powerful tools to deal with time

    :ok
  end
end
