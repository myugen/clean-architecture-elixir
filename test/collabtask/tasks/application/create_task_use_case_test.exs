defmodule Collabtask.Tasks.Application.CreateTaskUseCaseShould do
  use ExUnit.Case
  alias Collabtask.Tasks.Application.CreateTaskUseCase
  alias Collabtask.Tasks.Application.Commands.CreateTaskCommand
  alias Collabtask.Tasks.Domain.Dtos.CreateTaskParams
  alias Collabtask.Tasks.Domain.ValueObjects.TaskId
  alias Collabtask.Shared.Ports.IdGenerator

  defmodule FakeIdGenerator do
    @behaviour IdGenerator

    @impl IdGenerator
    def generate() do
      "generated-id"
    end
  end

  test "handle create task command" do
    params = %CreateTaskParams{
      title: "Test Task",
      description: "This is a test task."
    }

    command = %CreateTaskCommand{params: params}
    dependencies = %{id_generator: FakeIdGenerator}

    task_created_event = CreateTaskUseCase.handle(command, dependencies)

    assert task_created_event.task_id == TaskId.from("generated-id")
    assert task_created_event.title == "Test Task"
    assert task_created_event.description == "This is a test task."
    assert task_created_event.status == :todo
    assert %DateTime{} = task_created_event.ocurred_at
  end

  test "implements CommandHandler behaviour" do
    assert function_exported?(CreateTaskUseCase, :handle, 2)
  end
end
