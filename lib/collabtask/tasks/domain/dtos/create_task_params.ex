defmodule Collabtask.Tasks.Domain.Dtos.CreateTaskParams do
  @enforce_keys [:title, :description]
  defstruct [:title, :description]

  @type t :: %__MODULE__{
          title: String.t(),
          description: String.t()
        }
end
