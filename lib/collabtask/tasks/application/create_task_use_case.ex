defmodule Collabtask.Tasks.Application.CreateTaskUseCase do
  @behaviour Collabtask.Shared.Ports.CommandHandler

  alias Collabtask.Tasks.Application.Commands.CreateTaskCommand
  alias Collabtask.Tasks.Domain.Task
  alias Collabtask.Tasks.Domain.Events.TaskCreated
  alias Collabtask.Shared.Ports.IdGenerator

  @type dependencies :: %{
          id_generator: IdGenerator.t()
        }

  @impl Collabtask.Shared.Ports.CommandHandler
  @spec handle(CreateTaskCommand.t(), dependencies()) :: TaskCreated.t()
  def handle(%CreateTaskCommand{params: params}, %{id_generator: id_generator}) do
    Task.create(params, id_generator)
  end
end
