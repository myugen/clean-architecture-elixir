defmodule Collabtask.Tasks.Domain.TaskShould do
  use ExUnit.Case
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

  test "create task" do
    task_created_event =
      Task.create(
        %CreateTaskParams{title: "Test Task", description: "This is a test task."},
        FakeIdGenerator
      )

    assert task_created_event.task_id == "generated-id"
    assert task_created_event.title == "Test Task"
    assert task_created_event.description == "This is a test task."
    assert task_created_event.status == :todo
  end
end
