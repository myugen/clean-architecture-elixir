defmodule Collabtask.Tasks.Ports.TaskRepository do
  alias Collabtask.Tasks.Domain.Task
  alias Collabtask.Tasks.Domain.ValueObjects.TaskId

  @type t :: module()

  @callback save(Task.t()) :: {:ok, Task.t()} | {:error, term()}
  @callback find_by_id(TaskId.t()) :: {:ok, Task.t()} | {:error, :not_found}
  @callback exists?(TaskId.t()) :: boolean()
end
