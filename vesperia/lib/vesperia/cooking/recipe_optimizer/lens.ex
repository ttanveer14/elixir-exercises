defmodule Vesperia.Cooking.RecipeOptimizer.Lens do
  def sanitize_input(store_input, visit_input) do
    with :ok <- check_store_input(store_input),
         store <- sanitize_store_input(store_input),
         :ok <- check_visit_input(visit_input),
         visit <- sanitize_visit_input(visit_input) do
      {:ok, store, visit}
    else
      {:error, msg} -> {:error, msg}
    end
  end

  def sanitize_output(optimal_recipe_combos) do
    optimal_recipe_combos
    |> Enum.map(fn {recipe_combo, conflicts} ->
      {sanitize_recipe_combo(recipe_combo), conflicts}
    end)
  end

  defp sanitize_recipe_combo(recipe_combo) do
    recipe_combo
    |> Enum.map(fn recipe ->
      recipe |> Atom.to_string() |> String.capitalize() |> String.replace("_", " ")
    end)
  end

  defp check_store_input(store_input) do
    input_valid? =
      store_input
      |> String.downcase()
      |> String.to_charlist()
      |> Enum.all?(&Enum.member?('abcdefghijklmnopqrstuvwxyz ', &1))

    if input_valid? do
      :ok
    else
      {:error, "Store input is invalid."}
    end
  end

  defp sanitize_store_input(store_input) do
    store_input
    |> String.downcase()
    |> String.trim()
    |> String.replace(" ", "_")
    |> String.to_atom()
  end

  defp check_visit_input(nil), do: :ok

  defp check_visit_input(visit_input) do
    input_valid? = Enum.member?(["0", "1", "2", "3"], String.trim(visit_input))

    if input_valid? do
      :ok
    else
      {:error, "Visit input is invalid."}
    end
  end

  defp sanitize_visit_input(nil), do: 0

  defp sanitize_visit_input(visit_input) do
    visit_input
    |> String.trim()
    |> String.to_integer()
  end
end
