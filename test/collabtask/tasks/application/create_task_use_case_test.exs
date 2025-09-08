defmodule Collabtask.Tasks.Application.CreateTaskUseCaseShould do
  use ExUnit.Case
  alias Collabtask.Tasks.Application.CreateTaskUseCase
  alias Collabtask.Tasks.Application.Commands.CreateTaskCommand
  alias Collabtask.Tasks.Domain.Dtos.CreateTaskParams
  alias Collabtask.Tasks.Domain.ValueObjects.TaskId
  alias Collabtask.Tasks.Ports.TaskRepository
  alias Collabtask.Shared.Ports.IdGenerator

  defmodule FakeIdGenerator do
    @behaviour IdGenerator

    @impl IdGenerator
    def generate, do: "generated-id"
  end

  defmodule FakeTaskRepository do
    @behaviour TaskRepository

    @impl TaskRepository
    def save(task), do: {:ok, task}

    @impl TaskRepository
    def find_by_id(_id), do: {:error, :not_found}

    @impl TaskRepository
    def exists?(_id), do: false
  end

  defmodule FailingTaskRepository do
    @behaviour TaskRepository

    @impl TaskRepository
    def save(_task), do: {:error, :database_error}

    @impl TaskRepository
    def find_by_id(_id), do: {:error, :not_found}

    @impl TaskRepository
    def exists?(_id), do: false
  end

  describe "handle/2" do
    test "successfully creates task with valid input" do
      params = %CreateTaskParams{
        title: "Test Task",
        description: "This is a test task."
      }

      command = %CreateTaskCommand{params: params}

      dependencies = %{
        id_generator: FakeIdGenerator,
        task_repository: FakeTaskRepository
      }

      result = CreateTaskUseCase.handle(command, dependencies)

      assert {:ok, task_created_event} = result
      assert task_created_event.task_id == TaskId.from("generated-id")
      assert task_created_event.title == "Test Task"
      assert task_created_event.description == "This is a test task."
      assert task_created_event.status == :todo
      assert %DateTime{} = task_created_event.ocurred_at
    end

    test "returns validation error for empty title" do
      params = %CreateTaskParams{
        title: "",
        description: "This is a test task."
      }

      command = %CreateTaskCommand{params: params}

      dependencies = %{
        id_generator: FakeIdGenerator,
        task_repository: FakeTaskRepository
      }

      result = CreateTaskUseCase.handle(command, dependencies)

      assert {:error, {:validation_failed, {:title, _message}}} = result
    end

    test "returns validation error for whitespace-only description" do
      params = %CreateTaskParams{
        title: "Test Task",
        description: "   "
      }

      command = %CreateTaskCommand{params: params}

      dependencies = %{
        id_generator: FakeIdGenerator,
        task_repository: FakeTaskRepository
      }

      result = CreateTaskUseCase.handle(command, dependencies)

      assert {:error, {:validation_failed, {:description, _message}}} = result
    end

    test "returns repository error when save fails" do
      params = %CreateTaskParams{
        title: "Test Task",
        description: "This is a test task."
      }

      command = %CreateTaskCommand{params: params}

      dependencies = %{
        id_generator: FakeIdGenerator,
        task_repository: FailingTaskRepository
      }

      result = CreateTaskUseCase.handle(command, dependencies)

      assert {:error, {:repository_error, :database_error}} = result
    end
  end

  test "implements CommandHandler behaviour" do
    assert function_exported?(CreateTaskUseCase, :handle, 2)
  end
end
