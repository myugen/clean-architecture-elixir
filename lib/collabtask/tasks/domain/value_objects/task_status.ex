defmodule Collabtask.Tasks.Domain.ValueObjects.TaskStatus do
  @type t :: :todo | :in_progress | :done

  @spec to_string(t) :: String.t()
  def to_string(:todo), do: "todo"
  def to_string(:in_progress), do: "in_progress"
  def to_string(:done), do: "done"

  @spec from_string(String.t()) :: t
  def from_string("todo"), do: :todo
  def from_string("in_progress"), do: :in_progress
  def from_string("done"), do: :done
end
