defmodule ModulesContent do
  # modules allow us to organize our functions in a namespace, they permit define named and private functions

  def hello, do: "Hello, World!"
  # ModulesContent.hello() => $ Hello, World!

  # it's possible to nest modules inside another, allowing to further namespace your functionality
  defmodule SubModule do
    def nested_function, do: "This is running in a nested module"
  end

  # module attribs, used as consts in elixir
  @greeting "Hello"
  def greet(name) do
    # weird way to use strings in elixir
    ~s(#{@greeting} #{name})
  end

  # there are reserved attributes however, the three most common are:
  # - moduledoc — Documents the current module.
  # - doc — Documentation for functions and macros.
  # - behaviour — Use an OTP or user-defined behaviour.

  # Structs:
  # special maps with defined set of key-value values, A struct must be within a module, which it takes its names from, it's common to a struct be the only thing defined in a module.

  # only names are avaible to IO.inspect()
  @derive {Inspect, only: [:name]}
  defstruct name: "John Doe", roles: []
  # iex(35)> %ModulesContent{} -> to access a struct
  # #ModulesContent<name: "John Doe", ...>
  # you can update structs however you like, similar to a map
  # most importantly, you can match structs against maps

  # Compositions:
  # alias: allow us to alias modules names

  defmodule Sayings.Greetings do
    def basic(name), do: "Hi, #{name}"
  end

  defmodule Sayings.Farewells do
    def basic(name), do: "Bye, #{name}"
  end

  # with alias:
  defmodule ExampleWithAlias do
    alias Sayings.Greetings
    def greeting(name), do: Greetings.basic(name)
  end

  defmodule ExampleWithoutAlias do
    def greeting(name), do: Sayings.Greetings.basic(name)
  end

  # if there is a conflict between alias, you can use the :as option

  defmodule Example do
    alias Sayings.Greetings, as: Hi
    def greeting(name), do: Hi.basic(name)
  end

  defmodule AnotherExample do
    # multiple aliases at once
    alias Sayings.{Greetings, Farewells}
  end

  # Import
  # if you wanna import functions instead of aliasing the mod, you can use import

  defmodule ImportModuleFunctions do
    def test, do: "Test"
    def test2, do: "Test2"
    def test3, do: "Test3"
  end

  defmodule ImportModuleExample do
    import ImportModuleFunctions
    def run(), do: test()
  end

  # filtering imports
  defmodule ImportModuleAnotherExample do
    # function name: arity
    import ImportModuleFunctions, except: [test2: 0]
    # def run(), do: test2() this give error because we are importing anything except test2/0
    def run(), do: test()

    # in addition to the name/arity pairs there are two special atoms, :functions and :macros, which import only functions and macros respectively:
  end

  # Require:
  # same as import however imports only macros

  # Use:
  # enable another module to modify our current module definition, when we call use in our code we’re actually invoking the __using__/1 callback defined by the provided module. The result of the __using__/1 macro becomes part of our module’s definition. To get a better understanding how this works let’s look at a simple example:

  defmodule UseHello do
    defmacro __using__(_opts) do
      quote do
        def hello(name), do: "Hi, #{name}"
      end
    end
  end

  defmodule UseExample do
    use UseHello
    # now UseExample.hello(name) will work!
  end

  # we can pass options as well on :use

  defmodule SecondUseHello do
    defmacro __using__(opts) do
      greeting = Keyword.get(opts, :greeting, "Hi")

      quote do
        def hello(name), do: "#{unquote(greeting)}, #{name}"
      end
    end
  end

  defmodule SecondUseExample do
    use SecondUseHello, greeting: "Hola"
  end

  defmodule SecondAnotherUseExample do
    use SecondUseHello, greeting: "Konnichiwa"
  end

  defmodule SecondOtherUseExample do
    use SecondUseHello
  end
end

# another way to nest is to use .
defmodule ModulesContent.AnotherSubModule do
  def another_nested_function, do: "This is running in a another nested mod"
end
