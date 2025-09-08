defmodule Collabtask.Tasks.Domain.TaskShould do
  use ExUnit.Case
  alias Collabtask.Tasks.Domain.ValueObjects.TaskId
  alias Collabtask.Tasks.Domain.Dtos.CreateTaskParams
  alias Collabtask.Tasks.Domain.Task
  alias Collabtask.Shared.Ports.IdGenerator

  defmodule FakeIdGenerator do
    @behaviour IdGenerator

    @impl IdGenerator
    def generate() do
      "generated-id"
    end
  end

  test "create task with valid params" do
    result =
      Task.create(
        %CreateTaskParams{title: "Test Task", description: "This is a test task."},
        FakeIdGenerator
      )

    assert {:ok, {task, task_created_event}} = result

    assert task.id == TaskId.from("generated-id")
    assert task.title == "Test Task"
    assert task.description == "This is a test task."
    assert task.status == :todo

    assert task_created_event.task_id == TaskId.from("generated-id")
    assert task_created_event.title == "Test Task"
    assert task_created_event.description == "This is a test task."
    assert task_created_event.status == :todo
  end

  test "create task fails with empty title" do
    result =
      Task.create(
        %CreateTaskParams{title: "", description: "This is a test task."},
        FakeIdGenerator
      )

    assert {:error, {:validation_error, :title, _message}} = result
  end

  test "create task fails with whitespace-only description" do
    result =
      Task.create(
        %CreateTaskParams{title: "Test Task", description: "   "},
        FakeIdGenerator
      )

    assert {:error, {:validation_error, :description, _message}} = result
  end

  test "create task fails with non-string title" do
    result =
      Task.create(
        %CreateTaskParams{title: nil, description: "This is a test task."},
        FakeIdGenerator
      )

    assert {:error, {:validation_error, :title, _message}} = result
  end
end
