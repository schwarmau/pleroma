# Pleroma: A lightweight social networking server
# Copyright © 2017-2020 Pleroma Authors <https://pleroma.social/>
# SPDX-License-Identifier: AGPL-3.0-only

defmodule Pleroma.Tests.Helpers do
  @moduledoc """
  Helpers for use in tests.
  """
  alias Pleroma.Config

  defmacro clear_config(config_path) do
    quote do
      clear_config(unquote(config_path)) do
      end
    end
  end

  defmacro clear_config(config_path, do: yield) do
    quote do
      setup do
        initial_setting = Config.get(unquote(config_path))
        unquote(yield)
        on_exit(fn -> Config.put(unquote(config_path), initial_setting) end)
        :ok
      end
    end
  end

  @doc "Stores initial config value and restores it after *all* test examples are executed."
  defmacro clear_config_all(config_path) do
    quote do
      clear_config_all(unquote(config_path)) do
      end
    end
  end

  @doc """
  Stores initial config value and restores it after *all* test examples are executed.
  Only use if *all* test examples should work with the same stubbed value
  (*no* examples set a different value).
  """
  defmacro clear_config_all(config_path, do: yield) do
    quote do
      setup_all do
        initial_setting = Config.get(unquote(config_path))
        unquote(yield)
        on_exit(fn -> Config.put(unquote(config_path), initial_setting) end)
        :ok
      end
    end
  end

  defmacro __using__(_opts) do
    quote do
      import Pleroma.Tests.Helpers,
        only: [
          clear_config: 1,
          clear_config: 2,
          clear_config_all: 1,
          clear_config_all: 2
        ]

      def to_datetime(naive_datetime) do
        naive_datetime
        |> DateTime.from_naive!("Etc/UTC")
        |> DateTime.truncate(:second)
      end

      def collect_ids(collection) do
        collection
        |> Enum.map(& &1.id)
        |> Enum.sort()
      end

      def refresh_record(%{id: id, __struct__: model} = _),
        do: refresh_record(model, %{id: id})

      def refresh_record(model, %{id: id} = _) do
        Pleroma.Repo.get_by(model, id: id)
      end

      # Used for comparing json rendering during tests.
      def render_json(view, template, assigns) do
        assigns = Map.new(assigns)

        view.render(template, assigns)
        |> Poison.encode!()
        |> Poison.decode!()
      end

      def stringify_keys(nil), do: nil

      def stringify_keys(key) when key in [true, false], do: key
      def stringify_keys(key) when is_atom(key), do: Atom.to_string(key)

      def stringify_keys(map) when is_map(map) do
        map
        |> Enum.map(fn {k, v} -> {stringify_keys(k), stringify_keys(v)} end)
        |> Enum.into(%{})
      end

      def stringify_keys([head | rest] = list) when is_list(list) do
        [stringify_keys(head) | stringify_keys(rest)]
      end

      def stringify_keys(key), do: key

      defmacro guards_config(config_path) do
        quote do
          initial_setting = Config.get(config_path)

          Config.put(config_path, true)
          on_exit(fn -> Config.put(config_path, initial_setting) end)
        end
      end
    end
  end
end
