defmodule Collabtask.Tasks.Domain.Task do
  alias Collabtask.Tasks.Domain.Dtos.CreateTaskParams
  alias Collabtask.Tasks.Domain.ValueObjects.{TaskId, TaskStatus}
  alias Collabtask.Tasks.Domain.Events.TaskCreated
  alias Collabtask.Shared.Ports.IdGenerator

  @enforce_keys [:id, :title, :description, :status]
  defstruct [:id, :title, :description, :status]

  @type t :: %__MODULE__{
          id: TaskId.t(),
          title: String.t(),
          description: String.t(),
          status: TaskStatus.t()
        }

  @spec create(CreateTaskParams.t(), IdGenerator.t()) :: TaskCreated.t()
  def create(%CreateTaskParams{title: title, description: description}, id_generator) do
    id = TaskId.generate(id_generator)

    %__MODULE__{
      id: id,
      title: title,
      description: description,
      status: TaskStatus.from_string("todo")
    }

    TaskCreated.new(id, title, description, :todo)
  end
end
