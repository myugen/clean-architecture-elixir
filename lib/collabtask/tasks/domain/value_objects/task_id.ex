defmodule Collabtask.Tasks.Domain.ValueObjects.TaskId do
  @enforce_keys [:value]
  defstruct [:value]

  @type t :: %__MODULE__{value: String.t()}

  @spec generate(Collabtask.Shared.Ports.IdGenerator.t()) :: t
  def generate(id_generator) do
    id = id_generator.generate()
    %__MODULE__{value: id}
  end

  @spec from(String.t()) :: t
  def from(value) when is_binary(value), do: %__MODULE__{value: value}

  @spec to_string(t) :: String.t()
  def to_string(%__MODULE__{value: value}) when is_binary(value), do: value
end
