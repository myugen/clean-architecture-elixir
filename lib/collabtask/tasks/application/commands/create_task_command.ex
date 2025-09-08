defmodule Collabtask.Tasks.Application.Commands.CreateTaskCommand do
  @enforce_keys [:params]
  defstruct [:params]

  @type t :: %__MODULE__{
          params: Collabtask.Tasks.Domain.Dtos.CreateTaskParams.t()
        }
end
