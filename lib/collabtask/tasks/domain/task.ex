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

  @spec create(CreateTaskParams.t(), IdGenerator.t()) ::
          {:ok, {t(), TaskCreated.t()}} | {:error, term()}
  def create(%CreateTaskParams{title: title, description: description}, id_generator) do
    with :ok <- validate_title(title),
         :ok <- validate_description(description) do
      id = TaskId.generate(id_generator)
      status = TaskStatus.todo()

      task = %__MODULE__{
        id: id,
        title: title,
        description: description,
        status: status
      }

      event = TaskCreated.new(id, title, description, status)

      {:ok, {task, event}}
    end
  end

  defp validate_title(title) when is_binary(title) and byte_size(title) > 0 do
    if String.length(String.trim(title)) > 0 do
      :ok
    else
      {:error, {:validation_error, :title, "cannot be empty or only whitespace"}}
    end
  end

  defp validate_title(_title) do
    {:error, {:validation_error, :title, "is required and must be a string"}}
  end

  defp validate_description(description)
       when is_binary(description) and byte_size(description) > 0 do
    if String.length(String.trim(description)) > 0 do
      :ok
    else
      {:error, {:validation_error, :description, "cannot be empty or only whitespace"}}
    end
  end

  defp validate_description(_description) do
    {:error, {:validation_error, :description, "is required and must be a string"}}
  end
end
