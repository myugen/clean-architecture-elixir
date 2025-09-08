defmodule Collabtask.Tasks.Domain.Events.TaskCreated do
  alias Collabtask.Tasks.Domain.ValueObjects.TaskId

  @enforce_keys [:task_id, :title, :description, :status, :ocurred_at]
  defstruct [:task_id, :title, :description, :status, :ocurred_at]

  @type t :: %__MODULE__{
          task_id: TaskId.t(),
          title: String.t(),
          description: String.t(),
          status: String.t(),
          ocurred_at: DateTime.t()
        }

  def new(task_id, title, description, status) do
    %__MODULE__{
      task_id: task_id,
      title: title,
      description: description,
      status: status,
      ocurred_at: DateTime.utc_now()
    }
  end
end
