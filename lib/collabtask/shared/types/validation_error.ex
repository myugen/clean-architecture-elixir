defmodule Collabtask.Shared.Types.ValidationError do
  @enforce_keys [:field, :message]
  defstruct [:field, :message]

  @type t :: %__MODULE__{
          field: atom(),
          message: String.t()
        }

  def new(field, message) when is_atom(field) and is_binary(message) do
    %__MODULE__{field: field, message: message}
  end
end
