defmodule ExpenseManager do
  @moduledoc false
  defstruct(title: "", date: nil, amount: 0, store: "")

  @type t :: %ExpenseManager{
          title: String.t(),
          date: Date.t() | nil,
          amount: number(),
          store: String.t()
        }

  @spec sample() :: [t()]
  def sample do
    [
      %ExpenseManager{title: "Grocery", date: ~D[2023-09-22], amount: 18.99, store: "Metro"},
      %ExpenseManager{title: "Mobile", date: ~D[2022-10-22], amount: 55.65, store: "Bell"},
      %ExpenseManager{title: "Jacket", date: ~D[2022-07-06], amount: 150.99, store: "Marks"},
      %ExpenseManager{title: "Air Jordan", date: ~D[2022-10-30], amount: 799.99, store: "Nike"}
    ]
  end

  @spec total([t()]) :: number()
  def total([%ExpenseManager{} = _ | _] = expenses) do
    Enum.reduce(expenses, 0, fn expense, acc -> expense.amount + acc end)
  end

  @spec sort_by_date([t()]) :: [t()]
  def sort_by_date([%ExpenseManager{} = _ | _] = expenses) do
    Enum.sort_by(expenses, & &1.date, Date)
  end

  @spec add_expense(t(), [t()]) :: [t()]
  def add_expense(%ExpenseManager{} = new_expense, [%ExpenseManager{} = _ | _] = expenses) do
    [new_expense | expenses]
  end

  @spec update_amount(String.t(), number(), [t()]) :: [t()]
  def update_amount(title, amount, expenses) do
    [item] =
      Enum.filter(expenses, fn %ExpenseManager{title: expense_title} -> expense_title == title end)

    new_item = %{item | amount: amount}

    [new_item | expenses |> List.delete(item)]
  end
end
