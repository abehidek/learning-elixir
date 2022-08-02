defmodule ErrorContent do
  # even tho it's more common to return the tuple {:error, reason}, Elixir supports exceptions, here you will learn how to handle errors and different mechanisms available to us.

  # In general, the convention is to create a function which returns {:ok, result} and {:error, reason}, and another function that returns the unwrapped result or raises an error. Here we will do the latter.

  # Error that are part of the regular operation of a function (eg a user has entered wrong type of date), a function returns {:ok, result} and {:error, reason} accordingly

  # Errors that are not part of the regular operation of the function throw an exception.

  # We generally handle standards flow erros with pattern matching, but now we are focusing on the second case (on exceptions).

  def raise_error do
    raise "Oh no!"
  end

  def raise_error_with_types do
    raise ArgumentError, message: "the argument is invalid"
  end

  # as an error occurs, we can handle it using try/rescue and pattern matching
  def handle_error do
    try do
      raise_error()
    rescue
      e in RuntimeError -> IO.puts("An error has occured: #{e.message}")
    end
  end

  # its possible to match multiple errors in one single rescue:
  def handle_multiple_errors do
    try do
      Inspect.opts()
      |> Keyword.fetch!(:source_file)
      |> File.read!()
    rescue
      e in KeyError -> IO.puts("missing :source_file option")
      e in File.Error -> IO.puts("unable to read source file")
    end
  end

  # After: at times, it may be necessary to perform some action after or try/rescue regardless of the error. For this we have try/after.
  def after_error do
    try do
      raise "Oh no!"
    rescue
      e in RuntimeError -> IO.puts("Error: #{e.message}")
    after
      IO.puts("The end")
    end
  end

  # this is more commonly used with files or connections that should be closed:
  def open_file do
    {:ok, file} = File.open("example.json")

    try do
      # hazardous work
    after
      File.close(file)
    end
  end

  # Creating new errors
  # Elixir already includes a number of builtin error types like RuntimeError, however you can create your custom error type too.
  # to create a new error, you can use defexception/1 macro, which accepts the :message option to set a default error message.

  defmodule ExampleError do
    defexception message: "An example error has occured."
  end

  def example_error do
    try do
      raise ExampleError
    rescue
      e in ExampleError -> e
    end
  end

  # Throw
  # another mechanism for working with errors is throw and catch. In practice, these occur infrequently in newer Elixir code, but its important to know and understand them nonetheless.
  # the throw/1 function give us the ability to exit execution with a specific value we can catch and use

  def throw_error do
    try do
      for x <- 0..10 do
        if x == 5, do: throw(x)
        IO.puts(x)
      end
    catch
      x -> "Caught: #{x}"
    end
  end

  # As mentioned before, throw/catch are uncommon and tipically exists as stopgaps when libraries fail to provide adequate APIs

  # Exiting
  # the final error mechanism Elixir provides us is with :exit. Exit signals occurs whenerever a process dies and are important part of the fault tolerance of elixir.

  # to explicity exit we can use exit/1
  def exit_process do
    # here we link our shell process to another process which executes the exit function, thus closing the shell and starting again (if iex)
    spawn_link(fn -> exit("Oh no") end)
  end

  # while its possible to try/catch an exit, doing so is extremely rare since in almost all cases its advantageous to let the supervisor handle the process exit.
  def catch_exit do
    try do
      exit("Oh no!")
    catch
      :exit, _ -> "exit blocked"
    end
  end
end
