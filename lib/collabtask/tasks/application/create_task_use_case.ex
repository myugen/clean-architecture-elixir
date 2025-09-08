defmodule Collabtask.Tasks.Application.CreateTaskUseCase do
  @behaviour Collabtask.Shared.Ports.CommandHandler

  alias Collabtask.Tasks.Application.Commands.CreateTaskCommand
  alias Collabtask.Tasks.Domain.Task
  alias Collabtask.Tasks.Domain.Events.TaskCreated
  alias Collabtask.Tasks.Ports.TaskRepository
  alias Collabtask.Shared.Ports.IdGenerator
  alias Collabtask.Shared.Types.Result

  @type dependencies :: %{
          id_generator: IdGenerator.t(),
          task_repository: TaskRepository.t()
        }

  @type handle_result :: Result.t(TaskCreated.t(), term())

  @impl Collabtask.Shared.Ports.CommandHandler
  @spec handle(CreateTaskCommand.t(), dependencies()) :: handle_result()
  def handle(%CreateTaskCommand{params: params}, %{
        id_generator: id_generator,
        task_repository: task_repository
      }) do
    with {:ok, {task, event}} <- Task.create(params, id_generator),
         {:ok, _saved_task} <- task_repository.save(task) do
      {:ok, event}
    else
      {:error, {:validation_error, field, message}} ->
        {:error, {:validation_failed, {field, message}}}

      {:error, reason} ->
        {:error, {:repository_error, reason}}
    end
  end
end
