defmodule Collabtask.Tasks.Domain.ValueObjects.TaskStatus do
  @type t :: :todo | :in_progress | :done

  @spec to_string(t) :: String.t()
  def to_string(:todo), do: "todo"
  def to_string(:in_progress), do: "in_progress"
  def to_string(:done), do: "done"

  @spec from_string(String.t()) :: {:ok, t} | {:error, :invalid_status}
  def from_string("todo"), do: {:ok, :todo}
  def from_string("in_progress"), do: {:ok, :in_progress}
  def from_string("done"), do: {:ok, :done}
  def from_string(_), do: {:error, :invalid_status}

  @spec todo() :: t
  def todo, do: :todo

  @spec in_progress() :: t
  def in_progress, do: :in_progress

  @spec done() :: t
  def done, do: :done
end
